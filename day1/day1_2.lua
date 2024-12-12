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

local result = 0
local freq_map = {}
for _, v in ipairs(first_list) do
	freq_map[v] = (freq_map[v] or 0) + 1
end

for _, v in ipairs(second_list) do
	result = result + v * (freq_map[v] or 0)
end

print(result)
