
do
	local passed, failed = 0, 0
	
	function assertTrue (condition, message)
		if not condition then 
			failed = failed + 1
			print (message)
		else
			passed = passed + 1
		end
		
		return condition
	end
	
	
	function showResults ()		
		print "\n------------------------"
		if failed == 0 then
			print " Passed."
		else
			print "FAILED!"
		end

		print "------------------------\n"		
		print ("Total asserts: "..(passed + failed).."; Passed: "..passed.."; Failed: "..failed)
	end

end


local a = 1
assertTrue (a == 1, 'Local should retain value')

local a, b = 5, 20
assertTrue (a == 5, 'Local should change value')
assertTrue (b == 20, 'Local should accept multiple assignments')

local result = a + b
assertTrue (result == 25, 'Plus operator should result in addition of operands')

result = a - b
assertTrue (result == -15, 'Minus operator should result in subtraction of operands')

result = a * b
assertTrue (result == 100, 'Asterisk operator should result in multiplication of operands')

result = b / a
assertTrue (result == 4, 'Slash operator should result in division of operands')

result = a / b
assertTrue (result == .25, 'Division should handle floating point results')

result = 5 % 3
assertTrue (result == 2, 'Modulo operator should return the remainder of the division of the two operands')


assertTrue (a == a, 'Equality operator should return true if first operand is equal to second')
assertTrue (not (a == b), 'Equality operator should return false if first operand is not equal to second')

assertTrue (a < b, 'Less than should return true if first operand is less than second')
assertTrue (not (a < a), 'Less than should return false if first operand is equal to second')
assertTrue (not (b < a), 'Less than should return false if first operand is greater than second')

assertTrue (b > a, 'Greater than should return true if first operand is Greater than second')
assertTrue (not (a > a), 'Greater than should return false if first operand is equal to second')
assertTrue (not (a > b), 'Greater than should return false if first operand is less than second')

assertTrue (a <= b, 'Less than or equal to should return true if first operand is less than second')
assertTrue (a <= a, 'Less than or equal to should return true if first operand is equal to second')
assertTrue (not (b <= a), 'Less than or equal to should return false if first operand is greater than second')

assertTrue (b >= a, 'Greater than or equal to should return true if first operand is Greater than second')
assertTrue (a >= a, 'Greater than or equal to should return true if first operand is equal to second')
assertTrue (not (a >= b), 'Greater than or equal to should return false if first operand is less than second')


function addOne ()
	assertTrue (b == 20, 'Functions should be able to access locals of parent closures [1]')
	
	function nested ()
		assertTrue (b == 20, 'Functions should be able to access locals of parent closures [2]')
		
		local c = 9
		assertTrue (c == 9, 'Functions should be able to access their own locals')
	end
	
	nested ()
	assertTrue (c == nil, 'Function locals should not be accessible from outside the function')
	
	b = b + 1
	assertTrue (b == 21, 'Operations performed on upvalues should use external value')
end

addOne ()
assertTrue (b == 21, 'Operations performed on upvalues in functions should affect the external value too')


function f (...)
	local a, b, c = ...	
	assertTrue (a == -1, 'Varargs should pass values around correctly [1]')
	assertTrue (b == 0, 'Varargs should pass values around correctly [2]')
	assertTrue (c == 2, 'Varargs should pass values around correctly [3]')

	local d, e, f, g, h = ...
	assertTrue (d == -1, 'Varargs should pass values around correctly [4]')
	assertTrue (e == 0, 'Varargs should pass values around correctly [5]')
	assertTrue (f == 2, 'Varargs should pass values around correctly [6]')
	assertTrue (g == 9, 'Varargs should pass values around correctly [7]')
	assertTrue (h == nil, 'Varargs should pass nil for list entries beyond its length')
end

f(-1,0,2,9)


function g (a, ...)
	local b, c = ...	
	assertTrue (a == -1, 'Varargs should pass values around correctly [8]')
	assertTrue (b == 0, 'Varargs should pass values around correctly [9]')
	assertTrue (c == 2, 'Varargs should pass values around correctly [10]')
end

g(-1,0,2,9)


function h (a, b, ...)
	local c = ...	
	assertTrue (a == -1, 'Varargs should pass values around correctly [11]')
	assertTrue (b == 0, 'Varargs should pass values around correctly [12]')
	assertTrue (c == 2, 'Varargs should pass values around correctly [13]')
end

h(-1,0,2,9)


assertTrue (true and true, 'And operator should return true if both operands are true')
assertTrue (not (false and true), 'And operator should return false if first operand is false')
assertTrue (not (true and false), 'And operator should return false if second operand is false')
assertTrue (not (false and false), 'And operator should return false if both operands are false')

assertTrue (true or true, 'Or operator should return true if both operands are true')
assertTrue (false or true, 'Or operator should return true even if first operand is false')
assertTrue (true or false, 'Or operator should return true even if second operand is false')
assertTrue (not (false or false), 'Or operator should return false if both operands are false')


local a, b, i = 0, 0, 0

for i = 1, 5 do
	a = a + 1
	b = b + i
end

assertTrue (a == 5, 'For loop should iterate the correct number of times')
assertTrue (b == 15, 'For loop variable should hold the value of the current iteration')


a = {1,2,3,4}
b = a

