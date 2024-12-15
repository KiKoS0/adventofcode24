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

local list = parse_input("input")
local result = 0

for _, level in ipairs(list) do
	local safe = true
	local asc = level[1] - level[2] < 0

	for index, report in ipairs(level) do
		if(index == #level) then
			break
		end

		local diff = report - level[index+1]

		if(asc and diff<=-1 and diff>=-3)then
			goto continue
		end
		if(not asc and diff>=1 and diff<=3)then
			goto continue
		end

		safe = false
		break
	    ::continue::
	end
	if safe then
		result = result+ 1
	end
end

print(result)
