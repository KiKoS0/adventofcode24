local inspect = require("inspect")

local function parse_input(file)
	local list = {}
	local first = true
	local second = {}
	for line in io.lines(file) do
		if line == "" and first then
			first = false
		elseif first then
			local num1, num2 = line:match("(%d+)%|(%d+)")
			num1 = tonumber(num1)
			num2 = tonumber(num2)
			if list[num1] ~= nil then
				list[num1][num2] = true
			else
				list[num1] = { [num2] = true }
			end
		else
			local numbers = {}
			for num in line:gmatch("(%d+)") do
				table.insert(numbers, tonumber(num))
			end
			table.insert(second, numbers)
		end
	end
	return list, second
end

local function has_value(tab, val)
	for _, value in ipairs(tab) do
		if value == val then
			return true
		end
	end

	return false
end

local function permutation(graph, update)
	local new_graph = {}

	for _, k in ipairs(update) do
		new_graph[k] = {}
		for n, _ in pairs(graph[k] or {}) do
			if has_value(update, n) then
				table.insert(new_graph[k], n)
			end
		end
	end
	local permuted = {}

	for value, edges in pairs(new_graph) do
		permuted[#update - #edges] = value
	end

	return permuted
end

local function correct_update_with_permutation(input, update)
	for j, page in ipairs(update) do
		for k = j + 1, #update, 1 do
			if (input[page] or {})[update[k]] == nil then
				return permutation(input, update)[math.ceil(#update / 2)]
			end
		end
	end
end

local input, updates = parse_input("input")

local result = 0

for _, update in ipairs(updates) do
	local middle = correct_update_with_permutation(input, update)

	if middle then
		result = result + middle
	end
end

print(result)