assertTrue (a == b, 'Tables should be able to be compared by identity')
assertTrue (not (a == {1,2,3,4}), 'Tables should not be able to be compared to literals')
assertTrue (#a == 4, 'Length operator should return the number of items in a table')


assertTrue (a[1] == 1, 'Square brackets operation on table should return correct value for index [1]')
assertTrue (a[2] == 2, 'Square brackets operation on table should return correct value for index [2]')
assertTrue (a[3] == 3, 'Square brackets operation on table should return correct value for index [3]')
assertTrue (a[4] == 4, 'Square brackets operation on table should return correct value for index [4]')
assertTrue (a[5] == nil, 'Square brackets operation on table should return nil for an index greater than the length')
assertTrue (a[0] == nil, 'Square brackets operation on table should return nil for an index of 0')
assertTrue (a[-1] == nil, 'Square brackets operation on table should return nil for an index less than 0')


a = {[1] = 20, [3] = 40}
assertTrue (a[1] == 20, 'Square brackets operation on table should return correct value for index when keys are used in literal assignment [1]')
assertTrue (a[2] == nil, 'Square brackets operation on table should return correct value for index when keys are used in literal assignment [2]')
assertTrue (a[3] == 40, 'Square brackets operation on table should return correct value for index when keys are used in literal assignment [3]')
assertTrue (a[4] == nil, 'Square brackets operation on table should return correct value for index when keys are used in literal assignment [4]')



function getFunc ()
	local b = 6
	return function () return b end
end

x = getFunc () ()
assertTrue (x == 6, 'Functions should be able to return functions (and maintain their scope)')



function add (val1)
	return function (val2) return val1 + val2 end
end

local addThree = add (3)
x = addThree (4)

assertTrue (x == 7, 'Functions should be able to be curried')



b = {}

for i = 1, 3 do
	local c = i
	b[i] = function() return c end
end

assertTrue (b[1]() == 1, 'Local within a closure should keep its value [1]')
assertTrue (b[2]() == 2, 'Local within a closure should keep its value [2]')
assertTrue (b[3]() == 3, 'Local within a closure should keep its value [3]')




-- Coercion

assertTrue (0, 'Zero should coerce to true.')
assertTrue (1, 'Positive number should coerce to true.')
assertTrue (-1, 'Negative number should coerce to true.')
assertTrue ('Test', 'String should coerce to true.')
assertTrue ('', 'Empty string should coerce to true.')

assertTrue (not (nil), 'Nil should coerce to false.')
assertTrue (not (false), 'False should be false.')
assertTrue (not (10 == '10'), 'String should coerce to number.')





-- TABLES


Account = { balance = 0 }

function Account:new (o)
	o = o or {}
	setmetatable (o,self)
	self.__index = self
	return o
end 

function Account:deposit (v)
	self.balance = self.balance + v
end

function Account:withdraw (v)
	if v > self.balance then error "insufficient funds" end
	self.balance = self.balance - v
end


acc = Account:new ()


assertTrue (acc.balance == 0, 'Class properties should be initiated when instantiated [1]')

acc:deposit (20)
assertTrue (acc.balance == 20, 'Class instance properties should be updatable though instance method calls [1]')

acc:withdraw (5)
assertTrue (acc.balance == 15, 'Class instance properties should maintain their value in the instance')


acc2 = Account:new ()

assertTrue (acc2.balance == 0, 'Class properties should be initiated when instantiated [2]')

acc2:deposit (50)
assertTrue (acc2.balance == 50, 'Class instance properties should be updatable though instance method calls [2]')
assertTrue (acc.balance == 15, 'Class instance properties should maintain their value separate to other instances')



SpecialAccount = Account:new ()

function SpecialAccount:withdraw (v)
	if v - self.balance >= self:getLimit () then
		error "insufficient funds"
	end
	
	self.balance = self.balance - v
end

function SpecialAccount:getLimit ()
	return self.limit or 0
end


s = SpecialAccount:new {limit=1000.00}

assertTrue (s.balance == 0, 'Class properties should be initiated when instantiated, even if class is inherited')
assertTrue (s:getLimit () == 1000, 'Inherited class should have its own properties')
assertTrue (acc.getLimit == nil, 'Base class properties should not change when inherited class manipulated')

s:deposit (500)
assertTrue (s.balance == 500, 'Class instance properties should be updatable though instance method calls [3]')


function f () 
	return 1, 3, 9
end

local t = {f()}

assertTrue (t[1] == 1, 'Table should be able to be instantiated by the result of a function [1]')
assertTrue (t[2] == 3, 'Table should be able to be instantiated by the result of a function [2]')
assertTrue (t[3] == 9, 'Table should be able to be instantiated by the result of a function [3]')





-------------
-- LIBRARY --
-------------


-- BASIC FUNCTIONS


-- assert

local t, m = assert (true, 'Assert should not error when passed a true value')	-- Can't test any further as we can't catch errors

assertTrue (t, 'Assert should return the passed expression as the first value')
assertTrue (m == 'Assert should not error when passed a true value', 'Assert should return the passed message as the second value')




-- getmetatable
-- TODO


function paul1 ()
	function paul2 ()
		local a = 'a'..6
	end
	
	paul2 ()
end
paul1 ()


-- ipairs

local a = {2,4,8}
local b = ''

for i, v in ipairs(a) do
	b = b..'['..i..'='..v..']'
end

assertTrue (b == '[1=2][2=4][3=8]', 'ipairs() should iterate over table items [1]')




-- pairs

local a, b = "", {foo=1}
b["bar"] = "Hello"

for i, v in pairs(b) do
	a = a..i..':'..v..';'
end

assertTrue (#a == #'bar:Hello;foo:1;', 'pairs() should iterate over table items [2]')	-- Have to compare lengths because order is arbitrary




-- pcall

function goodfunc (x) 
	return x + 1, x + 2
end 

function badfunc ()
	error ('I\'m bad.')
end 

a, b, c = pcall (goodfunc, 6)

assertTrue (a == true, 'pcall() should return true in the first item when a function executes successfully')
assertTrue (b == 7, 'pcall() should return the result of the function in the items following the first item returned, when a function executes successfully [1]')
assertTrue (c == 8, 'pcall() should return the result of the function in the items following the first item returned, when a function executes successfully [2]')


a, b, c = pcall (badfunc, 6)

assertTrue (a == false, 'pcall() should return false in the first item when the function errors during execution')
assertTrue (not (b == nil), 'pcall() should return an error message in the second item when the function error during execution')
assertTrue (c == nil, 'pcall() should only return 2 items when the function error during execution')




-- rawequal
-- rawget
-- rawset

-- TODO




-- select

local a, b, c, d = select (3, 2, 4, 6, 8, 10)

assertTrue (a == 6, 'select() should return its own arguments from the (n + 1)th index, where n is the value of the first argument [1]')
assertTrue (b == 8, 'select() should return its own arguments from the (n + 1)th index, where n is the value of the first argument [2]')
assertTrue (c == 10, 'select() should return its own arguments from the (n + 1)th index, where n is the value of the first argument [3]')
assertTrue (d == nil, 'select() should return its own arguments from the (n + 1)th index, where n is the value of the first argument [4]')


local a, b = select ('#', 2, 4, 6, 8, 10)

assertTrue (a == 5, 'select() should return the total number of arguments - 1, when the first argument is "#" [1]')
assertTrue (b == nil, 'select() should return the total number of arguments - 1, when the first argument is "#" [2]')


local f = function ()
	local x, y = select ('moo', 2, 4, 6, 8, 10)
end

local a, b = pcall (f)

assertTrue (a == false, 'select() should error if the first argument is not a number or a string with the value of "#"')




-- setmetatable
-- TODO




-- tonumber

local a = tonumber ('1234')
local b = tonumber ('1234 ')
local c = tonumber (' 1234 ')
local d = tonumber ('1234abc')
local e = tonumber ('1234 12')
local f = tonumber ('1.234')
local g = tonumber ('1.234e+5')
local h = tonumber ('1.234e-5')

assertTrue (a == 1234, 'tonumber() should convert basic numeric strings to decimal and default to base 10')
assertTrue (b == 1234, 'tonumber() should convert numeric strings suffixed with spaces [1]')
assertTrue (c == 1234, 'tonumber() should convert numeric strings prefixed with spaces [1]')
assertTrue (d == nil, 'tonumber() should not convert strings containing letters [1]')
assertTrue (e == nil, 'tonumber() should not convert numeric strings containing spaces in the middle [1]')
assertTrue (f == 1.234, 'tonumber() should convert numeric strings of floating point numbers at base 10 [1]')
assertTrue (g == 123400, 'tonumber() should convert numeric strings of exponential (+ve) numbers at base 10 [1]')
assertTrue (h == 0.00001234, 'tonumber() should convert numeric strings of exponential (-ve) numbers at base 10 [1]')


local a = tonumber ('1234', 10)
local b = tonumber ('1234 ', 10)
local c = tonumber (' 1234 ', 10)
local d = tonumber ('1234abc', 10)
local e = tonumber ('1234 12', 10)
local f = tonumber ('1.234', 10)
local g = tonumber ('1.234e+5', 10)
local h = tonumber ('1.234e-5', 10)

assertTrue (a == 1234, 'tonumber() should convert basic numeric strings to decimal with base 10')
assertTrue (b == 1234, 'tonumber() should convert numeric strings suffixed with spaces [2]')
assertTrue (c == 1234, 'tonumber() should convert numeric strings prefixed with spaces [2]')
assertTrue (d == nil, 'tonumber() should not convert strings containing letters [2]')
assertTrue (e == nil, 'tonumber() should not convert numeric strings containing spaces in the middle [2]')
assertTrue (f == 1.234, 'tonumber() should convert numeric strings of floating point numbers at base 10 [2]')
assertTrue (g == 123400, 'tonumber() should convert numeric strings of exponential (+ve) numbers at base 10 [2]')
assertTrue (h == 0.00001234, 'tonumber() should convert numeric strings of exponential (-ve) numbers at base 10 [2]')


local a = tonumber ('101', 2)
local b = tonumber ('101 ', 2)
local c = tonumber (' 101 ', 2)
local d = tonumber ('101abc', 2)
local e = tonumber ('101 10', 2)
local f = tonumber ('101.10', 2)
local g = tonumber ('1.01e+10', 2)

assertTrue (a == 5, 'tonumber() should convert basic numeric strings to decimal with base 2')
assertTrue (b == 5, 'tonumber() should convert numeric strings suffixed with spaces with base 2')
assertTrue (c == 5, 'tonumber() should convert numeric strings prefixed with spaces with base 2')
assertTrue (d == nil, 'tonumber() should not convert strings containing letters with base 2')
assertTrue (e == nil, 'tonumber() should not convert numeric strings containing spaces in the middle with base 2')
assertTrue (f == nil, 'tonumber() should not convert numeric strings of floating point numbers at base 2')
assertTrue (g == nil, 'tonumber() should not convert numeric strings of exponential numbers at base 2')


local a = tonumber ('123', 16)
local b = tonumber ('1AF', 16)
local c = tonumber ('1AF ', 16)
local d = tonumber (' 1AF ', 16)
local e = tonumber ('123Axyz', 16)
local f = tonumber ('123 45', 16)
local g = tonumber ('123.4', 16)
local h = tonumber ('1.23e+10', 16)

assertTrue (a == 291, 'tonumber() should convert basic numeric strings to decimal with base 16')
assertTrue (b == 431, 'tonumber() should convert hexadecimal strings to decimal with base 16')
assertTrue (c == 431, 'tonumber() should convert hexadecimal strings suffixed with spaces with base 16')
assertTrue (d == 431, 'tonumber() should convert hexadecimal strings prefixed with spaces with base 16')
assertTrue (e == nil, 'tonumber() should not convert strings containing letters out of the range of hexadecimal, with base 16')
assertTrue (f == nil, 'tonumber() should not convert hexadecimal strings containing spaces in the middle with base 16')
assertTrue (g == nil, 'tonumber() should not convert hexadecimal strings of floating point numbers at base 16')
assertTrue (h == nil, 'tonumber() should not convert hexadecimal strings of exponential numbers at base 16')




-- tostring
-- TODO Check for use of __tostring metamethod

local a = tostring (123)
--local b = tostring ({})
--local c = tostring ({1, 2, 3})
--local d = tostring (function () return true end)

assertTrue (a == "123", 'tostring() should convert a number to a string')




-- type

local a = type (nil)
local b = type (123)
local c = type ('abc')
local d = type (true)
local e = type ({})
local f = type (function () return true end)

assertTrue (a == 'nil', 'type() should return "nil" for a variable with value of nil')
assertTrue (b == 'number', 'type() should return "number" for a variable with value of number')
assertTrue (c == 'string', 'type() should return "string" for a variable with value of type string')
assertTrue (d == 'boolean', 'type() should return "boolean" for a variable with value of type boolean')
assertTrue (e == 'table', 'type() should return "table" for a variable with value of type table')
assertTrue (f == 'function', 'type() should return "function" for a variable with value of type function')



-- unpack

local a = {0, 1, 2, 4, 20, 50, 122}

local b, c, d, e, f, g = unpack (a, 3);
local h, i = unpack (a, 3, 2);
local j, k, l, m = unpack (a, 3, 5);

assertTrue (b == 2, 'unpack() should return the correct items of the given list [1]')
assertTrue (c == 4, 'unpack() should return the correct items of the given list [2]')
assertTrue (d == 20, 'unpack() should return the correct items of the given list [3]')
assertTrue (e == 50, 'unpack() should return the correct items of the given list [4]')
assertTrue (f == 122, 'unpack() should return the correct items of the given list [5]')
assertTrue (g == nil, 'unpack() should return the correct items of the given list [6]')
assertTrue (h == nil, 'unpack() should return the correct items of the given list [7]')
assertTrue (i == nil, 'unpack() should return the correct items of the given list [8]')
assertTrue (j == 2, 'unpack() should return the correct items of the given list [9]')
assertTrue (k == 4, 'unpack() should return the correct items of the given list [10]')
assertTrue (l == 20, 'unpack() should return the correct items of the given list [11]')
assertTrue (m == nil, 'unpack() should return the correct items of the given list [12]')




-- _VERSION

assertTrue (_VERSION == 'Lua 5.1', '_VERSION should be "Lua 5.1"')




-- xpcall

function goodfunc ()
	return 10, "win"
end

function badfunc ()
	error ('I\'m bad.')
end 

function errfunc ()
	return 999, "fail"
end 

a, b, c, d = xpcall (goodfunc, errfunc)

assertTrue (a == true, 'xpcall() should return true in the first item when a function executes successfully')
assertTrue (b == 10, 'xpcall() should return the result of the function in the items following the first item returned, when a function executes successfully [1]')
assertTrue (c == 'win', 'xpcall() should return the result of the function in the items following the first item returned, when a function executes successfully [2]')
assertTrue (d == nil, 'xpcall() should return the result of the function in the items following the first item returned, when a function executes successfully [3]')

a, b, c = xpcall (badfunc, errfunc)

assertTrue (a == false, 'xpcall() should return false in the first item when the function errors during execution')
assertTrue (b == 999, 'xpcall() should return the first item of the result of the error function in the second item returned, when the function errors during execution')
assertTrue (c == nil, 'xpcall() should only return the first item of the result of the error function in the items following the first item returned, when the function errors during execution')





-- STRING FUNCTIONS


-- byte

local a, b = string.byte ('Mo0')

assertTrue (a == 77, 'string.byte() should return the numerical code for the first character in the first returned item')
assertTrue (b == nil, 'string.byte() should return only one item when only no length is given [1]')


local a, b = string.byte ('Mo0', 2)

assertTrue (a == 111, 'string.byte() should return the numerical code for the nth character in the first returned item, when n is specified in the second argument [1]')
assertTrue (b == nil, 'string.byte() should return only one item when only no length is given [2]')


local a, b, c = string.byte ('Mo0', 2, 3)

assertTrue (a == 111, 'string.byte() should return the numerical code for the nth character in the first returned item, when n is specified in the second argument [2]')
assertTrue (b == 48, 'string.byte() should return the numerical code for the nth character in the first returned item, when n is specified in the second argument [3]')
assertTrue (c == nil, 'string.byte() should return only the number of items specified in the length argument or the up to the end of the string, whichever is encountered first [1]')


local a, b, c = string.byte ('Mo0', 3, 20)

assertTrue (a == 48, 'string.byte() should return the numerical code for the nth character in the first returned item, when n is specified in the second argument [4]')
assertTrue (b == nil, 'string.byte() should return only the number of items specified in the length argument or the up to the end of the string, whichever is encountered first [2]')




-- char

local a = string.char ()
local b = string.char (116, 101, 115, 116, 105, 99, 108, 101, 115)

assertTrue (a == '', 'string.byte() should return an empty string when called with no arguments')
assertTrue (b == 'testicles', 'string.byte() should return a string comprising of characters representing by the value each of the arguments passed')




-- find

local a = 'The quick brown fox'

local b = string.find (a, 'quick');
local c = string.find (a, 'fox');
local d = string.find (a, 'kipper');
local e = string.find (a, '');

local f = string.find (a, 'quick', 8);
local g = string.find (a, 'fox', 8);

assertTrue (b == 5, 'string.find() should return the location of the first occurrence of the second argument within the first, if it is present [1]')
assertTrue (c == 17, 'string.find() should return the location of the first occurrence of the second argument within the first, if it is present [2]')
assertTrue (d == nil, 'string.find() should return nil if the second argument is not contained within the first [1]')
assertTrue (e == 1, 'string.find() should return return 1 if the second argument is an empty string')
assertTrue (f == nil, 'string.find() should return nil if the second argument is not contained within the first after the index specified by the third argument')
assertTrue (g == 17, 'string.find() should return the location of the second argument if it is contained within the first after the index specified by the third argument')




-- len

local a = 'McLaren Mercedes'

local b = string.len ('');
local c = string.len (a);

assertTrue (b == 0, 'string.len() should return 0 if passed an empty string')
assertTrue (c == 16, 'string.len() should return the length of the string in the first argument')





-- lower

local a = 'McLaren Mercedes'

local b = string.lower ('');
local c = string.lower (a);

assertTrue (b == '', 'string.lower() should return an empty string if passed an empty string')
assertTrue (c == 'mclaren mercedes', 'string.lower() should return the string in the first argument with all character in lower case')




-- rep

local a = 'Ho'

local b = string.rep (a, 0);
local c = string.rep (a, 1);
local d = string.rep (a, 3);

assertTrue (b == '', 'string.rep() should return an empty string if the second argument is 0')
assertTrue (c == 'Ho', 'string.rep() should return the first argument if the second argument is 1')
assertTrue (d == 'HoHoHo', 'string.rep() should return a string containing the first argument repeated the second argument number of times')




-- reverse

local a = string.reverse ('');
local b = string.reverse ('x');
local c = string.reverse ('tpircSavaJ');

assertTrue (a == '', 'string.reverse() should return an empty string if passed an empty string')
assertTrue (b == 'x', 'string.reverse() should return the first argument if its length is 1')
assertTrue (c == 'JavaScript', 'string.reverse() should return a string containing the first argument reversed')




-- sub

local a = 'Pub Standards'

local b = string.sub (a, 1)
local c = string.sub (a, 5)
local d = string.sub (a, -4)

local e = string.sub (a, 1, 3)
local f = string.sub (a, 7, 9)
local g = string.sub (a, -4, -2)

local h = string.sub (a, 5, -2)
local i = string.sub (a, 0)

assertTrue (b == 'Pub Standards', 'string.sub() should return the first argument if the second argument is 1')
assertTrue (c == 'Standards', 'string.sub() should return a subset of the first argument from the nth character onwards, when n is the second argument and positive')
assertTrue (d == 'ards', 'string.sub() should return the last n characters of the first argument, where n is the absolute value of the second argument and the second argument is negative')
assertTrue (e == 'Pub', 'string.sub() should return the first n characters of the first argument when the second argument is one and n is the third argument')
assertTrue (f == 'and', 'string.sub() should return a subset of the first argument from the nth character to the mth character, when n is the second argument and positive and m is the third argument and negative')


assertTrue (h == 'Standard', 'string.sub() should return a subset of the first argument from the nth character to the last but mth character, when n is the second argument and positive and m is the third argument and negative')
assertTrue (i == 'Pub Standards', 'string.sub() should return a subset of the first argument from the last but nth character to the last but mth character, when n is the second argument and negative and m is the third argument and negative')




-- upper

local a = string.upper ('');
local b = string.upper ('JavaScript');

assertTrue (a == '', 'string.upper() should return an empty string if passed an empty string')
assertTrue (b == 'JAVASCRIPT', 'string.upper() should return the first argument in uppercase')






-- TABLE FUNCTIONS


-- concat

local a = {2, 4, "moo", 102}

local b = table.concat ({})
local c = table.concat ({}, ':')
local d = table.concat ({}, ', ', 3)
--local e = table.concat ({}, ', ', 3, 4)

local f = table.concat (a)
local g = table.concat (a, '-')
local h = table.concat (a, '..', 2)
local i = table.concat (a, '+', 2, 3)

assertTrue (b == '', 'table.concat() should return an empty string if passed an empty table [1]')
assertTrue (c == '', 'table.concat() should return an empty string if passed an empty table [2]')
assertTrue (d == '', 'table.concat() should return an empty string if passed an empty table [3]')
--assertTrue (e == '', 'table.concat() should return an empty string if passed an empty table [4]')

assertTrue (f == '24moo102', 'table.concat() should return all items in the table in argument 1 in a string with no spaces, when arguments 2 and 3 are absent')
assertTrue (g == '2-4-moo-102', 'table.concat() should return return all items in the table in argument 1 in a string delimited by argument 2, when argument 3 is absent')
assertTrue (h == '4..moo..102', 'table.concat() should return the items in the table in argument 1 from the nth index in a string delimited by argument 2, when n is the third argument')
assertTrue (i == '4+moo', 'table.concat() should return the items in the table in argument 1 from the nth index to the mth index in a string delimited by argument 2, when n is the third argument and m is the forth argument')




-- insert

local b = {}
local w = table.insert (b, 'Lewis')

local c = {}
local x = table.insert (c, 3, 'Jenson')

local d = {'We', 'exist', 'to'}
local y = table.insert (d, 'win')

local e = {1, 1998, 1, 1999}
local z = table.insert (e, 3, 'Mika')

local f = {'Kimi'}
local z2 = table.insert (f, 4, 2)

assertTrue (b[1] == 'Lewis', 'table.concat() should add argument 2 to the end of the table in argument 1, when the third argument is absent [1]')
assertTrue (b[2] == nil, 'table.concat() should only add argument 2 to the end of the table in argument 1, when the third argument is absent [2]')

assertTrue (c[1] == nil, 'table.concat() should pad the table with nils when the desired index is greater than the length of the table [1]')
assertTrue (c[2] == nil, 'table.concat() should pad the table with nils when the desired index is greater than the length of the table [2]')
assertTrue (c[3] == 'Jenson', 'table.concat() should add argument 2 to the end of the table in argument 1, when the third argument is greater than the length of the table [1]')
assertTrue (c[4] == nil, 'table.concat() should only add argument 2 to the end of the table in argument 1, when the third argument is greater than the length of the table [2]')

assertTrue (d[1] == 'We', 'table.concat()  should not affect existing items in the table when the third argument is missing [1]')
assertTrue (d[2] == 'exist', 'table.concat() should not affect existing items in the table when the third argument is missing [2]')
assertTrue (d[3] == 'to', 'table.concat() should not affect existing items in the table when the third argument is missing [3]')
assertTrue (d[4] == 'win', 'table.concat() should add argument 2 to the end of the table in argument 1, when the third argument is missing [1]')
assertTrue (d[5] == nil, 'table.concat() should only add argument 2 to the end of the table in argument 1, when the third argument is missing [2]')

assertTrue (e[1] == 1, 'table.concat() should not affect existing items in the table at indices less than that specified in the third argument [1]')
assertTrue (e[2] == 1998, 'table.concat() should not affect existing items in the table at indices less than that specified in the third argument [2]')
assertTrue (e[3] == 'Mika', 'table.concat() should add argument 3 into the table in argument 1 at the index specified in argument 2')
assertTrue (e[4] == 1, 'table.concat() should shift items in the table in argument 1 down by one after and including the index at argument 2 [1]')
assertTrue (e[5] == 1999, 'table.concat() should shift items in the table in argument 1 down by one after and including the index at argument 2 [2]')
assertTrue (e[6] == nil, 'table.concat() should only add one index to the table in argument 1 [1]')

assertTrue (f[1] == 'Kimi', 'table.concat() should not affect existing items in the table at indices less than that specified in the third argument [3]')
assertTrue (f[2] == nil, 'table.concat() should pad the table with nils when the desired index is greater than the length of the table [3]')
assertTrue (f[3] == nil, 'table.concat() should pad the table with nils when the desired index is greater than the length of the table [4]')
assertTrue (f[4] == 2, 'table.concat() should not affect existing items in the table at indices less than that specified in the third argument [2]')
assertTrue (f[5] == nil, 'table.concat() should only add one index to the table in argument 1 [2]')


assertTrue (w == nil, 'table.concat() should update list in place and return nil')
assertTrue (x == nil, 'table.concat() should update list in place and return nil')
assertTrue (y == nil, 'table.concat() should update list in place and return nil')
assertTrue (z == nil, 'table.concat() should update list in place and return nil')
assertTrue (z2 == nil, 'table.concat() should update list in place and return nil')




-- maxn

local a = table.maxn ({})
local b = table.maxn ({1, 2, 4, 8})
local c = table.maxn ({nil, nil, 123})


local d = {}
table.insert (d, 3, 'Moo')
local e = table.maxn (d)

assertTrue (a == 0, 'table.maxn() should return zero when passed an empty table')
assertTrue (b == 4, 'table.maxn() should return the highest index in the passed table [1]')
assertTrue (c == 3, 'table.maxn() should return the highest index in the passed table [2]')
assertTrue (e == 3, 'table.maxn() should return the highest index in the passed table [3]')

assertTrue (#d == 0, 'Length operator should return the first available index minus one')




-- remove

local a = {14, 2, "Hello", 298}
local b = table.remove (a)

local c = {14, 2, "Hello", 298}
local d = table.remove (c, 3)

local e = {14, 2}
local f = table.remove (e, 6)

local g = table.remove ({}, 1)

assertTrue (a[1] == 14, 'table.remove() should not affect items before the removed index [1]')
assertTrue (a[2] == 2, 'table.remove() should not affect items before the removed index [2]')
assertTrue (a[3] == "Hello", 'table.remove() should not affect items before the removed index [3]')
assertTrue (a[4] == nil, 'table.remove() should remove the last item in the table when second argument is absent')

assertTrue (b == 298, 'table.remove() should return the removed item [1]')

assertTrue (c[1] == 14, 'table.remove() should not affect items before the removed index [3]')
assertTrue (c[2] == 2, 'table.remove() should not affect items before the removed index [4]')
assertTrue (c[3] == 298, 'table.remove() should remove the item at the index specified by the second argument and shift subsequent item down')
assertTrue (c[4] == nil, 'table.remove() should decrease the length of the table by one')

assertTrue (d == 'Hello', 'table.remove() should return the removed item [2]')

assertTrue (e[1] == 14, 'table.remove() should not affect items before the removed index [5]')
assertTrue (e[2] == 2, 'table.remove() should not affect items before the removed index [6]')
assertTrue (e[3] == nil, 'table.remove() should not affect the table if the given index is past the length of the table')

assertTrue (f == nil, 'table.remove() should return nil if the given index is past the length of the table [1]')
assertTrue (g == nil, 'table.remove() should return nil if the given index is past the length of the table [2]')




-- sort

local a = { 1, 2, 3, 6, 5, 4, 20 }
table.sort (a)

assertTrue (a[1] == 1, 'table.sort() should sort elements into alphnumeric order, when not passed a sort function [1]')
assertTrue (a[2] == 2, 'table.sort() should sort elements into alphnumeric order, when not passed a sort function [2]')
assertTrue (a[3] == 3, 'table.sort() should sort elements into alphnumeric order, when not passed a sort function [3]')
assertTrue (a[4] == 4, 'table.sort() should sort elements into alphnumeric order, when not passed a sort function [4]')
assertTrue (a[5] == 5, 'table.sort() should sort elements into alphnumeric order, when not passed a sort function [5]')
assertTrue (a[6] == 6, 'table.sort() should sort elements into alphnumeric order, when not passed a sort function [6]')
assertTrue (a[7] == 20, 'table.sort() should sort elements into alphnumeric order, when not passed a sort function [7]')
assertTrue (a[8] == nil, 'table.sort() should not affect the table if the given index is past the length of the table')


local a = { 1, 2, 3, 6, 5, 4, 20 }
table.sort (a, function (a, b) return b < a end)

assertTrue (a[1] == 20, 'table.sort() should sort elements into order defined by sort function [1]')
assertTrue (a[2] == 6, 'table.sort() should sort elements into order defined by sort function [2]')
assertTrue (a[3] == 5, 'table.sort() should sort elements into order defined by sort function [3]')
assertTrue (a[4] == 4, 'table.sort() should sort elements into order defined by sort function [4]')
assertTrue (a[5] == 3, 'table.sort() should sort elements into order defined by sort function [5]')
assertTrue (a[6] == 2, 'table.sort() should sort elements into order defined by sort function [6]')
assertTrue (a[7] == 1, 'table.sort() should sort elements into order defined by sort function [7]')
assertTrue (a[8] == nil, 'table.sort() should not affect the table if the given index is past the length of the table')






-- MATHS FUNCTIONS


-- abs

local a = math.abs (10)
local b = math.abs (-20)
local c = math.abs (2.56)
local d = math.abs (-34.67)
local e = math.abs (-0)

assertTrue (a == 10, 'math.abs() should return the passed argument if it is positive')
assertTrue (b == 20, 'math.abs() should return the positive form of the passed argument if it is negative')
assertTrue (c == 2.56, 'math.abs() should return the passed argument if it is a positive floating point number')
assertTrue (d == 34.67, 'math.abs() should return the positive form of the passed argument if it is a positive floating point number')
assertTrue (e == 0, 'math.abs() should return zero if passed zero')




-- math.acos
-- math.cos


local a = math.acos (1)
--local b = math.acos (math.cos (0.3))
local c = math.cos (0)
--local d = math.cos (math.acos (0.3))

assertTrue (a == 0, 'math.acos() should return 0 when passed 1')
--assertTrue (b == 0.3, 'math.acos() should return x when passed math.cos(x)')
assertTrue (c == 1, 'math.cos() should return 1 when passed 0')
--assertTrue (d == 0.3, 'math.cos() should return x when passed math.acos(x)')




-- math.asin
-- math.sin


local a = math.asin (0)
local b = math.asin (math.sin (0.3))
local c = math.sin (0)
local d = math.sin (math.asin (0.3))

assertTrue (a == 0, 'math.asin() should return 0 when passed 0')
assertTrue (b == 0.3, 'math.asin() should return x when passed math.sin(x)')
assertTrue (c == 0, 'math.sin() should return 0 when passed 0')
assertTrue (d == 0.3, 'math.sin() should return x when passed math.asin(x)')




-- math.atan
-- math.tan


local a = math.atan (0)
local b = math.atan (math.tan (0.3))
local c = math.tan (0)
local d = math.tan (math.atan (0.3))

assertTrue (a == 0, 'math.atan() should return 0 when passed 0')
assertTrue (b == 0.3, 'math.atan() should return x when passed math.tan(x)')
assertTrue (c == 0, 'math.tan() should return 0 when passed 0')
assertTrue (d == 0.3, 'math.tan() should return x when passed math.atan(x)')




-- math.ceil

local a = math.ceil (14)
local b = math.ceil (14.45)
local c = math.ceil (14.5)
local d = math.ceil (0.1)
local e = math.ceil (0.6)
local f = math.ceil (-0.6)
local g = math.ceil (-122.4)

assertTrue (a == 14, 'math.ceil() should round up to the next integer')
assertTrue (b == 15, 'math.ceil() should round up to the next integer')
assertTrue (c == 15, 'math.ceil() should round up to the next integer')
assertTrue (d == 1, 'math.ceil() should round up to the next integer')
assertTrue (e == 1, 'math.ceil() should round up to the next integer')
assertTrue (f == 0, 'math.ceil() should round up to the next integer')
assertTrue (g == -122, 'math.ceil() should round up to the next integer')






-- Arithmetic metamethods

local mt = {}
local Obj = {}

function Obj.new (v) 
	local self = { ['value'] = v }
	setmetatable (self, mt);
	return self
end

local o = Obj.new (3);
local p = Obj.new (5);


-- __add

mt.__add = function (a, b)
	return a.value..'(__add)'..b.value
end

assertTrue (o + p == '3(__add)5', 'Add operator should use __add metamethod, if provided')




-- __concat

mt.__concat = function (a, b)
	return a.value..'(__concat)'..b.value
end

assertTrue (o..p == '3(__concat)5', 'Concatenation operator should use __concat metamethod, if provided')




-- __div

mt.__div = function (a, b)
	return a.value..'(__div)'..b.value
end

assertTrue (o / p == '3(__div)5', 'Divide operator should use __div metamethod, if provided')




-- __mod

mt.__mod = function (a, b)
	return a.value..'(__mod)'..b.value
end

assertTrue (o % p == '3(__mod)5', 'Modulo operator should use __mod metamethod, if provided')




-- __mul

mt.__mul = function (a, b)
	return a.value..'(__mul)'..b.value
end

assertTrue (o * p == '3(__mul)5', 'Muliplication operator should use __mul metamethod, if provided')




-- __pow

mt.__pow = function (a, b)
	return a.value..'(__pow)'..b.value
end

assertTrue (o ^ p == '3(__pow)5', 'Exponentiation operator should use __pow metamethod, if provided')




-- __sub

mt.__sub = function (a, b)
	return a.value..'(__sub)'..b.value
end

assertTrue (o - p == '3(__sub)5', 'Subtraction operator should use __sub metamethod, if provided')




-- __unm

mt.__unm = function (a)
	return '(__unm)'..a.value
end

assertTrue (-o == '(__unm)3', 'Negation operator should use __unm metamethod, if provided')








-- Relational metamethods


-- __eq
local x = 0

mt.__eq = function (a, b)
	x = x + 1
	return true
end

assertTrue (o == p, 'Equality operator should use __eq metamethod, if provided [1]')
assertTrue (x == 1, 'Equality operator should use __eq metamethod, if provided [2]')

assertTrue (not (o == 123), 'Equality operator should not use __eq metamethod if objects are of different type [1]')
assertTrue (x == 1, 'Equality operator should not use __eq metamethod if operands are of different type [2]')

assertTrue (o == o, 'Equality operator should not use __eq metamethod if the operands are the same object [1]')
assertTrue (x == 1, 'Equality operator should not use __eq metamethod if the operands are the same object [2]')




-- __le

x = 0

mt.__le = function (a, b)
	x = x + 1
	return a.value == 3
end

assertTrue (o <= p, 'Less than or equal to operator should use __le metamethod, if provided [1]')
assertTrue (x == 1, 'Less than or equal to operator should use __le metamethod, if provided [2]')
assertTrue (not (p <= o), 'Less than or equal to operator should use __le metamethod, if provided [3]')
assertTrue (x == 2, 'Less than or equal to operator should use __le metamethod, if provided [4]')




-- __lt

x = 0

mt.__lt = function (a, b)
	x = x + 1
	return a.value == 3
end

assertTrue (o < p, 'Less than operator should use __le metamethod, if provided [1]')
assertTrue (x == 1, 'Less than operator should use __le metamethod, if provided [2]')
assertTrue (not (p < o), 'Less than operator should use __le metamethod, if provided [3]')
assertTrue (x == 2, 'Less than operator should use __le metamethod, if provided [4]')






-- TYPE ERRORS

function conc (a, b)
	return a..b
end

a = pcall (conc, 'a', 'b')
b = pcall (conc, 'a', 44)
c = pcall (conc, 55, 'b')
d = pcall (conc, 55, 44)
e = pcall (conc, 'a', {})
f = pcall (conc, {}, 'b')
g = pcall (conc, 'a', os.date)

assertTrue (a, 'Concatenation should not error with two strings')
assertTrue (b, 'Concatenation should not error with a string and a number')
assertTrue (c, 'Concatenation should not error with a number and a string')
assertTrue (d, 'Concatenation should not error with two numbers')
assertTrue (not (e), 'Concatenation should error with a string and a table')
assertTrue (not (f), 'Concatenation should error with a table and a string')
assertTrue (not (g), 'Concatenation should error with a string and a function')


function add (a, b)
	return a + b
end

a = pcall (add, 'a', 'b')
b = pcall (add, 'a', 44)
c = pcall (add, 55, 'b')
d = pcall (add, 55, 44)
e = pcall (add, 'a', {})
f = pcall (add, {}, 'b')
g = pcall (add, 'a', os.date)

assertTrue (not (a), 'Addition operator should error with two strings')
assertTrue (not (b), 'Addition operator should error with a string and a number')
assertTrue (not (c), 'Addition operator should error with a number and a string')
assertTrue (d, 'Addition operator should not error with two numbers')
assertTrue (not (e), 'Addition operator should error with a string and a table')
assertTrue (not (f), 'Addition operator should error with a table and a string')
assertTrue (not (g), 'Addition operator should error with a string and a function')


function sub (a, b)
	return a - b
end

a = pcall (sub, 'a', 'b')
b = pcall (sub, 'a', 44)
c = pcall (sub, 55, 'b')
d = pcall (sub, 55, 44)
e = pcall (sub, 'a', {})
f = pcall (sub, {}, 'b')
g = pcall (sub, 'a', os.date)

assertTrue (not (a), 'Subtraction operator should error with two strings')
assertTrue (not (b), 'Subtraction operator should error with a string and a number')
assertTrue (not (c), 'Subtraction operator should error with a number and a string')
assertTrue (d, 'Subtraction operator should not error with two numbers')
assertTrue (not (e), 'Subtraction operator should error with a string and a table')
assertTrue (not (f), 'Subtraction operator should error with a table and a string')
assertTrue (not (g), 'Subtraction operator should error with a string and a function')


function mult (a, b)
	return a * b
end

a = pcall (mult, 'a', 'b')
b = pcall (mult, 'a', 44)
c = pcall (mult, 55, 'b')
d = pcall (mult, 55, 44)
e = pcall (mult, 'a', {})
f = pcall (mult, {}, 'b')
g = pcall (mult, 'a', os.date)

assertTrue (not (a), 'Multiplication operator should error with two strings')
assertTrue (not (b), 'Multiplication operator should error with a string and a number')
assertTrue (not (c), 'Multiplication operator should error with a number and a string')
assertTrue (d, 'Multiplication operator should not error with two numbers')
assertTrue (not (e), 'Multiplication operator should error with a string and a table')
assertTrue (not (f), 'Multiplication operator should error with a table and a string')
assertTrue (not (g), 'Multiplication operator should error with a string and a function')


function divide (a, b)
	return a / b
end

a = pcall (divide, 'a', 'b')
b = pcall (divide, 'a', 44)
c = pcall (divide, 55, 'b')
d = pcall (divide, 55, 44)
e = pcall (divide, 'a', {})
f = pcall (divide, {}, 'b')
g = pcall (divide, 'a', os.date)

assertTrue (not (a), 'Division operator should error with two strings')
assertTrue (not (b), 'Division operator should error with a string and a number')
assertTrue (not (c), 'Division operator should error with a number and a string')
assertTrue (d, 'Division operator should not error with two numbers')
assertTrue (not (e), 'Division operator should error with a string and a table')
assertTrue (not (f), 'Division operator should error with a table and a string')
assertTrue (not (g), 'Division operator should error with a string and a function')


function modu (a, b)
	return a % b
end

a = pcall (modu, 'a', 'b')
b = pcall (modu, 'a', 44)
c = pcall (modu, 55, 'b')
d = pcall (modu, 55, 44)
e = pcall (modu, 'a', {})
f = pcall (modu, {}, 'b')
g = pcall (modu, 'a', os.date)

assertTrue (not (a), 'Modulo operator should error with two strings')
assertTrue (not (b), 'Modulo operator should error with a string and a number')
assertTrue (not (c), 'Modulo operator should error with a number and a string')
assertTrue (d, 'Modulo operator should not error with two numbers')
assertTrue (not (e), 'Modulo operator should error with a string and a table')
assertTrue (not (f), 'Modulo operator should error with a table and a string')
assertTrue (not (g), 'Modulo operator should error with a string and a function')


function power (a, b)
	return a ^ b
end

a = pcall (power, 'a', 'b')
b = pcall (power, 'a', 44)
c = pcall (power, 55, 'b')
d = pcall (power, 55, 44)
e = pcall (power, 'a', {})
f = pcall (power, {}, 'b')
g = pcall (power, 'a', os.date)

assertTrue (not (a), 'Exponentiation operator should error with two strings')
assertTrue (not (b), 'Exponentiation operator should error with a string and a number')
assertTrue (not (c), 'Exponentiation operator should error with a number and a string')
assertTrue (d, 'Exponentiation operator should not error with two numbers')
assertTrue (not (e), 'Exponentiation operator should error with a string and a table')
assertTrue (not (f), 'Exponentiation operator should error with a table and a string')
assertTrue (not (g), 'Exponentiation operator should error with a string and a function')


function neg (a)
	return -a
end

a = pcall (neg, 'a')
b = pcall (neg, 55)
c = pcall (neg, {})

assertTrue (not (a), 'Negation operator should error when passed a string')
assertTrue (b, 'Negation operator should not error when passed a number')
assertTrue (not (c), 'Negation operator should error when passed a table')







local datetest = function ()

	--[[
	local dates = {{1, 1}, {1, 2}, {28, 2}, {29, 2}, {1, 3}, {31, 12}}
	local years = {1999, 2000, 2011}
	local symbols = {'%a', '%A', '%b', '%B', '%d', '%H', '%I', '%j', '%m', '%M', '%p', '%S', '%U', '%w', '%W', '%x', '%X', '%y', '%Y', '%Z', '%%', '!%a', '!%A', '!%b', '!%B', '!%d', '!%H', '!%I', '!%j', '!%m', '!%M', '!%p', '!%S', '!%U', '!%w', '!%W', '!%x', '!%X', '!%y', '!%Y', '!%Z'}
	local index = 0

	for _, year in pairs (years) do
		for _, date in pairs (dates) do
			local time = os.time {
				year = year,
				month = date[2],
				day = date[1],
				hour = date[2]
			}

			print ('\nlocal time = '..time..'\n')
		
			for _, symbol in pairs (symbols) do
				index = index + 1			
				print ("assertTrue (os.date ('"..symbol.."', time) == '"..os.date (symbol, time).."', 'os.date() did not return expected value when passed \""..symbol.."\" ["..index.."]')")
			end
		
			local data = os.date ('*t', time)
			for key, value in pairs (data) do
				index = index + 1
			
				local val = tostring (value)
				if type (value) == 'string' then val = "'"..val.."'" end
				
				print ("assertTrue (os.date ('*t', time)."..key.." == "..val..", 'os.date() did not return expected value when passed \"*t\" ["..index.."]')")
			end
		
			local data = os.date ('!*t', time)
			for key, value in pairs (data) do
				index = index + 1
			
				local val = tostring (value)
				if type (value) == 'string' then val = "'"..val.."'" end
				
				print ("assertTrue (os.date ('!*t', time)."..key.." == "..val..", 'os.date() did not return expected value when passed \"!*t\" ["..index.."]')")
			end
		
		
		end
	end
	--]]


	local time = 915152400

	assertTrue (os.date ('%a', time) == 'Fri', 'os.date() did not return expected value when passed "%a" [1]')
	assertTrue (os.date ('%A', time) == 'Friday', 'os.date() did not return expected value when passed "%A" [2]')
	assertTrue (os.date ('%b', time) == 'Jan', 'os.date() did not return expected value when passed "%b" [3]')
	assertTrue (os.date ('%B', time) == 'January', 'os.date() did not return expected value when passed "%B" [4]')
	assertTrue (os.date ('%d', time) == '01', 'os.date() did not return expected value when passed "%d" [5]')
	assertTrue (os.date ('%H', time) == '01', 'os.date() did not return expected value when passed "%H" [6]')
	assertTrue (os.date ('%I', time) == '01', 'os.date() did not return expected value when passed "%I" [7]')
	assertTrue (os.date ('%j', time) == '001', 'os.date() did not return expected value when passed "%j" [8]')
	assertTrue (os.date ('%m', time) == '01', 'os.date() did not return expected value when passed "%m" [9]')
	assertTrue (os.date ('%M', time) == '00', 'os.date() did not return expected value when passed "%M" [10]')
	assertTrue (os.date ('%p', time) == 'AM', 'os.date() did not return expected value when passed "%p" [11]')
	assertTrue (os.date ('%S', time) == '00', 'os.date() did not return expected value when passed "%S" [12]')
	assertTrue (os.date ('%U', time) == '00', 'os.date() did not return expected value when passed "%U" [13]')
	assertTrue (os.date ('%w', time) == '5', 'os.date() did not return expected value when passed "%w" [14]')
	assertTrue (os.date ('%W', time) == '00', 'os.date() did not return expected value when passed "%W" [15]')
	assertTrue (os.date ('%x', time) == '01/01/99', 'os.date() did not return expected value when passed "%x" [16]')
	assertTrue (os.date ('%X', time) == '01:00:00', 'os.date() did not return expected value when passed "%X" [17]')
	assertTrue (os.date ('%y', time) == '99', 'os.date() did not return expected value when passed "%y" [18]')
	assertTrue (os.date ('%Y', time) == '1999', 'os.date() did not return expected value when passed "%Y" [19]')
	assertTrue (os.date ('%Z', time) == 'GMT', 'os.date() did not return expected value when passed "%Z" [20]')
	assertTrue (os.date ('%%', time) == '%', 'os.date() did not return expected value when passed "%%" [21]')
	assertTrue (os.date ('!%a', time) == 'Fri', 'os.date() did not return expected value when passed "!%a" [22]')
	assertTrue (os.date ('!%A', time) == 'Friday', 'os.date() did not return expected value when passed "!%A" [23]')
	assertTrue (os.date ('!%b', time) == 'Jan', 'os.date() did not return expected value when passed "!%b" [24]')
	assertTrue (os.date ('!%B', time) == 'January', 'os.date() did not return expected value when passed "!%B" [25]')
	assertTrue (os.date ('!%d', time) == '01', 'os.date() did not return expected value when passed "!%d" [26]')
	assertTrue (os.date ('!%H', time) == '01', 'os.date() did not return expected value when passed "!%H" [27]')
	assertTrue (os.date ('!%I', time) == '01', 'os.date() did not return expected value when passed "!%I" [28]')
	assertTrue (os.date ('!%j', time) == '001', 'os.date() did not return expected value when passed "!%j" [29]')
	assertTrue (os.date ('!%m', time) == '01', 'os.date() did not return expected value when passed "!%m" [30]')
	assertTrue (os.date ('!%M', time) == '00', 'os.date() did not return expected value when passed "!%M" [31]')
	assertTrue (os.date ('!%p', time) == 'AM', 'os.date() did not return expected value when passed "!%p" [32]')
	assertTrue (os.date ('!%S', time) == '00', 'os.date() did not return expected value when passed "!%S" [33]')
	assertTrue (os.date ('!%U', time) == '00', 'os.date() did not return expected value when passed "!%U" [34]')
	assertTrue (os.date ('!%w', time) == '5', 'os.date() did not return expected value when passed "!%w" [35]')
	assertTrue (os.date ('!%W', time) == '00', 'os.date() did not return expected value when passed "!%W" [36]')
	assertTrue (os.date ('!%x', time) == '01/01/99', 'os.date() did not return expected value when passed "!%x" [37]')
	assertTrue (os.date ('!%X', time) == '01:00:00', 'os.date() did not return expected value when passed "!%X" [38]')
	assertTrue (os.date ('!%y', time) == '99', 'os.date() did not return expected value when passed "!%y" [39]')
	assertTrue (os.date ('!%Y', time) == '1999', 'os.date() did not return expected value when passed "!%Y" [40]')
	assertTrue (os.date ('!%Z', time) == 'UTC', 'os.date() did not return expected value when passed "!%Z" [41]')
	assertTrue (os.date ('*t', time).hour == 1, 'os.date() did not return expected value when passed "*t" [42]')
	assertTrue (os.date ('*t', time).min == 0, 'os.date() did not return expected value when passed "*t" [43]')
	assertTrue (os.date ('*t', time).wday == 6, 'os.date() did not return expected value when passed "*t" [44]')
	assertTrue (os.date ('*t', time).day == 1, 'os.date() did not return expected value when passed "*t" [45]')
	assertTrue (os.date ('*t', time).month == 1, 'os.date() did not return expected value when passed "*t" [46]')
	assertTrue (os.date ('*t', time).year == 1999, 'os.date() did not return expected value when passed "*t" [47]')
	assertTrue (os.date ('*t', time).sec == 0, 'os.date() did not return expected value when passed "*t" [48]')
	assertTrue (os.date ('*t', time).yday == 1, 'os.date() did not return expected value when passed "*t" [49]')
	assertTrue (os.date ('*t', time).isdst == false, 'os.date() did not return expected value when passed "*t" [50]')
	assertTrue (os.date ('!*t', time).hour == 1, 'os.date() did not return expected value when passed "!*t" [51]')
	assertTrue (os.date ('!*t', time).min == 0, 'os.date() did not return expected value when passed "!*t" [52]')
	assertTrue (os.date ('!*t', time).wday == 6, 'os.date() did not return expected value when passed "!*t" [53]')
	assertTrue (os.date ('!*t', time).day == 1, 'os.date() did not return expected value when passed "!*t" [54]')
	assertTrue (os.date ('!*t', time).month == 1, 'os.date() did not return expected value when passed "!*t" [55]')
	assertTrue (os.date ('!*t', time).year == 1999, 'os.date() did not return expected value when passed "!*t" [56]')
	assertTrue (os.date ('!*t', time).sec == 0, 'os.date() did not return expected value when passed "!*t" [57]')
	assertTrue (os.date ('!*t', time).yday == 1, 'os.date() did not return expected value when passed "!*t" [58]')
	assertTrue (os.date ('!*t', time).isdst == false, 'os.date() did not return expected value when passed "!*t" [59]')

	local time = 917834400

	assertTrue (os.date ('%a', time) == 'Mon', 'os.date() did not return expected value when passed "%a" [60]')
	assertTrue (os.date ('%A', time) == 'Monday', 'os.date() did not return expected value when passed "%A" [61]')
	assertTrue (os.date ('%b', time) == 'Feb', 'os.date() did not return expected value when passed "%b" [62]')
	assertTrue (os.date ('%B', time) == 'February', 'os.date() did not return expected value when passed "%B" [63]')
	assertTrue (os.date ('%d', time) == '01', 'os.date() did not return expected value when passed "%d" [64]')
	assertTrue (os.date ('%H', time) == '02', 'os.date() did not return expected value when passed "%H" [65]')
	assertTrue (os.date ('%I', time) == '02', 'os.date() did not return expected value when passed "%I" [66]')
	assertTrue (os.date ('%j', time) == '032', 'os.date() did not return expected value when passed "%j" [67]')
	assertTrue (os.date ('%m', time) == '02', 'os.date() did not return expected value when passed "%m" [68]')
	assertTrue (os.date ('%M', time) == '00', 'os.date() did not return expected value when passed "%M" [69]')
	assertTrue (os.date ('%p', time) == 'AM', 'os.date() did not return expected value when passed "%p" [70]')
	assertTrue (os.date ('%S', time) == '00', 'os.date() did not return expected value when passed "%S" [71]')
	assertTrue (os.date ('%U', time) == '05', 'os.date() did not return expected value when passed "%U" [72]')
	assertTrue (os.date ('%w', time) == '1', 'os.date() did not return expected value when passed "%w" [73]')
	assertTrue (os.date ('%W', time) == '05', 'os.date() did not return expected value when passed "%W" [74]')
	assertTrue (os.date ('%x', time) == '02/01/99', 'os.date() did not return expected value when passed "%x" [75]')
	assertTrue (os.date ('%X', time) == '02:00:00', 'os.date() did not return expected value when passed "%X" [76]')
	assertTrue (os.date ('%y', time) == '99', 'os.date() did not return expected value when passed "%y" [77]')
	assertTrue (os.date ('%Y', time) == '1999', 'os.date() did not return expected value when passed "%Y" [78]')
	assertTrue (os.date ('%Z', time) == 'GMT', 'os.date() did not return expected value when passed "%Z" [79]')
	assertTrue (os.date ('%%', time) == '%', 'os.date() did not return expected value when passed "%%" [80]')
	assertTrue (os.date ('!%a', time) == 'Mon', 'os.date() did not return expected value when passed "!%a" [81]')
	assertTrue (os.date ('!%A', time) == 'Monday', 'os.date() did not return expected value when passed "!%A" [82]')
	assertTrue (os.date ('!%b', time) == 'Feb', 'os.date() did not return expected value when passed "!%b" [83]')
	assertTrue (os.date ('!%B', time) == 'February', 'os.date() did not return expected value when passed "!%B" [84]')
	assertTrue (os.date ('!%d', time) == '01', 'os.date() did not return expected value when passed "!%d" [85]')
	assertTrue (os.date ('!%H', time) == '02', 'os.date() did not return expected value when passed "!%H" [86]')
	assertTrue (os.date ('!%I', time) == '02', 'os.date() did not return expected value when passed "!%I" [87]')
	assertTrue (os.date ('!%j', time) == '032', 'os.date() did not return expected value when passed "!%j" [88]')
	assertTrue (os.date ('!%m', time) == '02', 'os.date() did not return expected value when passed "!%m" [89]')
	assertTrue (os.date ('!%M', time) == '00', 'os.date() did not return expected value when passed "!%M" [90]')
	assertTrue (os.date ('!%p', time) == 'AM', 'os.date() did not return expected value when passed "!%p" [91]')
	assertTrue (os.date ('!%S', time) == '00', 'os.date() did not return expected value when passed "!%S" [92]')
	assertTrue (os.date ('!%U', time) == '05', 'os.date() did not return expected value when passed "!%U" [93]')
	assertTrue (os.date ('!%w', time) == '1', 'os.date() did not return expected value when passed "!%w" [94]')
	assertTrue (os.date ('!%W', time) == '05', 'os.date() did not return expected value when passed "!%W" [95]')
	assertTrue (os.date ('!%x', time) == '02/01/99', 'os.date() did not return expected value when passed "!%x" [96]')
	assertTrue (os.date ('!%X', time) == '02:00:00', 'os.date() did not return expected value when passed "!%X" [97]')
	assertTrue (os.date ('!%y', time) == '99', 'os.date() did not return expected value when passed "!%y" [98]')
	assertTrue (os.date ('!%Y', time) == '1999', 'os.date() did not return expected value when passed "!%Y" [99]')
	assertTrue (os.date ('!%Z', time) == 'UTC', 'os.date() did not return expected value when passed "!%Z" [100]')
	assertTrue (os.date ('*t', time).hour == 2, 'os.date() did not return expected value when passed "*t" [101]')
	assertTrue (os.date ('*t', time).min == 0, 'os.date() did not return expected value when passed "*t" [102]')
	assertTrue (os.date ('*t', time).wday == 2, 'os.date() did not return expected value when passed "*t" [103]')
	assertTrue (os.date ('*t', time).day == 1, 'os.date() did not return expected value when passed "*t" [104]')
	assertTrue (os.date ('*t', time).month == 2, 'os.date() did not return expected value when passed "*t" [105]')
	assertTrue (os.date ('*t', time).year == 1999, 'os.date() did not return expected value when passed "*t" [106]')
	assertTrue (os.date ('*t', time).sec == 0, 'os.date() did not return expected value when passed "*t" [107]')
	assertTrue (os.date ('*t', time).yday == 32, 'os.date() did not return expected value when passed "*t" [108]')
	assertTrue (os.date ('*t', time).isdst == false, 'os.date() did not return expected value when passed "*t" [109]')
	assertTrue (os.date ('!*t', time).hour == 2, 'os.date() did not return expected value when passed "!*t" [110]')
	assertTrue (os.date ('!*t', time).min == 0, 'os.date() did not return expected value when passed "!*t" [111]')
	assertTrue (os.date ('!*t', time).wday == 2, 'os.date() did not return expected value when passed "!*t" [112]')
	assertTrue (os.date ('!*t', time).day == 1, 'os.date() did not return expected value when passed "!*t" [113]')
	assertTrue (os.date ('!*t', time).month == 2, 'os.date() did not return expected value when passed "!*t" [114]')
	assertTrue (os.date ('!*t', time).year == 1999, 'os.date() did not return expected value when passed "!*t" [115]')
	assertTrue (os.date ('!*t', time).sec == 0, 'os.date() did not return expected value when passed "!*t" [116]')
	assertTrue (os.date ('!*t', time).yday == 32, 'os.date() did not return expected value when passed "!*t" [117]')
	assertTrue (os.date ('!*t', time).isdst == false, 'os.date() did not return expected value when passed "!*t" [118]')

	local time = 920167200

	assertTrue (os.date ('%a', time) == 'Sun', 'os.date() did not return expected value when passed "%a" [119]')
	assertTrue (os.date ('%A', time) == 'Sunday', 'os.date() did not return expected value when passed "%A" [120]')
	assertTrue (os.date ('%b', time) == 'Feb', 'os.date() did not return expected value when passed "%b" [121]')
	assertTrue (os.date ('%B', time) == 'February', 'os.date() did not return expected value when passed "%B" [122]')
	assertTrue (os.date ('%d', time) == '28', 'os.date() did not return expected value when passed "%d" [123]')
	assertTrue (os.date ('%H', time) == '02', 'os.date() did not return expected value when passed "%H" [124]')
	assertTrue (os.date ('%I', time) == '02', 'os.date() did not return expected value when passed "%I" [125]')
	assertTrue (os.date ('%j', time) == '059', 'os.date() did not return expected value when passed "%j" [126]')
	assertTrue (os.date ('%m', time) == '02', 'os.date() did not return expected value when passed "%m" [127]')
	assertTrue (os.date ('%M', time) == '00', 'os.date() did not return expected value when passed "%M" [128]')
	assertTrue (os.date ('%p', time) == 'AM', 'os.date() did not return expected value when passed "%p" [129]')
	assertTrue (os.date ('%S', time) == '00', 'os.date() did not return expected value when passed "%S" [130]')
	assertTrue (os.date ('%U', time) == '09', 'os.date() did not return expected value when passed "%U" [131]')
	assertTrue (os.date ('%w', time) == '0', 'os.date() did not return expected value when passed "%w" [132]')
	assertTrue (os.date ('%W', time) == '08', 'os.date() did not return expected value when passed "%W" [133]')
	assertTrue (os.date ('%x', time) == '02/28/99', 'os.date() did not return expected value when passed "%x" [134]')
	assertTrue (os.date ('%X', time) == '02:00:00', 'os.date() did not return expected value when passed "%X" [135]')
	assertTrue (os.date ('%y', time) == '99', 'os.date() did not return expected value when passed "%y" [136]')
	assertTrue (os.date ('%Y', time) == '1999', 'os.date() did not return expected value when passed "%Y" [137]')
	assertTrue (os.date ('%Z', time) == 'GMT', 'os.date() did not return expected value when passed "%Z" [138]')
	assertTrue (os.date ('%%', time) == '%', 'os.date() did not return expected value when passed "%%" [139]')
	assertTrue (os.date ('!%a', time) == 'Sun', 'os.date() did not return expected value when passed "!%a" [140]')
	assertTrue (os.date ('!%A', time) == 'Sunday', 'os.date() did not return expected value when passed "!%A" [141]')
	assertTrue (os.date ('!%b', time) == 'Feb', 'os.date() did not return expected value when passed "!%b" [142]')
	assertTrue (os.date ('!%B', time) == 'February', 'os.date() did not return expected value when passed "!%B" [143]')
	assertTrue (os.date ('!%d', time) == '28', 'os.date() did not return expected value when passed "!%d" [144]')
	assertTrue (os.date ('!%H', time) == '02', 'os.date() did not return expected value when passed "!%H" [145]')
	assertTrue (os.date ('!%I', time) == '02', 'os.date() did not return expected value when passed "!%I" [146]')
	assertTrue (os.date ('!%j', time) == '059', 'os.date() did not return expected value when passed "!%j" [147]')
	assertTrue (os.date ('!%m', time) == '02', 'os.date() did not return expected value when passed "!%m" [148]')
	assertTrue (os.date ('!%M', time) == '00', 'os.date() did not return expected value when passed "!%M" [149]')
	assertTrue (os.date ('!%p', time) == 'AM', 'os.date() did not return expected value when passed "!%p" [150]')
	assertTrue (os.date ('!%S', time) == '00', 'os.date() did not return expected value when passed "!%S" [151]')
	assertTrue (os.date ('!%U', time) == '09', 'os.date() did not return expected value when passed "!%U" [152]')
	assertTrue (os.date ('!%w', time) == '0', 'os.date() did not return expected value when passed "!%w" [153]')
	assertTrue (os.date ('!%W', time) == '08', 'os.date() did not return expected value when passed "!%W" [154]')
	assertTrue (os.date ('!%x', time) == '02/28/99', 'os.date() did not return expected value when passed "!%x" [155]')
	assertTrue (os.date ('!%X', time) == '02:00:00', 'os.date() did not return expected value when passed "!%X" [156]')
	assertTrue (os.date ('!%y', time) == '99', 'os.date() did not return expected value when passed "!%y" [157]')
	assertTrue (os.date ('!%Y', time) == '1999', 'os.date() did not return expected value when passed "!%Y" [158]')
	assertTrue (os.date ('!%Z', time) == 'UTC', 'os.date() did not return expected value when passed "!%Z" [159]')
	assertTrue (os.date ('*t', time).hour == 2, 'os.date() did not return expected value when passed "*t" [160]')
	assertTrue (os.date ('*t', time).min == 0, 'os.date() did not return expected value when passed "*t" [161]')
	assertTrue (os.date ('*t', time).wday == 1, 'os.date() did not return expected value when passed "*t" [162]')
	assertTrue (os.date ('*t', time).day == 28, 'os.date() did not return expected value when passed "*t" [163]')
	assertTrue (os.date ('*t', time).month == 2, 'os.date() did not return expected value when passed "*t" [164]')
	assertTrue (os.date ('*t', time).year == 1999, 'os.date() did not return expected value when passed "*t" [165]')
	assertTrue (os.date ('*t', time).sec == 0, 'os.date() did not return expected value when passed "*t" [166]')
	assertTrue (os.date ('*t', time).yday == 59, 'os.date() did not return expected value when passed "*t" [167]')
	assertTrue (os.date ('*t', time).isdst == false, 'os.date() did not return expected value when passed "*t" [168]')
	assertTrue (os.date ('!*t', time).hour == 2, 'os.date() did not return expected value when passed "!*t" [169]')
	assertTrue (os.date ('!*t', time).min == 0, 'os.date() did not return expected value when passed "!*t" [170]')
	assertTrue (os.date ('!*t', time).wday == 1, 'os.date() did not return expected value when passed "!*t" [171]')
	assertTrue (os.date ('!*t', time).day == 28, 'os.date() did not return expected value when passed "!*t" [172]')
	assertTrue (os.date ('!*t', time).month == 2, 'os.date() did not return expected value when passed "!*t" [173]')
	assertTrue (os.date ('!*t', time).year == 1999, 'os.date() did not return expected value when passed "!*t" [174]')
	assertTrue (os.date ('!*t', time).sec == 0, 'os.date() did not return expected value when passed "!*t" [175]')
	assertTrue (os.date ('!*t', time).yday == 59, 'os.date() did not return expected value when passed "!*t" [176]')
	assertTrue (os.date ('!*t', time).isdst == false, 'os.date() did not return expected value when passed "!*t" [177]')

	local time = 920253600

	assertTrue (os.date ('%a', time) == 'Mon', 'os.date() did not return expected value when passed "%a" [178]')
	assertTrue (os.date ('%A', time) == 'Monday', 'os.date() did not return expected value when passed "%A" [179]')
	assertTrue (os.date ('%b', time) == 'Mar', 'os.date() did not return expected value when passed "%b" [180]')
	assertTrue (os.date ('%B', time) == 'March', 'os.date() did not return expected value when passed "%B" [181]')
	assertTrue (os.date ('%d', time) == '01', 'os.date() did not return expected value when passed "%d" [182]')
	assertTrue (os.date ('%H', time) == '02', 'os.date() did not return expected value when passed "%H" [183]')
	assertTrue (os.date ('%I', time) == '02', 'os.date() did not return expected value when passed "%I" [184]')
	assertTrue (os.date ('%j', time) == '060', 'os.date() did not return expected value when passed "%j" [185]')
	assertTrue (os.date ('%m', time) == '03', 'os.date() did not return expected value when passed "%m" [186]')
	assertTrue (os.date ('%M', time) == '00', 'os.date() did not return expected value when passed "%M" [187]')
	assertTrue (os.date ('%p', time) == 'AM', 'os.date() did not return expected value when passed "%p" [188]')
	assertTrue (os.date ('%S', time) == '00', 'os.date() did not return expected value when passed "%S" [189]')
	assertTrue (os.date ('%U', time) == '09', 'os.date() did not return expected value when passed "%U" [190]')
	assertTrue (os.date ('%w', time) == '1', 'os.date() did not return expected value when passed "%w" [191]')
	assertTrue (os.date ('%W', time) == '09', 'os.date() did not return expected value when passed "%W" [192]')
	assertTrue (os.date ('%x', time) == '03/01/99', 'os.date() did not return expected value when passed "%x" [193]')
	assertTrue (os.date ('%X', time) == '02:00:00', 'os.date() did not return expected value when passed "%X" [194]')
	assertTrue (os.date ('%y', time) == '99', 'os.date() did not return expected value when passed "%y" [195]')
	assertTrue (os.date ('%Y', time) == '1999', 'os.date() did not return expected value when passed "%Y" [196]')
	assertTrue (os.date ('%Z', time) == 'GMT', 'os.date() did not return expected value when passed "%Z" [197]')
	assertTrue (os.date ('%%', time) == '%', 'os.date() did not return expected value when passed "%%" [198]')
	assertTrue (os.date ('!%a', time) == 'Mon', 'os.date() did not return expected value when passed "!%a" [199]')
	assertTrue (os.date ('!%A', time) == 'Monday', 'os.date() did not return expected value when passed "!%A" [200]')
	assertTrue (os.date ('!%b', time) == 'Mar', 'os.date() did not return expected value when passed "!%b" [201]')
	assertTrue (os.date ('!%B', time) == 'March', 'os.date() did not return expected value when passed "!%B" [202]')
	assertTrue (os.date ('!%d', time) == '01', 'os.date() did not return expected value when passed "!%d" [203]')
	assertTrue (os.date ('!%H', time) == '02', 'os.date() did not return expected value when passed "!%H" [204]')
	assertTrue (os.date ('!%I', time) == '02', 'os.date() did not return expected value when passed "!%I" [205]')
	assertTrue (os.date ('!%j', time) == '060', 'os.date() did not return expected value when passed "!%j" [206]')
	assertTrue (os.date ('!%m', time) == '03', 'os.date() did not return expected value when passed "!%m" [207]')
	assertTrue (os.date ('!%M', time) == '00', 'os.date() did not return expected value when passed "!%M" [208]')
	assertTrue (os.date ('!%p', time) == 'AM', 'os.date() did not return expected value when passed "!%p" [209]')
	assertTrue (os.date ('!%S', time) == '00', 'os.date() did not return expected value when passed "!%S" [210]')
	assertTrue (os.date ('!%U', time) == '09', 'os.date() did not return expected value when passed "!%U" [211]')
	assertTrue (os.date ('!%w', time) == '1', 'os.date() did not return expected value when passed "!%w" [212]')
	assertTrue (os.date ('!%W', time) == '09', 'os.date() did not return expected value when passed "!%W" [213]')
	assertTrue (os.date ('!%x', time) == '03/01/99', 'os.date() did not return expected value when passed "!%x" [214]')
	assertTrue (os.date ('!%X', time) == '02:00:00', 'os.date() did not return expected value when passed "!%X" [215]')
	assertTrue (os.date ('!%y', time) == '99', 'os.date() did not return expected value when passed "!%y" [216]')
	assertTrue (os.date ('!%Y', time) == '1999', 'os.date() did not return expected value when passed "!%Y" [217]')
	assertTrue (os.date ('!%Z', time) == 'UTC', 'os.date() did not return expected value when passed "!%Z" [218]')
	assertTrue (os.date ('*t', time).hour == 2, 'os.date() did not return expected value when passed "*t" [219]')
	assertTrue (os.date ('*t', time).min == 0, 'os.date() did not return expected value when passed "*t" [220]')
	assertTrue (os.date ('*t', time).wday == 2, 'os.date() did not return expected value when passed "*t" [221]')
	assertTrue (os.date ('*t', time).day == 1, 'os.date() did not return expected value when passed "*t" [222]')
	assertTrue (os.date ('*t', time).month == 3, 'os.date() did not return expected value when passed "*t" [223]')
	assertTrue (os.date ('*t', time).year == 1999, 'os.date() did not return expected value when passed "*t" [224]')
	assertTrue (os.date ('*t', time).sec == 0, 'os.date() did not return expected value when passed "*t" [225]')
	assertTrue (os.date ('*t', time).yday == 60, 'os.date() did not return expected value when passed "*t" [226]')
	assertTrue (os.date ('*t', time).isdst == false, 'os.date() did not return expected value when passed "*t" [227]')
	assertTrue (os.date ('!*t', time).hour == 2, 'os.date() did not return expected value when passed "!*t" [228]')
	assertTrue (os.date ('!*t', time).min == 0, 'os.date() did not return expected value when passed "!*t" [229]')
	assertTrue (os.date ('!*t', time).wday == 2, 'os.date() did not return expected value when passed "!*t" [230]')
	assertTrue (os.date ('!*t', time).day == 1, 'os.date() did not return expected value when passed "!*t" [231]')
	assertTrue (os.date ('!*t', time).month == 3, 'os.date() did not return expected value when passed "!*t" [232]')
	assertTrue (os.date ('!*t', time).year == 1999, 'os.date() did not return expected value when passed "!*t" [233]')
	assertTrue (os.date ('!*t', time).sec == 0, 'os.date() did not return expected value when passed "!*t" [234]')
	assertTrue (os.date ('!*t', time).yday == 60, 'os.date() did not return expected value when passed "!*t" [235]')
	assertTrue (os.date ('!*t', time).isdst == false, 'os.date() did not return expected value when passed "!*t" [236]')

	local time = 920257200

	assertTrue (os.date ('%a', time) == 'Mon', 'os.date() did not return expected value when passed "%a" [237]')
	assertTrue (os.date ('%A', time) == 'Monday', 'os.date() did not return expected value when passed "%A" [238]')
	assertTrue (os.date ('%b', time) == 'Mar', 'os.date() did not return expected value when passed "%b" [239]')
	assertTrue (os.date ('%B', time) == 'March', 'os.date() did not return expected value when passed "%B" [240]')
	assertTrue (os.date ('%d', time) == '01', 'os.date() did not return expected value when passed "%d" [241]')
	assertTrue (os.date ('%H', time) == '03', 'os.date() did not return expected value when passed "%H" [242]')
	assertTrue (os.date ('%I', time) == '03', 'os.date() did not return expected value when passed "%I" [243]')
	assertTrue (os.date ('%j', time) == '060', 'os.date() did not return expected value when passed "%j" [244]')
	assertTrue (os.date ('%m', time) == '03', 'os.date() did not return expected value when passed "%m" [245]')
	assertTrue (os.date ('%M', time) == '00', 'os.date() did not return expected value when passed "%M" [246]')
	assertTrue (os.date ('%p', time) == 'AM', 'os.date() did not return expected value when passed "%p" [247]')
	assertTrue (os.date ('%S', time) == '00', 'os.date() did not return expected value when passed "%S" [248]')
	assertTrue (os.date ('%U', time) == '09', 'os.date() did not return expected value when passed "%U" [249]')
	assertTrue (os.date ('%w', time) == '1', 'os.date() did not return expected value when passed "%w" [250]')
	assertTrue (os.date ('%W', time) == '09', 'os.date() did not return expected value when passed "%W" [251]')
	assertTrue (os.date ('%x', time) == '03/01/99', 'os.date() did not return expected value when passed "%x" [252]')
	assertTrue (os.date ('%X', time) == '03:00:00', 'os.date() did not return expected value when passed "%X" [253]')
	assertTrue (os.date ('%y', time) == '99', 'os.date() did not return expected value when passed "%y" [254]')
	assertTrue (os.date ('%Y', time) == '1999', 'os.date() did not return expected value when passed "%Y" [255]')
	assertTrue (os.date ('%Z', time) == 'GMT', 'os.date() did not return expected value when passed "%Z" [256]')
	assertTrue (os.date ('%%', time) == '%', 'os.date() did not return expected value when passed "%%" [257]')
	assertTrue (os.date ('!%a', time) == 'Mon', 'os.date() did not return expected value when passed "!%a" [258]')
	assertTrue (os.date ('!%A', time) == 'Monday', 'os.date() did not return expected value when passed "!%A" [259]')
	assertTrue (os.date ('!%b', time) == 'Mar', 'os.date() did not return expected value when passed "!%b" [260]')
	assertTrue (os.date ('!%B', time) == 'March', 'os.date() did not return expected value when passed "!%B" [261]')
	assertTrue (os.date ('!%d', time) == '01', 'os.date() did not return expected value when passed "!%d" [262]')
	assertTrue (os.date ('!%H', time) == '03', 'os.date() did not return expected value when passed "!%H" [263]')
	assertTrue (os.date ('!%I', time) == '03', 'os.date() did not return expected value when passed "!%I" [264]')
	assertTrue (os.date ('!%j', time) == '060', 'os.date() did not return expected value when passed "!%j" [265]')
	assertTrue (os.date ('!%m', time) == '03', 'os.date() did not return expected value when passed "!%m" [266]')
	assertTrue (os.date ('!%M', time) == '00', 'os.date() did not return expected value when passed "!%M" [267]')
	assertTrue (os.date ('!%p', time) == 'AM', 'os.date() did not return expected value when passed "!%p" [268]')
	assertTrue (os.date ('!%S', time) == '00', 'os.date() did not return expected value when passed "!%S" [269]')
	assertTrue (os.date ('!%U', time) == '09', 'os.date() did not return expected value when passed "!%U" [270]')
	assertTrue (os.date ('!%w', time) == '1', 'os.date() did not return expected value when passed "!%w" [271]')
	assertTrue (os.date ('!%W', time) == '09', 'os.date() did not return expected value when passed "!%W" [272]')
	assertTrue (os.date ('!%x', time) == '03/01/99', 'os.date() did not return expected value when passed "!%x" [273]')
	assertTrue (os.date ('!%X', time) == '03:00:00', 'os.date() did not return expected value when passed "!%X" [274]')
	assertTrue (os.date ('!%y', time) == '99', 'os.date() did not return expected value when passed "!%y" [275]')
	assertTrue (os.date ('!%Y', time) == '1999', 'os.date() did not return expected value when passed "!%Y" [276]')
	assertTrue (os.date ('!%Z', time) == 'UTC', 'os.date() did not return expected value when passed "!%Z" [277]')
	assertTrue (os.date ('*t', time).hour == 3, 'os.date() did not return expected value when passed "*t" [278]')
	assertTrue (os.date ('*t', time).min == 0, 'os.date() did not return expected value when passed "*t" [279]')
	assertTrue (os.date ('*t', time).wday == 2, 'os.date() did not return expected value when passed "*t" [280]')
	assertTrue (os.date ('*t', time).day == 1, 'os.date() did not return expected value when passed "*t" [281]')
	assertTrue (os.date ('*t', time).month == 3, 'os.date() did not return expected value when passed "*t" [282]')
	assertTrue (os.date ('*t', time).year == 1999, 'os.date() did not return expected value when passed "*t" [283]')
	assertTrue (os.date ('*t', time).sec == 0, 'os.date() did not return expected value when passed "*t" [284]')
	assertTrue (os.date ('*t', time).yday == 60, 'os.date() did not return expected value when passed "*t" [285]')
	assertTrue (os.date ('*t', time).isdst == false, 'os.date() did not return expected value when passed "*t" [286]')
	assertTrue (os.date ('!*t', time).hour == 3, 'os.date() did not return expected value when passed "!*t" [287]')
	assertTrue (os.date ('!*t', time).min == 0, 'os.date() did not return expected value when passed "!*t" [288]')
	assertTrue (os.date ('!*t', time).wday == 2, 'os.date() did not return expected value when passed "!*t" [289]')
	assertTrue (os.date ('!*t', time).day == 1, 'os.date() did not return expected value when passed "!*t" [290]')
	assertTrue (os.date ('!*t', time).month == 3, 'os.date() did not return expected value when passed "!*t" [291]')
	assertTrue (os.date ('!*t', time).year == 1999, 'os.date() did not return expected value when passed "!*t" [292]')
	assertTrue (os.date ('!*t', time).sec == 0, 'os.date() did not return expected value when passed "!*t" [293]')
	assertTrue (os.date ('!*t', time).yday == 60, 'os.date() did not return expected value when passed "!*t" [294]')
	assertTrue (os.date ('!*t', time).isdst == false, 'os.date() did not return expected value when passed "!*t" [295]')

	local time = 946641600

	assertTrue (os.date ('%a', time) == 'Fri', 'os.date() did not return expected value when passed "%a" [296]')
	assertTrue (os.date ('%A', time) == 'Friday', 'os.date() did not return expected value when passed "%A" [297]')
	assertTrue (os.date ('%b', time) == 'Dec', 'os.date() did not return expected value when passed "%b" [298]')
	assertTrue (os.date ('%B', time) == 'December', 'os.date() did not return expected value when passed "%B" [299]')
	assertTrue (os.date ('%d', time) == '31', 'os.date() did not return expected value when passed "%d" [300]')
	assertTrue (os.date ('%H', time) == '12', 'os.date() did not return expected value when passed "%H" [301]')
	assertTrue (os.date ('%I', time) == '12', 'os.date() did not return expected value when passed "%I" [302]')
	assertTrue (os.date ('%j', time) == '365', 'os.date() did not return expected value when passed "%j" [303]')
	assertTrue (os.date ('%m', time) == '12', 'os.date() did not return expected value when passed "%m" [304]')
	assertTrue (os.date ('%M', time) == '00', 'os.date() did not return expected value when passed "%M" [305]')
	assertTrue (os.date ('%p', time) == 'PM', 'os.date() did not return expected value when passed "%p" [306]')
	assertTrue (os.date ('%S', time) == '00', 'os.date() did not return expected value when passed "%S" [307]')
	assertTrue (os.date ('%U', time) == '52', 'os.date() did not return expected value when passed "%U" [308]')
	assertTrue (os.date ('%w', time) == '5', 'os.date() did not return expected value when passed "%w" [309]')
	assertTrue (os.date ('%W', time) == '52', 'os.date() did not return expected value when passed "%W" [310]')
	assertTrue (os.date ('%x', time) == '12/31/99', 'os.date() did not return expected value when passed "%x" [311]')
	assertTrue (os.date ('%X', time) == '12:00:00', 'os.date() did not return expected value when passed "%X" [312]')
	assertTrue (os.date ('%y', time) == '99', 'os.date() did not return expected value when passed "%y" [313]')
	assertTrue (os.date ('%Y', time) == '1999', 'os.date() did not return expected value when passed "%Y" [314]')
	assertTrue (os.date ('%Z', time) == 'GMT', 'os.date() did not return expected value when passed "%Z" [315]')
	assertTrue (os.date ('%%', time) == '%', 'os.date() did not return expected value when passed "%%" [316]')
	assertTrue (os.date ('!%a', time) == 'Fri', 'os.date() did not return expected value when passed "!%a" [317]')
	assertTrue (os.date ('!%A', time) == 'Friday', 'os.date() did not return expected value when passed "!%A" [318]')
	assertTrue (os.date ('!%b', time) == 'Dec', 'os.date() did not return expected value when passed "!%b" [319]')
	assertTrue (os.date ('!%B', time) == 'December', 'os.date() did not return expected value when passed "!%B" [320]')
	assertTrue (os.date ('!%d', time) == '31', 'os.date() did not return expected value when passed "!%d" [321]')
	assertTrue (os.date ('!%H', time) == '12', 'os.date() did not return expected value when passed "!%H" [322]')
	assertTrue (os.date ('!%I', time) == '12', 'os.date() did not return expected value when passed "!%I" [323]')
	assertTrue (os.date ('!%j', time) == '365', 'os.date() did not return expected value when passed "!%j" [324]')
	assertTrue (os.date ('!%m', time) == '12', 'os.date() did not return expected value when passed "!%m" [325]')
	assertTrue (os.date ('!%M', time) == '00', 'os.date() did not return expected value when passed "!%M" [326]')
	assertTrue (os.date ('!%p', time) == 'PM', 'os.date() did not return expected value when passed "!%p" [327]')
	assertTrue (os.date ('!%S', time) == '00', 'os.date() did not return expected value when passed "!%S" [328]')
	assertTrue (os.date ('!%U', time) == '52', 'os.date() did not return expected value when passed "!%U" [329]')
	assertTrue (os.date ('!%w', time) == '5', 'os.date() did not return expected value when passed "!%w" [330]')
	assertTrue (os.date ('!%W', time) == '52', 'os.date() did not return expected value when passed "!%W" [331]')
	assertTrue (os.date ('!%x', time) == '12/31/99', 'os.date() did not return expected value when passed "!%x" [332]')
	assertTrue (os.date ('!%X', time) == '12:00:00', 'os.date() did not return expected value when passed "!%X" [333]')
	assertTrue (os.date ('!%y', time) == '99', 'os.date() did not return expected value when passed "!%y" [334]')
	assertTrue (os.date ('!%Y', time) == '1999', 'os.date() did not return expected value when passed "!%Y" [335]')
	assertTrue (os.date ('!%Z', time) == 'UTC', 'os.date() did not return expected value when passed "!%Z" [336]')
	assertTrue (os.date ('*t', time).hour == 12, 'os.date() did not return expected value when passed "*t" [337]')
	assertTrue (os.date ('*t', time).min == 0, 'os.date() did not return expected value when passed "*t" [338]')
	assertTrue (os.date ('*t', time).wday == 6, 'os.date() did not return expected value when passed "*t" [339]')
	assertTrue (os.date ('*t', time).day == 31, 'os.date() did not return expected value when passed "*t" [340]')
	assertTrue (os.date ('*t', time).month == 12, 'os.date() did not return expected value when passed "*t" [341]')
	assertTrue (os.date ('*t', time).year == 1999, 'os.date() did not return expected value when passed "*t" [342]')
	assertTrue (os.date ('*t', time).sec == 0, 'os.date() did not return expected value when passed "*t" [343]')
	assertTrue (os.date ('*t', time).yday == 365, 'os.date() did not return expected value when passed "*t" [344]')
	assertTrue (os.date ('*t', time).isdst == false, 'os.date() did not return expected value when passed "*t" [345]')
	assertTrue (os.date ('!*t', time).hour == 12, 'os.date() did not return expected value when passed "!*t" [346]')
	assertTrue (os.date ('!*t', time).min == 0, 'os.date() did not return expected value when passed "!*t" [347]')
	assertTrue (os.date ('!*t', time).wday == 6, 'os.date() did not return expected value when passed "!*t" [348]')
	assertTrue (os.date ('!*t', time).day == 31, 'os.date() did not return expected value when passed "!*t" [349]')
	assertTrue (os.date ('!*t', time).month == 12, 'os.date() did not return expected value when passed "!*t" [350]')
	assertTrue (os.date ('!*t', time).year == 1999, 'os.date() did not return expected value when passed "!*t" [351]')
	assertTrue (os.date ('!*t', time).sec == 0, 'os.date() did not return expected value when passed "!*t" [352]')
	assertTrue (os.date ('!*t', time).yday == 365, 'os.date() did not return expected value when passed "!*t" [353]')
	assertTrue (os.date ('!*t', time).isdst == false, 'os.date() did not return expected value when passed "!*t" [354]')

	local time = 946688400

	assertTrue (os.date ('%a', time) == 'Sat', 'os.date() did not return expected value when passed "%a" [355]')
	assertTrue (os.date ('%A', time) == 'Saturday', 'os.date() did not return expected value when passed "%A" [356]')
	assertTrue (os.date ('%b', time) == 'Jan', 'os.date() did not return expected value when passed "%b" [357]')
	assertTrue (os.date ('%B', time) == 'January', 'os.date() did not return expected value when passed "%B" [358]')
	assertTrue (os.date ('%d', time) == '01', 'os.date() did not return expected value when passed "%d" [359]')
	assertTrue (os.date ('%H', time) == '01', 'os.date() did not return expected value when passed "%H" [360]')
	assertTrue (os.date ('%I', time) == '01', 'os.date() did not return expected value when passed "%I" [361]')
	assertTrue (os.date ('%j', time) == '001', 'os.date() did not return expected value when passed "%j" [362]')
	assertTrue (os.date ('%m', time) == '01', 'os.date() did not return expected value when passed "%m" [363]')
	assertTrue (os.date ('%M', time) == '00', 'os.date() did not return expected value when passed "%M" [364]')
	assertTrue (os.date ('%p', time) == 'AM', 'os.date() did not return expected value when passed "%p" [365]')
	assertTrue (os.date ('%S', time) == '00', 'os.date() did not return expected value when passed "%S" [366]')
	assertTrue (os.date ('%U', time) == '00', 'os.date() did not return expected value when passed "%U" [367]')
	assertTrue (os.date ('%w', time) == '6', 'os.date() did not return expected value when passed "%w" [368]')
	assertTrue (os.date ('%W', time) == '00', 'os.date() did not return expected value when passed "%W" [369]')
	assertTrue (os.date ('%x', time) == '01/01/00', 'os.date() did not return expected value when passed "%x" [370]')
	assertTrue (os.date ('%X', time) == '01:00:00', 'os.date() did not return expected value when passed "%X" [371]')
	assertTrue (os.date ('%y', time) == '00', 'os.date() did not return expected value when passed "%y" [372]')
	assertTrue (os.date ('%Y', time) == '2000', 'os.date() did not return expected value when passed "%Y" [373]')
	assertTrue (os.date ('%Z', time) == 'GMT', 'os.date() did not return expected value when passed "%Z" [374]')
	assertTrue (os.date ('%%', time) == '%', 'os.date() did not return expected value when passed "%%" [375]')
	assertTrue (os.date ('!%a', time) == 'Sat', 'os.date() did not return expected value when passed "!%a" [376]')
	assertTrue (os.date ('!%A', time) == 'Saturday', 'os.date() did not return expected value when passed "!%A" [377]')
	assertTrue (os.date ('!%b', time) == 'Jan', 'os.date() did not return expected value when passed "!%b" [378]')
	assertTrue (os.date ('!%B', time) == 'January', 'os.date() did not return expected value when passed "!%B" [379]')
	assertTrue (os.date ('!%d', time) == '01', 'os.date() did not return expected value when passed "!%d" [380]')
	assertTrue (os.date ('!%H', time) == '01', 'os.date() did not return expected value when passed "!%H" [381]')
	assertTrue (os.date ('!%I', time) == '01', 'os.date() did not return expected value when passed "!%I" [382]')
	assertTrue (os.date ('!%j', time) == '001', 'os.date() did not return expected value when passed "!%j" [383]')
	assertTrue (os.date ('!%m', time) == '01', 'os.date() did not return expected value when passed "!%m" [384]')
	assertTrue (os.date ('!%M', time) == '00', 'os.date() did not return expected value when passed "!%M" [385]')
	assertTrue (os.date ('!%p', time) == 'AM', 'os.date() did not return expected value when passed "!%p" [386]')
	assertTrue (os.date ('!%S', time) == '00', 'os.date() did not return expected value when passed "!%S" [387]')
	assertTrue (os.date ('!%U', time) == '00', 'os.date() did not return expected value when passed "!%U" [388]')
	assertTrue (os.date ('!%w', time) == '6', 'os.date() did not return expected value when passed "!%w" [389]')
	assertTrue (os.date ('!%W', time) == '00', 'os.date() did not return expected value when passed "!%W" [390]')
	assertTrue (os.date ('!%x', time) == '01/01/00', 'os.date() did not return expected value when passed "!%x" [391]')
	assertTrue (os.date ('!%X', time) == '01:00:00', 'os.date() did not return expected value when passed "!%X" [392]')
	assertTrue (os.date ('!%y', time) == '00', 'os.date() did not return expected value when passed "!%y" [393]')
	assertTrue (os.date ('!%Y', time) == '2000', 'os.date() did not return expected value when passed "!%Y" [394]')
	assertTrue (os.date ('!%Z', time) == 'UTC', 'os.date() did not return expected value when passed "!%Z" [395]')
	assertTrue (os.date ('*t', time).hour == 1, 'os.date() did not return expected value when passed "*t" [396]')
	assertTrue (os.date ('*t', time).min == 0, 'os.date() did not return expected value when passed "*t" [397]')
	assertTrue (os.date ('*t', time).wday == 7, 'os.date() did not return expected value when passed "*t" [398]')
	assertTrue (os.date ('*t', time).day == 1, 'os.date() did not return expected value when passed "*t" [399]')
	assertTrue (os.date ('*t', time).month == 1, 'os.date() did not return expected value when passed "*t" [400]')
	assertTrue (os.date ('*t', time).year == 2000, 'os.date() did not return expected value when passed "*t" [401]')
	assertTrue (os.date ('*t', time).sec == 0, 'os.date() did not return expected value when passed "*t" [402]')
	assertTrue (os.date ('*t', time).yday == 1, 'os.date() did not return expected value when passed "*t" [403]')
	assertTrue (os.date ('*t', time).isdst == false, 'os.date() did not return expected value when passed "*t" [404]')
	assertTrue (os.date ('!*t', time).hour == 1, 'os.date() did not return expected value when passed "!*t" [405]')
	assertTrue (os.date ('!*t', time).min == 0, 'os.date() did not return expected value when passed "!*t" [406]')
	assertTrue (os.date ('!*t', time).wday == 7, 'os.date() did not return expected value when passed "!*t" [407]')
	assertTrue (os.date ('!*t', time).day == 1, 'os.date() did not return expected value when passed "!*t" [408]')
	assertTrue (os.date ('!*t', time).month == 1, 'os.date() did not return expected value when passed "!*t" [409]')
	assertTrue (os.date ('!*t', time).year == 2000, 'os.date() did not return expected value when passed "!*t" [410]')
	assertTrue (os.date ('!*t', time).sec == 0, 'os.date() did not return expected value when passed "!*t" [411]')
	assertTrue (os.date ('!*t', time).yday == 1, 'os.date() did not return expected value when passed "!*t" [412]')
	assertTrue (os.date ('!*t', time).isdst == false, 'os.date() did not return expected value when passed "!*t" [413]')

	local time = 949370400

	assertTrue (os.date ('%a', time) == 'Tue', 'os.date() did not return expected value when passed "%a" [414]')
	assertTrue (os.date ('%A', time) == 'Tuesday', 'os.date() did not return expected value when passed "%A" [415]')
	assertTrue (os.date ('%b', time) == 'Feb', 'os.date() did not return expected value when passed "%b" [416]')
	assertTrue (os.date ('%B', time) == 'February', 'os.date() did not return expected value when passed "%B" [417]')
	assertTrue (os.date ('%d', time) == '01', 'os.date() did not return expected value when passed "%d" [418]')
	assertTrue (os.date ('%H', time) == '02', 'os.date() did not return expected value when passed "%H" [419]')
	assertTrue (os.date ('%I', time) == '02', 'os.date() did not return expected value when passed "%I" [420]')
	assertTrue (os.date ('%j', time) == '032', 'os.date() did not return expected value when passed "%j" [421]')
	assertTrue (os.date ('%m', time) == '02', 'os.date() did not return expected value when passed "%m" [422]')
	assertTrue (os.date ('%M', time) == '00', 'os.date() did not return expected value when passed "%M" [423]')
	assertTrue (os.date ('%p', time) == 'AM', 'os.date() did not return expected value when passed "%p" [424]')
	assertTrue (os.date ('%S', time) == '00', 'os.date() did not return expected value when passed "%S" [425]')
	assertTrue (os.date ('%U', time) == '05', 'os.date() did not return expected value when passed "%U" [426]')
	assertTrue (os.date ('%w', time) == '2', 'os.date() did not return expected value when passed "%w" [427]')
	assertTrue (os.date ('%W', time) == '05', 'os.date() did not return expected value when passed "%W" [428]')
	assertTrue (os.date ('%x', time) == '02/01/00', 'os.date() did not return expected value when passed "%x" [429]')
	assertTrue (os.date ('%X', time) == '02:00:00', 'os.date() did not return expected value when passed "%X" [430]')
	assertTrue (os.date ('%y', time) == '00', 'os.date() did not return expected value when passed "%y" [431]')
	assertTrue (os.date ('%Y', time) == '2000', 'os.date() did not return expected value when passed "%Y" [432]')
	assertTrue (os.date ('%Z', time) == 'GMT', 'os.date() did not return expected value when passed "%Z" [433]')
	assertTrue (os.date ('%%', time) == '%', 'os.date() did not return expected value when passed "%%" [434]')
	assertTrue (os.date ('!%a', time) == 'Tue', 'os.date() did not return expected value when passed "!%a" [435]')
	assertTrue (os.date ('!%A', time) == 'Tuesday', 'os.date() did not return expected value when passed "!%A" [436]')
	assertTrue (os.date ('!%b', time) == 'Feb', 'os.date() did not return expected value when passed "!%b" [437]')
	assertTrue (os.date ('!%B', time) == 'February', 'os.date() did not return expected value when passed "!%B" [438]')
	assertTrue (os.date ('!%d', time) == '01', 'os.date() did not return expected value when passed "!%d" [439]')
	assertTrue (os.date ('!%H', time) == '02', 'os.date() did not return expected value when passed "!%H" [440]')
	assertTrue (os.date ('!%I', time) == '02', 'os.date() did not return expected value when passed "!%I" [441]')
	assertTrue (os.date ('!%j', time) == '032', 'os.date() did not return expected value when passed "!%j" [442]')
	assertTrue (os.date ('!%m', time) == '02', 'os.date() did not return expected value when passed "!%m" [443]')
	assertTrue (os.date ('!%M', time) == '00', 'os.date() did not return expected value when passed "!%M" [444]')
	assertTrue (os.date ('!%p', time) == 'AM', 'os.date() did not return expected value when passed "!%p" [445]')
	assertTrue (os.date ('!%S', time) == '00', 'os.date() did not return expected value when passed "!%S" [446]')
	assertTrue (os.date ('!%U', time) == '05', 'os.date() did not return expected value when passed "!%U" [447]')
	assertTrue (os.date ('!%w', time) == '2', 'os.date() did not return expected value when passed "!%w" [448]')
	assertTrue (os.date ('!%W', time) == '05', 'os.date() did not return expected value when passed "!%W" [449]')
	assertTrue (os.date ('!%x', time) == '02/01/00', 'os.date() did not return expected value when passed "!%x" [450]')
	assertTrue (os.date ('!%X', time) == '02:00:00', 'os.date() did not return expected value when passed "!%X" [451]')
	assertTrue (os.date ('!%y', time) == '00', 'os.date() did not return expected value when passed "!%y" [452]')
	assertTrue (os.date ('!%Y', time) == '2000', 'os.date() did not return expected value when passed "!%Y" [453]')
	assertTrue (os.date ('!%Z', time) == 'UTC', 'os.date() did not return expected value when passed "!%Z" [454]')
	assertTrue (os.date ('*t', time).hour == 2, 'os.date() did not return expected value when passed "*t" [455]')
	assertTrue (os.date ('*t', time).min == 0, 'os.date() did not return expected value when passed "*t" [456]')
	assertTrue (os.date ('*t', time).wday == 3, 'os.date() did not return expected value when passed "*t" [457]')
	assertTrue (os.date ('*t', time).day == 1, 'os.date() did not return expected value when passed "*t" [458]')
	assertTrue (os.date ('*t', time).month == 2, 'os.date() did not return expected value when passed "*t" [459]')
	assertTrue (os.date ('*t', time).year == 2000, 'os.date() did not return expected value when passed "*t" [460]')
	assertTrue (os.date ('*t', time).sec == 0, 'os.date() did not return expected value when passed "*t" [461]')
	assertTrue (os.date ('*t', time).yday == 32, 'os.date() did not return expected value when passed "*t" [462]')
	assertTrue (os.date ('*t', time).isdst == false, 'os.date() did not return expected value when passed "*t" [463]')
	assertTrue (os.date ('!*t', time).hour == 2, 'os.date() did not return expected value when passed "!*t" [464]')
	assertTrue (os.date ('!*t', time).min == 0, 'os.date() did not return expected value when passed "!*t" [465]')
	assertTrue (os.date ('!*t', time).wday == 3, 'os.date() did not return expected value when passed "!*t" [466]')
	assertTrue (os.date ('!*t', time).day == 1, 'os.date() did not return expected value when passed "!*t" [467]')
	assertTrue (os.date ('!*t', time).month == 2, 'os.date() did not return expected value when passed "!*t" [468]')
	assertTrue (os.date ('!*t', time).year == 2000, 'os.date() did not return expected value when passed "!*t" [469]')
	assertTrue (os.date ('!*t', time).sec == 0, 'os.date() did not return expected value when passed "!*t" [470]')
	assertTrue (os.date ('!*t', time).yday == 32, 'os.date() did not return expected value when passed "!*t" [471]')
	assertTrue (os.date ('!*t', time).isdst == false, 'os.date() did not return expected value when passed "!*t" [472]')

	local time = 951703200

	assertTrue (os.date ('%a', time) == 'Mon', 'os.date() did not return expected value when passed "%a" [473]')
	assertTrue (os.date ('%A', time) == 'Monday', 'os.date() did not return expected value when passed "%A" [474]')
	assertTrue (os.date ('%b', time) == 'Feb', 'os.date() did not return expected value when passed "%b" [475]')
	assertTrue (os.date ('%B', time) == 'February', 'os.date() did not return expected value when passed "%B" [476]')
	assertTrue (os.date ('%d', time) == '28', 'os.date() did not return expected value when passed "%d" [477]')
	assertTrue (os.date ('%H', time) == '02', 'os.date() did not return expected value when passed "%H" [478]')
	assertTrue (os.date ('%I', time) == '02', 'os.date() did not return expected value when passed "%I" [479]')
	assertTrue (os.date ('%j', time) == '059', 'os.date() did not return expected value when passed "%j" [480]')
	assertTrue (os.date ('%m', time) == '02', 'os.date() did not return expected value when passed "%m" [481]')
	assertTrue (os.date ('%M', time) == '00', 'os.date() did not return expected value when passed "%M" [482]')
	assertTrue (os.date ('%p', time) == 'AM', 'os.date() did not return expected value when passed "%p" [483]')
	assertTrue (os.date ('%S', time) == '00', 'os.date() did not return expected value when passed "%S" [484]')
	assertTrue (os.date ('%U', time) == '09', 'os.date() did not return expected value when passed "%U" [485]')
	assertTrue (os.date ('%w', time) == '1', 'os.date() did not return expected value when passed "%w" [486]')
	assertTrue (os.date ('%W', time) == '09', 'os.date() did not return expected value when passed "%W" [487]')
	assertTrue (os.date ('%x', time) == '02/28/00', 'os.date() did not return expected value when passed "%x" [488]')
	assertTrue (os.date ('%X', time) == '02:00:00', 'os.date() did not return expected value when passed "%X" [489]')
	assertTrue (os.date ('%y', time) == '00', 'os.date() did not return expected value when passed "%y" [490]')
	assertTrue (os.date ('%Y', time) == '2000', 'os.date() did not return expected value when passed "%Y" [491]')
	assertTrue (os.date ('%Z', time) == 'GMT', 'os.date() did not return expected value when passed "%Z" [492]')
	assertTrue (os.date ('%%', time) == '%', 'os.date() did not return expected value when passed "%%" [493]')
	assertTrue (os.date ('!%a', time) == 'Mon', 'os.date() did not return expected value when passed "!%a" [494]')
	assertTrue (os.date ('!%A', time) == 'Monday', 'os.date() did not return expected value when passed "!%A" [495]')
	assertTrue (os.date ('!%b', time) == 'Feb', 'os.date() did not return expected value when passed "!%b" [496]')
	assertTrue (os.date ('!%B', time) == 'February', 'os.date() did not return expected value when passed "!%B" [497]')
	assertTrue (os.date ('!%d', time) == '28', 'os.date() did not return expected value when passed "!%d" [498]')
	assertTrue (os.date ('!%H', time) == '02', 'os.date() did not return expected value when passed "!%H" [499]')
	assertTrue (os.date ('!%I', time) == '02', 'os.date() did not return expected value when passed "!%I" [500]')
	assertTrue (os.date ('!%j', time) == '059', 'os.date() did not return expected value when passed "!%j" [501]')
	assertTrue (os.date ('!%m', time) == '02', 'os.date() did not return expected value when passed "!%m" [502]')
	assertTrue (os.date ('!%M', time) == '00', 'os.date() did not return expected value when passed "!%M" [503]')
	assertTrue (os.date ('!%p', time) == 'AM', 'os.date() did not return expected value when passed "!%p" [504]')
	assertTrue (os.date ('!%S', time) == '00', 'os.date() did not return expected value when passed "!%S" [505]')
	assertTrue (os.date ('!%U', time) == '09', 'os.date() did not return expected value when passed "!%U" [506]')
	assertTrue (os.date ('!%w', time) == '1', 'os.date() did not return expected value when passed "!%w" [507]')
	assertTrue (os.date ('!%W', time) == '09', 'os.date() did not return expected value when passed "!%W" [508]')
	assertTrue (os.date ('!%x', time) == '02/28/00', 'os.date() did not return expected value when passed "!%x" [509]')
	assertTrue (os.date ('!%X', time) == '02:00:00', 'os.date() did not return expected value when passed "!%X" [510]')
	assertTrue (os.date ('!%y', time) == '00', 'os.date() did not return expected value when passed "!%y" [511]')
	assertTrue (os.date ('!%Y', time) == '2000', 'os.date() did not return expected value when passed "!%Y" [512]')
	assertTrue (os.date ('!%Z', time) == 'UTC', 'os.date() did not return expected value when passed "!%Z" [513]')
	assertTrue (os.date ('*t', time).hour == 2, 'os.date() did not return expected value when passed "*t" [514]')
	assertTrue (os.date ('*t', time).min == 0, 'os.date() did not return expected value when passed "*t" [515]')
	assertTrue (os.date ('*t', time).wday == 2, 'os.date() did not return expected value when passed "*t" [516]')
	assertTrue (os.date ('*t', time).day == 28, 'os.date() did not return expected value when passed "*t" [517]')
	assertTrue (os.date ('*t', time).month == 2, 'os.date() did not return expected value when passed "*t" [518]')
	assertTrue (os.date ('*t', time).year == 2000, 'os.date() did not return expected value when passed "*t" [519]')
	assertTrue (os.date ('*t', time).sec == 0, 'os.date() did not return expected value when passed "*t" [520]')
	assertTrue (os.date ('*t', time).yday == 59, 'os.date() did not return expected value when passed "*t" [521]')
	assertTrue (os.date ('*t', time).isdst == false, 'os.date() did not return expected value when passed "*t" [522]')
	assertTrue (os.date ('!*t', time).hour == 2, 'os.date() did not return expected value when passed "!*t" [523]')
	assertTrue (os.date ('!*t', time).min == 0, 'os.date() did not return expected value when passed "!*t" [524]')
	assertTrue (os.date ('!*t', time).wday == 2, 'os.date() did not return expected value when passed "!*t" [525]')
	assertTrue (os.date ('!*t', time).day == 28, 'os.date() did not return expected value when passed "!*t" [526]')
	assertTrue (os.date ('!*t', time).month == 2, 'os.date() did not return expected value when passed "!*t" [527]')
	assertTrue (os.date ('!*t', time).year == 2000, 'os.date() did not return expected value when passed "!*t" [528]')
	assertTrue (os.date ('!*t', time).sec == 0, 'os.date() did not return expected value when passed "!*t" [529]')
	assertTrue (os.date ('!*t', time).yday == 59, 'os.date() did not return expected value when passed "!*t" [530]')
	assertTrue (os.date ('!*t', time).isdst == false, 'os.date() did not return expected value when passed "!*t" [531]')

	local time = 951789600

	assertTrue (os.date ('%a', time) == 'Tue', 'os.date() did not return expected value when passed "%a" [532]')
	assertTrue (os.date ('%A', time) == 'Tuesday', 'os.date() did not return expected value when passed "%A" [533]')
	assertTrue (os.date ('%b', time) == 'Feb', 'os.date() did not return expected value when passed "%b" [534]')
	assertTrue (os.date ('%B', time) == 'February', 'os.date() did not return expected value when passed "%B" [535]')
	assertTrue (os.date ('%d', time) == '29', 'os.date() did not return expected value when passed "%d" [536]')
	assertTrue (os.date ('%H', time) == '02', 'os.date() did not return expected value when passed "%H" [537]')
	assertTrue (os.date ('%I', time) == '02', 'os.date() did not return expected value when passed "%I" [538]')
	assertTrue (os.date ('%j', time) == '060', 'os.date() did not return expected value when passed "%j" [539]')
	assertTrue (os.date ('%m', time) == '02', 'os.date() did not return expected value when passed "%m" [540]')
	assertTrue (os.date ('%M', time) == '00', 'os.date() did not return expected value when passed "%M" [541]')
	assertTrue (os.date ('%p', time) == 'AM', 'os.date() did not return expected value when passed "%p" [542]')
	assertTrue (os.date ('%S', time) == '00', 'os.date() did not return expected value when passed "%S" [543]')
	assertTrue (os.date ('%U', time) == '09', 'os.date() did not return expected value when passed "%U" [544]')
	assertTrue (os.date ('%w', time) == '2', 'os.date() did not return expected value when passed "%w" [545]')
	assertTrue (os.date ('%W', time) == '09', 'os.date() did not return expected value when passed "%W" [546]')
	assertTrue (os.date ('%x', time) == '02/29/00', 'os.date() did not return expected value when passed "%x" [547]')
	assertTrue (os.date ('%X', time) == '02:00:00', 'os.date() did not return expected value when passed "%X" [548]')
	assertTrue (os.date ('%y', time) == '00', 'os.date() did not return expected value when passed "%y" [549]')
	assertTrue (os.date ('%Y', time) == '2000', 'os.date() did not return expected value when passed "%Y" [550]')
	assertTrue (os.date ('%Z', time) == 'GMT', 'os.date() did not return expected value when passed "%Z" [551]')
	assertTrue (os.date ('%%', time) == '%', 'os.date() did not return expected value when passed "%%" [552]')
	assertTrue (os.date ('!%a', time) == 'Tue', 'os.date() did not return expected value when passed "!%a" [553]')
	assertTrue (os.date ('!%A', time) == 'Tuesday', 'os.date() did not return expected value when passed "!%A" [554]')
	assertTrue (os.date ('!%b', time) == 'Feb', 'os.date() did not return expected value when passed "!%b" [555]')
	assertTrue (os.date ('!%B', time) == 'February', 'os.date() did not return expected value when passed "!%B" [556]')
	assertTrue (os.date ('!%d', time) == '29', 'os.date() did not return expected value when passed "!%d" [557]')
	assertTrue (os.date ('!%H', time) == '02', 'os.date() did not return expected value when passed "!%H" [558]')
	assertTrue (os.date ('!%I', time) == '02', 'os.date() did not return expected value when passed "!%I" [559]')
	assertTrue (os.date ('!%j', time) == '060', 'os.date() did not return expected value when passed "!%j" [560]')
	assertTrue (os.date ('!%m', time) == '02', 'os.date() did not return expected value when passed "!%m" [561]')
	assertTrue (os.date ('!%M', time) == '00', 'os.date() did not return expected value when passed "!%M" [562]')
	assertTrue (os.date ('!%p', time) == 'AM', 'os.date() did not return expected value when passed "!%p" [563]')
	assertTrue (os.date ('!%S', time) == '00', 'os.date() did not return expected value when passed "!%S" [564]')
	assertTrue (os.date ('!%U', time) == '09', 'os.date() did not return expected value when passed "!%U" [565]')
	assertTrue (os.date ('!%w', time) == '2', 'os.date() did not return expected value when passed "!%w" [566]')
	assertTrue (os.date ('!%W', time) == '09', 'os.date() did not return expected value when passed "!%W" [567]')
	assertTrue (os.date ('!%x', time) == '02/29/00', 'os.date() did not return expected value when passed "!%x" [568]')
	assertTrue (os.date ('!%X', time) == '02:00:00', 'os.date() did not return expected value when passed "!%X" [569]')
	assertTrue (os.date ('!%y', time) == '00', 'os.date() did not return expected value when passed "!%y" [570]')
	assertTrue (os.date ('!%Y', time) == '2000', 'os.date() did not return expected value when passed "!%Y" [571]')
	assertTrue (os.date ('!%Z', time) == 'UTC', 'os.date() did not return expected value when passed "!%Z" [572]')
	assertTrue (os.date ('*t', time).hour == 2, 'os.date() did not return expected value when passed "*t" [573]')
	assertTrue (os.date ('*t', time).min == 0, 'os.date() did not return expected value when passed "*t" [574]')
	assertTrue (os.date ('*t', time).wday == 3, 'os.date() did not return expected value when passed "*t" [575]')
	assertTrue (os.date ('*t', time).day == 29, 'os.date() did not return expected value when passed "*t" [576]')
	assertTrue (os.date ('*t', time).month == 2, 'os.date() did not return expected value when passed "*t" [577]')
	assertTrue (os.date ('*t', time).year == 2000, 'os.date() did not return expected value when passed "*t" [578]')
	assertTrue (os.date ('*t', time).sec == 0, 'os.date() did not return expected value when passed "*t" [579]')
	assertTrue (os.date ('*t', time).yday == 60, 'os.date() did not return expected value when passed "*t" [580]')
	assertTrue (os.date ('*t', time).isdst == false, 'os.date() did not return expected value when passed "*t" [581]')
	assertTrue (os.date ('!*t', time).hour == 2, 'os.date() did not return expected value when passed "!*t" [582]')
	assertTrue (os.date ('!*t', time).min == 0, 'os.date() did not return expected value when passed "!*t" [583]')
	assertTrue (os.date ('!*t', time).wday == 3, 'os.date() did not return expected value when passed "!*t" [584]')
	assertTrue (os.date ('!*t', time).day == 29, 'os.date() did not return expected value when passed "!*t" [585]')
	assertTrue (os.date ('!*t', time).month == 2, 'os.date() did not return expected value when passed "!*t" [586]')
	assertTrue (os.date ('!*t', time).year == 2000, 'os.date() did not return expected value when passed "!*t" [587]')
	assertTrue (os.date ('!*t', time).sec == 0, 'os.date() did not return expected value when passed "!*t" [588]')
	assertTrue (os.date ('!*t', time).yday == 60, 'os.date() did not return expected value when passed "!*t" [589]')
	assertTrue (os.date ('!*t', time).isdst == false, 'os.date() did not return expected value when passed "!*t" [590]')

	local time = 951879600

	assertTrue (os.date ('%a', time) == 'Wed', 'os.date() did not return expected value when passed "%a" [591]')
	assertTrue (os.date ('%A', time) == 'Wednesday', 'os.date() did not return expected value when passed "%A" [592]')
	assertTrue (os.date ('%b', time) == 'Mar', 'os.date() did not return expected value when passed "%b" [593]')
	assertTrue (os.date ('%B', time) == 'March', 'os.date() did not return expected value when passed "%B" [594]')
	assertTrue (os.date ('%d', time) == '01', 'os.date() did not return expected value when passed "%d" [595]')
	assertTrue (os.date ('%H', time) == '03', 'os.date() did not return expected value when passed "%H" [596]')
	assertTrue (os.date ('%I', time) == '03', 'os.date() did not return expected value when passed "%I" [597]')
	assertTrue (os.date ('%j', time) == '061', 'os.date() did not return expected value when passed "%j" [598]')
	assertTrue (os.date ('%m', time) == '03', 'os.date() did not return expected value when passed "%m" [599]')
	assertTrue (os.date ('%M', time) == '00', 'os.date() did not return expected value when passed "%M" [600]')
	assertTrue (os.date ('%p', time) == 'AM', 'os.date() did not return expected value when passed "%p" [601]')
	assertTrue (os.date ('%S', time) == '00', 'os.date() did not return expected value when passed "%S" [602]')
	assertTrue (os.date ('%U', time) == '09', 'os.date() did not return expected value when passed "%U" [603]')
	assertTrue (os.date ('%w', time) == '3', 'os.date() did not return expected value when passed "%w" [604]')
	assertTrue (os.date ('%W', time) == '09', 'os.date() did not return expected value when passed "%W" [605]')
	assertTrue (os.date ('%x', time) == '03/01/00', 'os.date() did not return expected value when passed "%x" [606]')
	assertTrue (os.date ('%X', time) == '03:00:00', 'os.date() did not return expected value when passed "%X" [607]')
	assertTrue (os.date ('%y', time) == '00', 'os.date() did not return expected value when passed "%y" [608]')
	assertTrue (os.date ('%Y', time) == '2000', 'os.date() did not return expected value when passed "%Y" [609]')
	assertTrue (os.date ('%Z', time) == 'GMT', 'os.date() did not return expected value when passed "%Z" [610]')
	assertTrue (os.date ('%%', time) == '%', 'os.date() did not return expected value when passed "%%" [611]')
	assertTrue (os.date ('!%a', time) == 'Wed', 'os.date() did not return expected value when passed "!%a" [612]')
	assertTrue (os.date ('!%A', time) == 'Wednesday', 'os.date() did not return expected value when passed "!%A" [613]')
	assertTrue (os.date ('!%b', time) == 'Mar', 'os.date() did not return expected value when passed "!%b" [614]')
	assertTrue (os.date ('!%B', time) == 'March', 'os.date() did not return expected value when passed "!%B" [615]')
	assertTrue (os.date ('!%d', time) == '01', 'os.date() did not return expected value when passed "!%d" [616]')
	assertTrue (os.date ('!%H', time) == '03', 'os.date() did not return expected value when passed "!%H" [617]')
	assertTrue (os.date ('!%I', time) == '03', 'os.date() did not return expected value when passed "!%I" [618]')
	assertTrue (os.date ('!%j', time) == '061', 'os.date() did not return expected value when passed "!%j" [619]')
	assertTrue (os.date ('!%m', time) == '03', 'os.date() did not return expected value when passed "!%m" [620]')
	assertTrue (os.date ('!%M', time) == '00', 'os.date() did not return expected value when passed "!%M" [621]')
	assertTrue (os.date ('!%p', time) == 'AM', 'os.date() did not return expected value when passed "!%p" [622]')
	assertTrue (os.date ('!%S', time) == '00', 'os.date() did not return expected value when passed "!%S" [623]')
	assertTrue (os.date ('!%U', time) == '09', 'os.date() did not return expected value when passed "!%U" [624]')
	assertTrue (os.date ('!%w', time) == '3', 'os.date() did not return expected value when passed "!%w" [625]')
	assertTrue (os.date ('!%W', time) == '09', 'os.date() did not return expected value when passed "!%W" [626]')
	assertTrue (os.date ('!%x', time) == '03/01/00', 'os.date() did not return expected value when passed "!%x" [627]')
	assertTrue (os.date ('!%X', time) == '03:00:00', 'os.date() did not return expected value when passed "!%X" [628]')
	assertTrue (os.date ('!%y', time) == '00', 'os.date() did not return expected value when passed "!%y" [629]')
	assertTrue (os.date ('!%Y', time) == '2000', 'os.date() did not return expected value when passed "!%Y" [630]')
	assertTrue (os.date ('!%Z', time) == 'UTC', 'os.date() did not return expected value when passed "!%Z" [631]')
	assertTrue (os.date ('*t', time).hour == 3, 'os.date() did not return expected value when passed "*t" [632]')
	assertTrue (os.date ('*t', time).min == 0, 'os.date() did not return expected value when passed "*t" [633]')
	assertTrue (os.date ('*t', time).wday == 4, 'os.date() did not return expected value when passed "*t" [634]')
	assertTrue (os.date ('*t', time).day == 1, 'os.date() did not return expected value when passed "*t" [635]')
	assertTrue (os.date ('*t', time).month == 3, 'os.date() did not return expected value when passed "*t" [636]')
	assertTrue (os.date ('*t', time).year == 2000, 'os.date() did not return expected value when passed "*t" [637]')
	assertTrue (os.date ('*t', time).sec == 0, 'os.date() did not return expected value when passed "*t" [638]')
	assertTrue (os.date ('*t', time).yday == 61, 'os.date() did not return expected value when passed "*t" [639]')
	assertTrue (os.date ('*t', time).isdst == false, 'os.date() did not return expected value when passed "*t" [640]')
	assertTrue (os.date ('!*t', time).hour == 3, 'os.date() did not return expected value when passed "!*t" [641]')
	assertTrue (os.date ('!*t', time).min == 0, 'os.date() did not return expected value when passed "!*t" [642]')
	assertTrue (os.date ('!*t', time).wday == 4, 'os.date() did not return expected value when passed "!*t" [643]')
	assertTrue (os.date ('!*t', time).day == 1, 'os.date() did not return expected value when passed "!*t" [644]')
	assertTrue (os.date ('!*t', time).month == 3, 'os.date() did not return expected value when passed "!*t" [645]')
	assertTrue (os.date ('!*t', time).year == 2000, 'os.date() did not return expected value when passed "!*t" [646]')
	assertTrue (os.date ('!*t', time).sec == 0, 'os.date() did not return expected value when passed "!*t" [647]')
	assertTrue (os.date ('!*t', time).yday == 61, 'os.date() did not return expected value when passed "!*t" [648]')
	assertTrue (os.date ('!*t', time).isdst == false, 'os.date() did not return expected value when passed "!*t" [649]')

	local time = 978264000

	assertTrue (os.date ('%a', time) == 'Sun', 'os.date() did not return expected value when passed "%a" [650]')
	assertTrue (os.date ('%A', time) == 'Sunday', 'os.date() did not return expected value when passed "%A" [651]')
	assertTrue (os.date ('%b', time) == 'Dec', 'os.date() did not return expected value when passed "%b" [652]')
	assertTrue (os.date ('%B', time) == 'December', 'os.date() did not return expected value when passed "%B" [653]')
	assertTrue (os.date ('%d', time) == '31', 'os.date() did not return expected value when passed "%d" [654]')
	assertTrue (os.date ('%H', time) == '12', 'os.date() did not return expected value when passed "%H" [655]')
	assertTrue (os.date ('%I', time) == '12', 'os.date() did not return expected value when passed "%I" [656]')
	assertTrue (os.date ('%j', time) == '366', 'os.date() did not return expected value when passed "%j" [657]')
	assertTrue (os.date ('%m', time) == '12', 'os.date() did not return expected value when passed "%m" [658]')
	assertTrue (os.date ('%M', time) == '00', 'os.date() did not return expected value when passed "%M" [659]')
	assertTrue (os.date ('%p', time) == 'PM', 'os.date() did not return expected value when passed "%p" [660]')
	assertTrue (os.date ('%S', time) == '00', 'os.date() did not return expected value when passed "%S" [661]')
	assertTrue (os.date ('%U', time) == '53', 'os.date() did not return expected value when passed "%U" [662]')
	assertTrue (os.date ('%w', time) == '0', 'os.date() did not return expected value when passed "%w" [663]')
	assertTrue (os.date ('%W', time) == '52', 'os.date() did not return expected value when passed "%W" [664]')
	assertTrue (os.date ('%x', time) == '12/31/00', 'os.date() did not return expected value when passed "%x" [665]')
	assertTrue (os.date ('%X', time) == '12:00:00', 'os.date() did not return expected value when passed "%X" [666]')
	assertTrue (os.date ('%y', time) == '00', 'os.date() did not return expected value when passed "%y" [667]')
	assertTrue (os.date ('%Y', time) == '2000', 'os.date() did not return expected value when passed "%Y" [668]')
	assertTrue (os.date ('%Z', time) == 'GMT', 'os.date() did not return expected value when passed "%Z" [669]')
	assertTrue (os.date ('%%', time) == '%', 'os.date() did not return expected value when passed "%%" [670]')
	assertTrue (os.date ('!%a', time) == 'Sun', 'os.date() did not return expected value when passed "!%a" [671]')
	assertTrue (os.date ('!%A', time) == 'Sunday', 'os.date() did not return expected value when passed "!%A" [672]')
	assertTrue (os.date ('!%b', time) == 'Dec', 'os.date() did not return expected value when passed "!%b" [673]')
	assertTrue (os.date ('!%B', time) == 'December', 'os.date() did not return expected value when passed "!%B" [674]')
	assertTrue (os.date ('!%d', time) == '31', 'os.date() did not return expected value when passed "!%d" [675]')
	assertTrue (os.date ('!%H', time) == '12', 'os.date() did not return expected value when passed "!%H" [676]')
	assertTrue (os.date ('!%I', time) == '12', 'os.date() did not return expected value when passed "!%I" [677]')
	assertTrue (os.date ('!%j', time) == '366', 'os.date() did not return expected value when passed "!%j" [678]')
	assertTrue (os.date ('!%m', time) == '12', 'os.date() did not return expected value when passed "!%m" [679]')
	assertTrue (os.date ('!%M', time) == '00', 'os.date() did not return expected value when passed "!%M" [680]')
	assertTrue (os.date ('!%p', time) == 'PM', 'os.date() did not return expected value when passed "!%p" [681]')
	assertTrue (os.date ('!%S', time) == '00', 'os.date() did not return expected value when passed "!%S" [682]')
	assertTrue (os.date ('!%U', time) == '53', 'os.date() did not return expected value when passed "!%U" [683]')
	assertTrue (os.date ('!%w', time) == '0', 'os.date() did not return expected value when passed "!%w" [684]')
	assertTrue (os.date ('!%W', time) == '52', 'os.date() did not return expected value when passed "!%W" [685]')
	assertTrue (os.date ('!%x', time) == '12/31/00', 'os.date() did not return expected value when passed "!%x" [686]')
	assertTrue (os.date ('!%X', time) == '12:00:00', 'os.date() did not return expected value when passed "!%X" [687]')
	assertTrue (os.date ('!%y', time) == '00', 'os.date() did not return expected value when passed "!%y" [688]')
	assertTrue (os.date ('!%Y', time) == '2000', 'os.date() did not return expected value when passed "!%Y" [689]')
	assertTrue (os.date ('!%Z', time) == 'UTC', 'os.date() did not return expected value when passed "!%Z" [690]')
	assertTrue (os.date ('*t', time).hour == 12, 'os.date() did not return expected value when passed "*t" [691]')
	assertTrue (os.date ('*t', time).min == 0, 'os.date() did not return expected value when passed "*t" [692]')
	assertTrue (os.date ('*t', time).wday == 1, 'os.date() did not return expected value when passed "*t" [693]')
	assertTrue (os.date ('*t', time).day == 31, 'os.date() did not return expected value when passed "*t" [694]')
	assertTrue (os.date ('*t', time).month == 12, 'os.date() did not return expected value when passed "*t" [695]')
	assertTrue (os.date ('*t', time).year == 2000, 'os.date() did not return expected value when passed "*t" [696]')
	assertTrue (os.date ('*t', time).sec == 0, 'os.date() did not return expected value when passed "*t" [697]')
	assertTrue (os.date ('*t', time).yday == 366, 'os.date() did not return expected value when passed "*t" [698]')
	assertTrue (os.date ('*t', time).isdst == false, 'os.date() did not return expected value when passed "*t" [699]')
	assertTrue (os.date ('!*t', time).hour == 12, 'os.date() did not return expected value when passed "!*t" [700]')
	assertTrue (os.date ('!*t', time).min == 0, 'os.date() did not return expected value when passed "!*t" [701]')
	assertTrue (os.date ('!*t', time).wday == 1, 'os.date() did not return expected value when passed "!*t" [702]')
	assertTrue (os.date ('!*t', time).day == 31, 'os.date() did not return expected value when passed "!*t" [703]')
	assertTrue (os.date ('!*t', time).month == 12, 'os.date() did not return expected value when passed "!*t" [704]')
	assertTrue (os.date ('!*t', time).year == 2000, 'os.date() did not return expected value when passed "!*t" [705]')
	assertTrue (os.date ('!*t', time).sec == 0, 'os.date() did not return expected value when passed "!*t" [706]')
	assertTrue (os.date ('!*t', time).yday == 366, 'os.date() did not return expected value when passed "!*t" [707]')
	assertTrue (os.date ('!*t', time).isdst == false, 'os.date() did not return expected value when passed "!*t" [708]')

	local time = 1293843600

	assertTrue (os.date ('%a', time) == 'Sat', 'os.date() did not return expected value when passed "%a" [709]')
	assertTrue (os.date ('%A', time) == 'Saturday', 'os.date() did not return expected value when passed "%A" [710]')
	assertTrue (os.date ('%b', time) == 'Jan', 'os.date() did not return expected value when passed "%b" [711]')
	assertTrue (os.date ('%B', time) == 'January', 'os.date() did not return expected value when passed "%B" [712]')
	assertTrue (os.date ('%d', time) == '01', 'os.date() did not return expected value when passed "%d" [713]')
	assertTrue (os.date ('%H', time) == '01', 'os.date() did not return expected value when passed "%H" [714]')
	assertTrue (os.date ('%I', time) == '01', 'os.date() did not return expected value when passed "%I" [715]')
	assertTrue (os.date ('%j', time) == '001', 'os.date() did not return expected value when passed "%j" [716]')
	assertTrue (os.date ('%m', time) == '01', 'os.date() did not return expected value when passed "%m" [717]')
	assertTrue (os.date ('%M', time) == '00', 'os.date() did not return expected value when passed "%M" [718]')
	assertTrue (os.date ('%p', time) == 'AM', 'os.date() did not return expected value when passed "%p" [719]')
	assertTrue (os.date ('%S', time) == '00', 'os.date() did not return expected value when passed "%S" [720]')
	assertTrue (os.date ('%U', time) == '00', 'os.date() did not return expected value when passed "%U" [721]')
	assertTrue (os.date ('%w', time) == '6', 'os.date() did not return expected value when passed "%w" [722]')
	assertTrue (os.date ('%W', time) == '00', 'os.date() did not return expected value when passed "%W" [723]')
	assertTrue (os.date ('%x', time) == '01/01/11', 'os.date() did not return expected value when passed "%x" [724]')
	assertTrue (os.date ('%X', time) == '01:00:00', 'os.date() did not return expected value when passed "%X" [725]')
	assertTrue (os.date ('%y', time) == '11', 'os.date() did not return expected value when passed "%y" [726]')
	assertTrue (os.date ('%Y', time) == '2011', 'os.date() did not return expected value when passed "%Y" [727]')
	assertTrue (os.date ('%Z', time) == 'GMT', 'os.date() did not return expected value when passed "%Z" [728]')
	assertTrue (os.date ('%%', time) == '%', 'os.date() did not return expected value when passed "%%" [729]')
	assertTrue (os.date ('!%a', time) == 'Sat', 'os.date() did not return expected value when passed "!%a" [730]')
	assertTrue (os.date ('!%A', time) == 'Saturday', 'os.date() did not return expected value when passed "!%A" [731]')
	assertTrue (os.date ('!%b', time) == 'Jan', 'os.date() did not return expected value when passed "!%b" [732]')
	assertTrue (os.date ('!%B', time) == 'January', 'os.date() did not return expected value when passed "!%B" [733]')
	assertTrue (os.date ('!%d', time) == '01', 'os.date() did not return expected value when passed "!%d" [734]')
	assertTrue (os.date ('!%H', time) == '01', 'os.date() did not return expected value when passed "!%H" [735]')
	assertTrue (os.date ('!%I', time) == '01', 'os.date() did not return expected value when passed "!%I" [736]')
	assertTrue (os.date ('!%j', time) == '001', 'os.date() did not return expected value when passed "!%j" [737]')
	assertTrue (os.date ('!%m', time) == '01', 'os.date() did not return expected value when passed "!%m" [738]')
	assertTrue (os.date ('!%M', time) == '00', 'os.date() did not return expected value when passed "!%M" [739]')
	assertTrue (os.date ('!%p', time) == 'AM', 'os.date() did not return expected value when passed "!%p" [740]')
	assertTrue (os.date ('!%S', time) == '00', 'os.date() did not return expected value when passed "!%S" [741]')
	assertTrue (os.date ('!%U', time) == '00', 'os.date() did not return expected value when passed "!%U" [742]')
	assertTrue (os.date ('!%w', time) == '6', 'os.date() did not return expected value when passed "!%w" [743]')
	assertTrue (os.date ('!%W', time) == '00', 'os.date() did not return expected value when passed "!%W" [744]')
	assertTrue (os.date ('!%x', time) == '01/01/11', 'os.date() did not return expected value when passed "!%x" [745]')
	assertTrue (os.date ('!%X', time) == '01:00:00', 'os.date() did not return expected value when passed "!%X" [746]')
	assertTrue (os.date ('!%y', time) == '11', 'os.date() did not return expected value when passed "!%y" [747]')
	assertTrue (os.date ('!%Y', time) == '2011', 'os.date() did not return expected value when passed "!%Y" [748]')
	assertTrue (os.date ('!%Z', time) == 'UTC', 'os.date() did not return expected value when passed "!%Z" [749]')
	assertTrue (os.date ('*t', time).hour == 1, 'os.date() did not return expected value when passed "*t" [750]')
	assertTrue (os.date ('*t', time).min == 0, 'os.date() did not return expected value when passed "*t" [751]')
	assertTrue (os.date ('*t', time).wday == 7, 'os.date() did not return expected value when passed "*t" [752]')
	assertTrue (os.date ('*t', time).day == 1, 'os.date() did not return expected value when passed "*t" [753]')
	assertTrue (os.date ('*t', time).month == 1, 'os.date() did not return expected value when passed "*t" [754]')
	assertTrue (os.date ('*t', time).year == 2011, 'os.date() did not return expected value when passed "*t" [755]')
	assertTrue (os.date ('*t', time).sec == 0, 'os.date() did not return expected value when passed "*t" [756]')
	assertTrue (os.date ('*t', time).yday == 1, 'os.date() did not return expected value when passed "*t" [757]')
	assertTrue (os.date ('*t', time).isdst == false, 'os.date() did not return expected value when passed "*t" [758]')
	assertTrue (os.date ('!*t', time).hour == 1, 'os.date() did not return expected value when passed "!*t" [759]')
	assertTrue (os.date ('!*t', time).min == 0, 'os.date() did not return expected value when passed "!*t" [760]')
	assertTrue (os.date ('!*t', time).wday == 7, 'os.date() did not return expected value when passed "!*t" [761]')
	assertTrue (os.date ('!*t', time).day == 1, 'os.date() did not return expected value when passed "!*t" [762]')
	assertTrue (os.date ('!*t', time).month == 1, 'os.date() did not return expected value when passed "!*t" [763]')
	assertTrue (os.date ('!*t', time).year == 2011, 'os.date() did not return expected value when passed "!*t" [764]')
	assertTrue (os.date ('!*t', time).sec == 0, 'os.date() did not return expected value when passed "!*t" [765]')
	assertTrue (os.date ('!*t', time).yday == 1, 'os.date() did not return expected value when passed "!*t" [766]')
	assertTrue (os.date ('!*t', time).isdst == false, 'os.date() did not return expected value when passed "!*t" [767]')

	local time = 1296525600

	assertTrue (os.date ('%a', time) == 'Tue', 'os.date() did not return expected value when passed "%a" [768]')
	assertTrue (os.date ('%A', time) == 'Tuesday', 'os.date() did not return expected value when passed "%A" [769]')
	assertTrue (os.date ('%b', time) == 'Feb', 'os.date() did not return expected value when passed "%b" [770]')
	assertTrue (os.date ('%B', time) == 'February', 'os.date() did not return expected value when passed "%B" [771]')
	assertTrue (os.date ('%d', time) == '01', 'os.date() did not return expected value when passed "%d" [772]')
	assertTrue (os.date ('%H', time) == '02', 'os.date() did not return expected value when passed "%H" [773]')
	assertTrue (os.date ('%I', time) == '02', 'os.date() did not return expected value when passed "%I" [774]')
	assertTrue (os.date ('%j', time) == '032', 'os.date() did not return expected value when passed "%j" [775]')
	assertTrue (os.date ('%m', time) == '02', 'os.date() did not return expected value when passed "%m" [776]')
	assertTrue (os.date ('%M', time) == '00', 'os.date() did not return expected value when passed "%M" [777]')
	assertTrue (os.date ('%p', time) == 'AM', 'os.date() did not return expected value when passed "%p" [778]')
	assertTrue (os.date ('%S', time) == '00', 'os.date() did not return expected value when passed "%S" [779]')
	assertTrue (os.date ('%U', time) == '05', 'os.date() did not return expected value when passed "%U" [780]')
	assertTrue (os.date ('%w', time) == '2', 'os.date() did not return expected value when passed "%w" [781]')
	assertTrue (os.date ('%W', time) == '05', 'os.date() did not return expected value when passed "%W" [782]')
	assertTrue (os.date ('%x', time) == '02/01/11', 'os.date() did not return expected value when passed "%x" [783]')
	assertTrue (os.date ('%X', time) == '02:00:00', 'os.date() did not return expected value when passed "%X" [784]')
	assertTrue (os.date ('%y', time) == '11', 'os.date() did not return expected value when passed "%y" [785]')
	assertTrue (os.date ('%Y', time) == '2011', 'os.date() did not return expected value when passed "%Y" [786]')
	assertTrue (os.date ('%Z', time) == 'GMT', 'os.date() did not return expected value when passed "%Z" [787]')
	assertTrue (os.date ('%%', time) == '%', 'os.date() did not return expected value when passed "%%" [788]')
	assertTrue (os.date ('!%a', time) == 'Tue', 'os.date() did not return expected value when passed "!%a" [789]')
	assertTrue (os.date ('!%A', time) == 'Tuesday', 'os.date() did not return expected value when passed "!%A" [790]')
	assertTrue (os.date ('!%b', time) == 'Feb', 'os.date() did not return expected value when passed "!%b" [791]')
	assertTrue (os.date ('!%B', time) == 'February', 'os.date() did not return expected value when passed "!%B" [792]')
	assertTrue (os.date ('!%d', time) == '01', 'os.date() did not return expected value when passed "!%d" [793]')
	assertTrue (os.date ('!%H', time) == '02', 'os.date() did not return expected value when passed "!%H" [794]')
	assertTrue (os.date ('!%I', time) == '02', 'os.date() did not return expected value when passed "!%I" [795]')
	assertTrue (os.date ('!%j', time) == '032', 'os.date() did not return expected value when passed "!%j" [796]')
	assertTrue (os.date ('!%m', time) == '02', 'os.date() did not return expected value when passed "!%m" [797]')
	assertTrue (os.date ('!%M', time) == '00', 'os.date() did not return expected value when passed "!%M" [798]')
	assertTrue (os.date ('!%p', time) == 'AM', 'os.date() did not return expected value when passed "!%p" [799]')
	assertTrue (os.date ('!%S', time) == '00', 'os.date() did not return expected value when passed "!%S" [800]')
	assertTrue (os.date ('!%U', time) == '05', 'os.date() did not return expected value when passed "!%U" [801]')
	assertTrue (os.date ('!%w', time) == '2', 'os.date() did not return expected value when passed "!%w" [802]')
	assertTrue (os.date ('!%W', time) == '05', 'os.date() did not return expected value when passed "!%W" [803]')
	assertTrue (os.date ('!%x', time) == '02/01/11', 'os.date() did not return expected value when passed "!%x" [804]')
	assertTrue (os.date ('!%X', time) == '02:00:00', 'os.date() did not return expected value when passed "!%X" [805]')
	assertTrue (os.date ('!%y', time) == '11', 'os.date() did not return expected value when passed "!%y" [806]')
	assertTrue (os.date ('!%Y', time) == '2011', 'os.date() did not return expected value when passed "!%Y" [807]')
	assertTrue (os.date ('!%Z', time) == 'UTC', 'os.date() did not return expected value when passed "!%Z" [808]')
	assertTrue (os.date ('*t', time).hour == 2, 'os.date() did not return expected value when passed "*t" [809]')
	assertTrue (os.date ('*t', time).min == 0, 'os.date() did not return expected value when passed "*t" [810]')
	assertTrue (os.date ('*t', time).wday == 3, 'os.date() did not return expected value when passed "*t" [811]')
	assertTrue (os.date ('*t', time).day == 1, 'os.date() did not return expected value when passed "*t" [812]')
	assertTrue (os.date ('*t', time).month == 2, 'os.date() did not return expected value when passed "*t" [813]')
	assertTrue (os.date ('*t', time).year == 2011, 'os.date() did not return expected value when passed "*t" [814]')
	assertTrue (os.date ('*t', time).sec == 0, 'os.date() did not return expected value when passed "*t" [815]')
	assertTrue (os.date ('*t', time).yday == 32, 'os.date() did not return expected value when passed "*t" [816]')
	assertTrue (os.date ('*t', time).isdst == false, 'os.date() did not return expected value when passed "*t" [817]')
	assertTrue (os.date ('!*t', time).hour == 2, 'os.date() did not return expected value when passed "!*t" [818]')
	assertTrue (os.date ('!*t', time).min == 0, 'os.date() did not return expected value when passed "!*t" [819]')
	assertTrue (os.date ('!*t', time).wday == 3, 'os.date() did not return expected value when passed "!*t" [820]')
	assertTrue (os.date ('!*t', time).day == 1, 'os.date() did not return expected value when passed "!*t" [821]')
	assertTrue (os.date ('!*t', time).month == 2, 'os.date() did not return expected value when passed "!*t" [822]')
	assertTrue (os.date ('!*t', time).year == 2011, 'os.date() did not return expected value when passed "!*t" [823]')
	assertTrue (os.date ('!*t', time).sec == 0, 'os.date() did not return expected value when passed "!*t" [824]')
	assertTrue (os.date ('!*t', time).yday == 32, 'os.date() did not return expected value when passed "!*t" [825]')
	assertTrue (os.date ('!*t', time).isdst == false, 'os.date() did not return expected value when passed "!*t" [826]')

	local time = 1298858400

	assertTrue (os.date ('%a', time) == 'Mon', 'os.date() did not return expected value when passed "%a" [827]')
	assertTrue (os.date ('%A', time) == 'Monday', 'os.date() did not return expected value when passed "%A" [828]')
	assertTrue (os.date ('%b', time) == 'Feb', 'os.date() did not return expected value when passed "%b" [829]')
	assertTrue (os.date ('%B', time) == 'February', 'os.date() did not return expected value when passed "%B" [830]')
	assertTrue (os.date ('%d', time) == '28', 'os.date() did not return expected value when passed "%d" [831]')
	assertTrue (os.date ('%H', time) == '02', 'os.date() did not return expected value when passed "%H" [832]')
	assertTrue (os.date ('%I', time) == '02', 'os.date() did not return expected value when passed "%I" [833]')
	assertTrue (os.date ('%j', time) == '059', 'os.date() did not return expected value when passed "%j" [834]')
	assertTrue (os.date ('%m', time) == '02', 'os.date() did not return expected value when passed "%m" [835]')
	assertTrue (os.date ('%M', time) == '00', 'os.date() did not return expected value when passed "%M" [836]')
	assertTrue (os.date ('%p', time) == 'AM', 'os.date() did not return expected value when passed "%p" [837]')
	assertTrue (os.date ('%S', time) == '00', 'os.date() did not return expected value when passed "%S" [838]')
	assertTrue (os.date ('%U', time) == '09', 'os.date() did not return expected value when passed "%U" [839]')
	assertTrue (os.date ('%w', time) == '1', 'os.date() did not return expected value when passed "%w" [840]')
	assertTrue (os.date ('%W', time) == '09', 'os.date() did not return expected value when passed "%W" [841]')
	assertTrue (os.date ('%x', time) == '02/28/11', 'os.date() did not return expected value when passed "%x" [842]')
	assertTrue (os.date ('%X', time) == '02:00:00', 'os.date() did not return expected value when passed "%X" [843]')
	assertTrue (os.date ('%y', time) == '11', 'os.date() did not return expected value when passed "%y" [844]')
	assertTrue (os.date ('%Y', time) == '2011', 'os.date() did not return expected value when passed "%Y" [845]')
	assertTrue (os.date ('%Z', time) == 'GMT', 'os.date() did not return expected value when passed "%Z" [846]')
	assertTrue (os.date ('%%', time) == '%', 'os.date() did not return expected value when passed "%%" [847]')
	assertTrue (os.date ('!%a', time) == 'Mon', 'os.date() did not return expected value when passed "!%a" [848]')
	assertTrue (os.date ('!%A', time) == 'Monday', 'os.date() did not return expected value when passed "!%A" [849]')
	assertTrue (os.date ('!%b', time) == 'Feb', 'os.date() did not return expected value when passed "!%b" [850]')
	assertTrue (os.date ('!%B', time) == 'February', 'os.date() did not return expected value when passed "!%B" [851]')
	assertTrue (os.date ('!%d', time) == '28', 'os.date() did not return expected value when passed "!%d" [852]')
	assertTrue (os.date ('!%H', time) == '02', 'os.date() did not return expected value when passed "!%H" [853]')
	assertTrue (os.date ('!%I', time) == '02', 'os.date() did not return expected value when passed "!%I" [854]')
	assertTrue (os.date ('!%j', time) == '059', 'os.date() did not return expected value when passed "!%j" [855]')
	assertTrue (os.date ('!%m', time) == '02', 'os.date() did not return expected value when passed "!%m" [856]')
	assertTrue (os.date ('!%M', time) == '00', 'os.date() did not return expected value when passed "!%M" [857]')
	assertTrue (os.date ('!%p', time) == 'AM', 'os.date() did not return expected value when passed "!%p" [858]')
	assertTrue (os.date ('!%S', time) == '00', 'os.date() did not return expected value when passed "!%S" [859]')
	assertTrue (os.date ('!%U', time) == '09', 'os.date() did not return expected value when passed "!%U" [860]')
	assertTrue (os.date ('!%w', time) == '1', 'os.date() did not return expected value when passed "!%w" [861]')
	assertTrue (os.date ('!%W', time) == '09', 'os.date() did not return expected value when passed "!%W" [862]')
	assertTrue (os.date ('!%x', time) == '02/28/11', 'os.date() did not return expected value when passed "!%x" [863]')
	assertTrue (os.date ('!%X', time) == '02:00:00', 'os.date() did not return expected value when passed "!%X" [864]')
	assertTrue (os.date ('!%y', time) == '11', 'os.date() did not return expected value when passed "!%y" [865]')
	assertTrue (os.date ('!%Y', time) == '2011', 'os.date() did not return expected value when passed "!%Y" [866]')
	assertTrue (os.date ('!%Z', time) == 'UTC', 'os.date() did not return expected value when passed "!%Z" [867]')
	assertTrue (os.date ('*t', time).hour == 2, 'os.date() did not return expected value when passed "*t" [868]')
	assertTrue (os.date ('*t', time).min == 0, 'os.date() did not return expected value when passed "*t" [869]')
	assertTrue (os.date ('*t', time).wday == 2, 'os.date() did not return expected value when passed "*t" [870]')
	assertTrue (os.date ('*t', time).day == 28, 'os.date() did not return expected value when passed "*t" [871]')
	assertTrue (os.date ('*t', time).month == 2, 'os.date() did not return expected value when passed "*t" [872]')
	assertTrue (os.date ('*t', time).year == 2011, 'os.date() did not return expected value when passed "*t" [873]')
	assertTrue (os.date ('*t', time).sec == 0, 'os.date() did not return expected value when passed "*t" [874]')
	assertTrue (os.date ('*t', time).yday == 59, 'os.date() did not return expected value when passed "*t" [875]')
	assertTrue (os.date ('*t', time).isdst == false, 'os.date() did not return expected value when passed "*t" [876]')
	assertTrue (os.date ('!*t', time).hour == 2, 'os.date() did not return expected value when passed "!*t" [877]')
	assertTrue (os.date ('!*t', time).min == 0, 'os.date() did not return expected value when passed "!*t" [878]')
	assertTrue (os.date ('!*t', time).wday == 2, 'os.date() did not return expected value when passed "!*t" [879]')
	assertTrue (os.date ('!*t', time).day == 28, 'os.date() did not return expected value when passed "!*t" [880]')
	assertTrue (os.date ('!*t', time).month == 2, 'os.date() did not return expected value when passed "!*t" [881]')
	assertTrue (os.date ('!*t', time).year == 2011, 'os.date() did not return expected value when passed "!*t" [882]')
	assertTrue (os.date ('!*t', time).sec == 0, 'os.date() did not return expected value when passed "!*t" [883]')
	assertTrue (os.date ('!*t', time).yday == 59, 'os.date() did not return expected value when passed "!*t" [884]')
	assertTrue (os.date ('!*t', time).isdst == false, 'os.date() did not return expected value when passed "!*t" [885]')

	local time = 1298944800

	assertTrue (os.date ('%a', time) == 'Tue', 'os.date() did not return expected value when passed "%a" [886]')
	assertTrue (os.date ('%A', time) == 'Tuesday', 'os.date() did not return expected value when passed "%A" [887]')
	assertTrue (os.date ('%b', time) == 'Mar', 'os.date() did not return expected value when passed "%b" [888]')
	assertTrue (os.date ('%B', time) == 'March', 'os.date() did not return expected value when passed "%B" [889]')
	assertTrue (os.date ('%d', time) == '01', 'os.date() did not return expected value when passed "%d" [890]')
	assertTrue (os.date ('%H', time) == '02', 'os.date() did not return expected value when passed "%H" [891]')
	assertTrue (os.date ('%I', time) == '02', 'os.date() did not return expected value when passed "%I" [892]')
	assertTrue (os.date ('%j', time) == '060', 'os.date() did not return expected value when passed "%j" [893]')
	assertTrue (os.date ('%m', time) == '03', 'os.date() did not return expected value when passed "%m" [894]')
	assertTrue (os.date ('%M', time) == '00', 'os.date() did not return expected value when passed "%M" [895]')
	assertTrue (os.date ('%p', time) == 'AM', 'os.date() did not return expected value when passed "%p" [896]')
	assertTrue (os.date ('%S', time) == '00', 'os.date() did not return expected value when passed "%S" [897]')
	assertTrue (os.date ('%U', time) == '09', 'os.date() did not return expected value when passed "%U" [898]')
	assertTrue (os.date ('%w', time) == '2', 'os.date() did not return expected value when passed "%w" [899]')
	assertTrue (os.date ('%W', time) == '09', 'os.date() did not return expected value when passed "%W" [900]')
	assertTrue (os.date ('%x', time) == '03/01/11', 'os.date() did not return expected value when passed "%x" [901]')
	assertTrue (os.date ('%X', time) == '02:00:00', 'os.date() did not return expected value when passed "%X" [902]')
	assertTrue (os.date ('%y', time) == '11', 'os.date() did not return expected value when passed "%y" [903]')
	assertTrue (os.date ('%Y', time) == '2011', 'os.date() did not return expected value when passed "%Y" [904]')
	assertTrue (os.date ('%Z', time) == 'GMT', 'os.date() did not return expected value when passed "%Z" [905]')
	assertTrue (os.date ('%%', time) == '%', 'os.date() did not return expected value when passed "%%" [906]')
	assertTrue (os.date ('!%a', time) == 'Tue', 'os.date() did not return expected value when passed "!%a" [907]')
	assertTrue (os.date ('!%A', time) == 'Tuesday', 'os.date() did not return expected value when passed "!%A" [908]')
	assertTrue (os.date ('!%b', time) == 'Mar', 'os.date() did not return expected value when passed "!%b" [909]')
	assertTrue (os.date ('!%B', time) == 'March', 'os.date() did not return expected value when passed "!%B" [910]')
	assertTrue (os.date ('!%d', time) == '01', 'os.date() did not return expected value when passed "!%d" [911]')
	assertTrue (os.date ('!%H', time) == '02', 'os.date() did not return expected value when passed "!%H" [912]')
	assertTrue (os.date ('!%I', time) == '02', 'os.date() did not return expected value when passed "!%I" [913]')
	assertTrue (os.date ('!%j', time) == '060', 'os.date() did not return expected value when passed "!%j" [914]')
	assertTrue (os.date ('!%m', time) == '03', 'os.date() did not return expected value when passed "!%m" [915]')
	assertTrue (os.date ('!%M', time) == '00', 'os.date() did not return expected value when passed "!%M" [916]')
	assertTrue (os.date ('!%p', time) == 'AM', 'os.date() did not return expected value when passed "!%p" [917]')
	assertTrue (os.date ('!%S', time) == '00', 'os.date() did not return expected value when passed "!%S" [918]')
	assertTrue (os.date ('!%U', time) == '09', 'os.date() did not return expected value when passed "!%U" [919]')
	assertTrue (os.date ('!%w', time) == '2', 'os.date() did not return expected value when passed "!%w" [920]')
	assertTrue (os.date ('!%W', time) == '09', 'os.date() did not return expected value when passed "!%W" [921]')
	assertTrue (os.date ('!%x', time) == '03/01/11', 'os.date() did not return expected value when passed "!%x" [922]')
	assertTrue (os.date ('!%X', time) == '02:00:00', 'os.date() did not return expected value when passed "!%X" [923]')
	assertTrue (os.date ('!%y', time) == '11', 'os.date() did not return expected value when passed "!%y" [924]')
	assertTrue (os.date ('!%Y', time) == '2011', 'os.date() did not return expected value when passed "!%Y" [925]')
	assertTrue (os.date ('!%Z', time) == 'UTC', 'os.date() did not return expected value when passed "!%Z" [926]')
	assertTrue (os.date ('*t', time).hour == 2, 'os.date() did not return expected value when passed "*t" [927]')
	assertTrue (os.date ('*t', time).min == 0, 'os.date() did not return expected value when passed "*t" [928]')
	assertTrue (os.date ('*t', time).wday == 3, 'os.date() did not return expected value when passed "*t" [929]')
	assertTrue (os.date ('*t', time).day == 1, 'os.date() did not return expected value when passed "*t" [930]')
	assertTrue (os.date ('*t', time).month == 3, 'os.date() did not return expected value when passed "*t" [931]')
	assertTrue (os.date ('*t', time).year == 2011, 'os.date() did not return expected value when passed "*t" [932]')
	assertTrue (os.date ('*t', time).sec == 0, 'os.date() did not return expected value when passed "*t" [933]')
	assertTrue (os.date ('*t', time).yday == 60, 'os.date() did not return expected value when passed "*t" [934]')
	assertTrue (os.date ('*t', time).isdst == false, 'os.date() did not return expected value when passed "*t" [935]')
	assertTrue (os.date ('!*t', time).hour == 2, 'os.date() did not return expected value when passed "!*t" [936]')
	assertTrue (os.date ('!*t', time).min == 0, 'os.date() did not return expected value when passed "!*t" [937]')
	assertTrue (os.date ('!*t', time).wday == 3, 'os.date() did not return expected value when passed "!*t" [938]')
	assertTrue (os.date ('!*t', time).day == 1, 'os.date() did not return expected value when passed "!*t" [939]')
	assertTrue (os.date ('!*t', time).month == 3, 'os.date() did not return expected value when passed "!*t" [940]')
	assertTrue (os.date ('!*t', time).year == 2011, 'os.date() did not return expected value when passed "!*t" [941]')
	assertTrue (os.date ('!*t', time).sec == 0, 'os.date() did not return expected value when passed "!*t" [942]')
	assertTrue (os.date ('!*t', time).yday == 60, 'os.date() did not return expected value when passed "!*t" [943]')
	assertTrue (os.date ('!*t', time).isdst == false, 'os.date() did not return expected value when passed "!*t" [944]')

	local time = 1298948400

	assertTrue (os.date ('%a', time) == 'Tue', 'os.date() did not return expected value when passed "%a" [945]')
	assertTrue (os.date ('%A', time) == 'Tuesday', 'os.date() did not return expected value when passed "%A" [946]')
	assertTrue (os.date ('%b', time) == 'Mar', 'os.date() did not return expected value when passed "%b" [947]')
	assertTrue (os.date ('%B', time) == 'March', 'os.date() did not return expected value when passed "%B" [948]')
	assertTrue (os.date ('%d', time) == '01', 'os.date() did not return expected value when passed "%d" [949]')
	assertTrue (os.date ('%H', time) == '03', 'os.date() did not return expected value when passed "%H" [950]')
	assertTrue (os.date ('%I', time) == '03', 'os.date() did not return expected value when passed "%I" [951]')
	assertTrue (os.date ('%j', time) == '060', 'os.date() did not return expected value when passed "%j" [952]')
	assertTrue (os.date ('%m', time) == '03', 'os.date() did not return expected value when passed "%m" [953]')
	assertTrue (os.date ('%M', time) == '00', 'os.date() did not return expected value when passed "%M" [954]')
	assertTrue (os.date ('%p', time) == 'AM', 'os.date() did not return expected value when passed "%p" [955]')
	assertTrue (os.date ('%S', time) == '00', 'os.date() did not return expected value when passed "%S" [956]')
	assertTrue (os.date ('%U', time) == '09', 'os.date() did not return expected value when passed "%U" [957]')
	assertTrue (os.date ('%w', time) == '2', 'os.date() did not return expected value when passed "%w" [958]')
	assertTrue (os.date ('%W', time) == '09', 'os.date() did not return expected value when passed "%W" [959]')
	assertTrue (os.date ('%x', time) == '03/01/11', 'os.date() did not return expected value when passed "%x" [960]')
	assertTrue (os.date ('%X', time) == '03:00:00', 'os.date() did not return expected value when passed "%X" [961]')
	assertTrue (os.date ('%y', time) == '11', 'os.date() did not return expected value when passed "%y" [962]')
	assertTrue (os.date ('%Y', time) == '2011', 'os.date() did not return expected value when passed "%Y" [963]')
	assertTrue (os.date ('%Z', time) == 'GMT', 'os.date() did not return expected value when passed "%Z" [964]')
	assertTrue (os.date ('%%', time) == '%', 'os.date() did not return expected value when passed "%%" [965]')
	assertTrue (os.date ('!%a', time) == 'Tue', 'os.date() did not return expected value when passed "!%a" [966]')
	assertTrue (os.date ('!%A', time) == 'Tuesday', 'os.date() did not return expected value when passed "!%A" [967]')
	assertTrue (os.date ('!%b', time) == 'Mar', 'os.date() did not return expected value when passed "!%b" [968]')
	assertTrue (os.date ('!%B', time) == 'March', 'os.date() did not return expected value when passed "!%B" [969]')
	assertTrue (os.date ('!%d', time) == '01', 'os.date() did not return expected value when passed "!%d" [970]')
	assertTrue (os.date ('!%H', time) == '03', 'os.date() did not return expected value when passed "!%H" [971]')
	assertTrue (os.date ('!%I', time) == '03', 'os.date() did not return expected value when passed "!%I" [972]')
	assertTrue (os.date ('!%j', time) == '060', 'os.date() did not return expected value when passed "!%j" [973]')
	assertTrue (os.date ('!%m', time) == '03', 'os.date() did not return expected value when passed "!%m" [974]')
	assertTrue (os.date ('!%M', time) == '00', 'os.date() did not return expected value when passed "!%M" [975]')
	assertTrue (os.date ('!%p', time) == 'AM', 'os.date() did not return expected value when passed "!%p" [976]')
	assertTrue (os.date ('!%S', time) == '00', 'os.date() did not return expected value when passed "!%S" [977]')
	assertTrue (os.date ('!%U', time) == '09', 'os.date() did not return expected value when passed "!%U" [978]')
	assertTrue (os.date ('!%w', time) == '2', 'os.date() did not return expected value when passed "!%w" [979]')
	assertTrue (os.date ('!%W', time) == '09', 'os.date() did not return expected value when passed "!%W" [980]')
	assertTrue (os.date ('!%x', time) == '03/01/11', 'os.date() did not return expected value when passed "!%x" [981]')
	assertTrue (os.date ('!%X', time) == '03:00:00', 'os.date() did not return expected value when passed "!%X" [982]')
	assertTrue (os.date ('!%y', time) == '11', 'os.date() did not return expected value when passed "!%y" [983]')
	assertTrue (os.date ('!%Y', time) == '2011', 'os.date() did not return expected value when passed "!%Y" [984]')
	assertTrue (os.date ('!%Z', time) == 'UTC', 'os.date() did not return expected value when passed "!%Z" [985]')
	assertTrue (os.date ('*t', time).hour == 3, 'os.date() did not return expected value when passed "*t" [986]')
	assertTrue (os.date ('*t', time).min == 0, 'os.date() did not return expected value when passed "*t" [987]')
	assertTrue (os.date ('*t', time).wday == 3, 'os.date() did not return expected value when passed "*t" [988]')
	assertTrue (os.date ('*t', time).day == 1, 'os.date() did not return expected value when passed "*t" [989]')
	assertTrue (os.date ('*t', time).month == 3, 'os.date() did not return expected value when passed "*t" [990]')
	assertTrue (os.date ('*t', time).year == 2011, 'os.date() did not return expected value when passed "*t" [991]')
	assertTrue (os.date ('*t', time).sec == 0, 'os.date() did not return expected value when passed "*t" [992]')
	assertTrue (os.date ('*t', time).yday == 60, 'os.date() did not return expected value when passed "*t" [993]')
	assertTrue (os.date ('*t', time).isdst == false, 'os.date() did not return expected value when passed "*t" [994]')
	assertTrue (os.date ('!*t', time).hour == 3, 'os.date() did not return expected value when passed "!*t" [995]')
	assertTrue (os.date ('!*t', time).min == 0, 'os.date() did not return expected value when passed "!*t" [996]')
	assertTrue (os.date ('!*t', time).wday == 3, 'os.date() did not return expected value when passed "!*t" [997]')
	assertTrue (os.date ('!*t', time).day == 1, 'os.date() did not return expected value when passed "!*t" [998]')
	assertTrue (os.date ('!*t', time).month == 3, 'os.date() did not return expected value when passed "!*t" [999]')
	assertTrue (os.date ('!*t', time).year == 2011, 'os.date() did not return expected value when passed "!*t" [1000]')
	assertTrue (os.date ('!*t', time).sec == 0, 'os.date() did not return expected value when passed "!*t" [1001]')
	assertTrue (os.date ('!*t', time).yday == 60, 'os.date() did not return expected value when passed "!*t" [1002]')
	assertTrue (os.date ('!*t', time).isdst == false, 'os.date() did not return expected value when passed "!*t" [1003]')

	local time = 1325332800

	assertTrue (os.date ('%a', time) == 'Sat', 'os.date() did not return expected value when passed "%a" [1004]')
	assertTrue (os.date ('%A', time) == 'Saturday', 'os.date() did not return expected value when passed "%A" [1005]')
	assertTrue (os.date ('%b', time) == 'Dec', 'os.date() did not return expected value when passed "%b" [1006]')
	assertTrue (os.date ('%B', time) == 'December', 'os.date() did not return expected value when passed "%B" [1007]')
	assertTrue (os.date ('%d', time) == '31', 'os.date() did not return expected value when passed "%d" [1008]')
	assertTrue (os.date ('%H', time) == '12', 'os.date() did not return expected value when passed "%H" [1009]')
	assertTrue (os.date ('%I', time) == '12', 'os.date() did not return expected value when passed "%I" [1010]')
	assertTrue (os.date ('%j', time) == '365', 'os.date() did not return expected value when passed "%j" [1011]')
	assertTrue (os.date ('%m', time) == '12', 'os.date() did not return expected value when passed "%m" [1012]')
	assertTrue (os.date ('%M', time) == '00', 'os.date() did not return expected value when passed "%M" [1013]')
	assertTrue (os.date ('%p', time) == 'PM', 'os.date() did not return expected value when passed "%p" [1014]')
	assertTrue (os.date ('%S', time) == '00', 'os.date() did not return expected value when passed "%S" [1015]')
	assertTrue (os.date ('%U', time) == '52', 'os.date() did not return expected value when passed "%U" [1016]')
	assertTrue (os.date ('%w', time) == '6', 'os.date() did not return expected value when passed "%w" [1017]')
	assertTrue (os.date ('%W', time) == '52', 'os.date() did not return expected value when passed "%W" [1018]')
	assertTrue (os.date ('%x', time) == '12/31/11', 'os.date() did not return expected value when passed "%x" [1019]')
	assertTrue (os.date ('%X', time) == '12:00:00', 'os.date() did not return expected value when passed "%X" [1020]')
	assertTrue (os.date ('%y', time) == '11', 'os.date() did not return expected value when passed "%y" [1021]')
	assertTrue (os.date ('%Y', time) == '2011', 'os.date() did not return expected value when passed "%Y" [1022]')
	assertTrue (os.date ('%Z', time) == 'GMT', 'os.date() did not return expected value when passed "%Z" [1023]')
	assertTrue (os.date ('%%', time) == '%', 'os.date() did not return expected value when passed "%%" [1024]')
	assertTrue (os.date ('!%a', time) == 'Sat', 'os.date() did not return expected value when passed "!%a" [1025]')
	assertTrue (os.date ('!%A', time) == 'Saturday', 'os.date() did not return expected value when passed "!%A" [1026]')
	assertTrue (os.date ('!%b', time) == 'Dec', 'os.date() did not return expected value when passed "!%b" [1027]')
	assertTrue (os.date ('!%B', time) == 'December', 'os.date() did not return expected value when passed "!%B" [1028]')
	assertTrue (os.date ('!%d', time) == '31', 'os.date() did not return expected value when passed "!%d" [1029]')
	assertTrue (os.date ('!%H', time) == '12', 'os.date() did not return expected value when passed "!%H" [1030]')
	assertTrue (os.date ('!%I', time) == '12', 'os.date() did not return expected value when passed "!%I" [1031]')
	assertTrue (os.date ('!%j', time) == '365', 'os.date() did not return expected value when passed "!%j" [1032]')
	assertTrue (os.date ('!%m', time) == '12', 'os.date() did not return expected value when passed "!%m" [1033]')
	assertTrue (os.date ('!%M', time) == '00', 'os.date() did not return expected value when passed "!%M" [1034]')
	assertTrue (os.date ('!%p', time) == 'PM', 'os.date() did not return expected value when passed "!%p" [1035]')
	assertTrue (os.date ('!%S', time) == '00', 'os.date() did not return expected value when passed "!%S" [1036]')
	assertTrue (os.date ('!%U', time) == '52', 'os.date() did not return expected value when passed "!%U" [1037]')
	assertTrue (os.date ('!%w', time) == '6', 'os.date() did not return expected value when passed "!%w" [1038]')
	assertTrue (os.date ('!%W', time) == '52', 'os.date() did not return expected value when passed "!%W" [1039]')
	assertTrue (os.date ('!%x', time) == '12/31/11', 'os.date() did not return expected value when passed "!%x" [1040]')
	assertTrue (os.date ('!%X', time) == '12:00:00', 'os.date() did not return expected value when passed "!%X" [1041]')
	assertTrue (os.date ('!%y', time) == '11', 'os.date() did not return expected value when passed "!%y" [1042]')
	assertTrue (os.date ('!%Y', time) == '2011', 'os.date() did not return expected value when passed "!%Y" [1043]')
	assertTrue (os.date ('!%Z', time) == 'UTC', 'os.date() did not return expected value when passed "!%Z" [1044]')
	assertTrue (os.date ('*t', time).hour == 12, 'os.date() did not return expected value when passed "*t" [1045]')
	assertTrue (os.date ('*t', time).min == 0, 'os.date() did not return expected value when passed "*t" [1046]')
	assertTrue (os.date ('*t', time).wday == 7, 'os.date() did not return expected value when passed "*t" [1047]')
	assertTrue (os.date ('*t', time).day == 31, 'os.date() did not return expected value when passed "*t" [1048]')
	assertTrue (os.date ('*t', time).month == 12, 'os.date() did not return expected value when passed "*t" [1049]')
	assertTrue (os.date ('*t', time).year == 2011, 'os.date() did not return expected value when passed "*t" [1050]')
	assertTrue (os.date ('*t', time).sec == 0, 'os.date() did not return expected value when passed "*t" [1051]')
	assertTrue (os.date ('*t', time).yday == 365, 'os.date() did not return expected value when passed "*t" [1052]')
	assertTrue (os.date ('*t', time).isdst == false, 'os.date() did not return expected value when passed "*t" [1053]')
	assertTrue (os.date ('!*t', time).hour == 12, 'os.date() did not return expected value when passed "!*t" [1054]')
	assertTrue (os.date ('!*t', time).min == 0, 'os.date() did not return expected value when passed "!*t" [1055]')
	assertTrue (os.date ('!*t', time).wday == 7, 'os.date() did not return expected value when passed "!*t" [1056]')
	assertTrue (os.date ('!*t', time).day == 31, 'os.date() did not return expected value when passed "!*t" [1057]')
	assertTrue (os.date ('!*t', time).month == 12, 'os.date() did not return expected value when passed "!*t" [1058]')
	assertTrue (os.date ('!*t', time).year == 2011, 'os.date() did not return expected value when passed "!*t" [1059]')
	assertTrue (os.date ('!*t', time).sec == 0, 'os.date() did not return expected value when passed "!*t" [1060]')
	assertTrue (os.date ('!*t', time).yday == 365, 'os.date() did not return expected value when passed "!*t" [1061]')
	assertTrue (os.date ('!*t', time).isdst == false, 'os.date() did not return expected value when passed "!*t" [1062]')



end 

datetest ()





















showResults ()