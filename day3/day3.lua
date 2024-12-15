local function parse_input(file)
	local list = {}
	for line in io.lines(file) do
		for num1, num2 in line:gmatch("mul%((%d+),(%d+)%)") do
			print(num1, num2)
			table.insert(list, { tonumber(num1), tonumber(num2) })
		end
	end
	return list
end

local list = parse_input("input")

local result = 0

for _, value in ipairs(list) do
	result = result + value[1] * value[2]
end
print(result)
