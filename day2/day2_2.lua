local function parse_input(file)
	local list = {}
	for line in io.lines(file) do
		local numbers = {}
		for num in line:gmatch("%d+") do
			table.insert(numbers, tonumber(num))
		end
		table.insert(list, numbers)
	end
	return list
end

local function is_valid(asc, level, i, j)
	if i < 1 or j > #level then
		return false
	end

	local diff = level[i] - level[j]

	return (asc and diff <= -1 and diff >= -3) or (not asc and diff >= 1 and diff <= 3)
end

local list = parse_input("input")
local result = 0

for _, level in ipairs(list) do
	local safe = true
	local offense = 0
	local asc = level[1] - level[#level] < 0

	local i = 2
	while i <= #level do
		if is_valid(asc, level, i - 1, i) then
			goto continue
		end

		offense = offense + 1

		if offense > 1 then
			safe = false
			break
		end

		-- Current number is invalid
		if is_valid(asc, level, i - 1, i + 1) then
			i = i + 1
			goto continue
		end

		-- Last number is invalid
		if is_valid(asc, level, i - 2, i) or i + 1 > #level or i - 2 < 1 then
			goto continue
		end

		safe = false

		-- Lua formatter for some reason breaks with the continue label and a break
		if not safe then
			break
		end

		::continue::
		i = i + 1
	end

	if safe then
		result = result + 1
	end
end

print(result)
