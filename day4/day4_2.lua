local function parse_input(file)
	local list = {}
	for line in io.lines(file) do
		local chars = {}
		for c in line:gmatch(".") do
			table.insert(chars, c)
		end
		table.insert(list, chars)
	end
	return list
end

local function expect(list, c, i, j)
	local character = (list[i] or {})[j]
	return character ~= nil and character == c
end

local function check_all(list, i, j)
	local checks_1 = {
		expect(list, "S", i + 1, j + 1) and expect(list, "M", i - 1, j - 1),
		expect(list, "M", i + 1, j + 1) and expect(list, "S", i - 1, j - 1),
	}
	local checks_2 = {
		expect(list, "S", i + 1, j - 1) and expect(list, "M", i - 1, j + 1),
		expect(list, "M", i + 1, j - 1) and expect(list, "S", i - 1, j + 1),
	}
	local check_1 = false
	for _, check in ipairs(checks_1) do
		check_1 = check_1 or check
	end

	local check_2 = false
	for _, check in ipairs(checks_2) do
		check_2 = check_2 or check
	end

	return check_1 and check_2
end

local input = parse_input("input")

local result = 0
for i, line in ipairs(input) do
	for j, value in ipairs(line) do
		if value == "A" and check_all(input, i, j) then
			result = result + 1
		end
	end
end
print(result)
