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

local input, updates = parse_input("input")

local result = 0

for _, update in ipairs(updates) do
	local correct_order = true

	for j, page in ipairs(update) do
		for k = j + 1, #update, 1 do
			if (input[page] or {})[update[k]] == nil then
				correct_order = false
				goto next_update
			end
		end
	end
	::next_update::
	if correct_order then
		result = result + update[math.ceil(#update / 2)]
	end
end

print(result)
