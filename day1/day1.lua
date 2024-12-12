local file = io.open("input", "r")
local input = file:read("*all")

local function parse_input(text)
	local first_list = {}
	local second_list = {}
	for n1, n2 in text:gmatch("(%d+)%s+(%d+)") do
		table.insert(first_list, tonumber(n1))
		table.insert(second_list, tonumber(n2))
	end
	return first_list, second_list
end

local first_list, second_list = parse_input(input)

table.sort(first_list)
table.sort(second_list)

local result = 0

for k, v in ipairs(first_list) do
	result = result + math.abs(v - second_list[k])
end

print(result)
