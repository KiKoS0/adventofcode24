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
	local checks = {
		expect(list, "S", i - 3, j) and expect(list, "A", i - 2, j) and expect(list, "M", i - 1, j),
		expect(list, "M", i + 1, j) and expect(list, "A", i + 2, j) and expect(list, "S", i + 3, j),
		expect(list, "S", i, j - 3) and expect(list, "A", i, j - 2) and expect(list, "M", i, j - 1),
		expect(list, "M", i, j + 1) and expect(list, "A", i, j + 2) and expect(list, "S", i, j + 3),
		expect(list, "S", i - 3, j - 3) and expect(list, "A", i - 2, j - 2) and expect(list, "M", i - 1, j - 1),
		expect(list, "M", i + 1, j + 1) and expect(list, "A", i + 2, j + 2) and expect(list, "S", i + 3, j + 3),
		expect(list, "S", i - 3, j + 3) and expect(list, "A", i - 2, j + 2) and expect(list, "M", i - 1, j + 1),
		expect(list, "M", i + 1, j - 1) and expect(list, "A", i + 2, j - 2) and expect(list, "S", i + 3, j - 3),
	}
	local result = 0
	for _, check in ipairs(checks) do
		if check then
			result = result + 1
		end
	end
	return result
end

local input = parse_input("input")

local result = 0
for i, line in ipairs(input) do
	for j, value in ipairs(line) do
		if value == "X" then
			result = result + check_all(input, i, j)
		end
	end
end
print(result)
