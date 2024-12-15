local rex = require("rex_pcre2")

local result = 0
local pattern = "mul\\((\\d+),(\\d+)\\)|(do\\(\\))|(don't\\(\\))"

local add = true
for line in io.lines("input") do
	for num1, num2, do_stm, dont_stm in rex.gmatch(line, pattern) do
		if dont_stm then
			add = false
		elseif do_stm then
			add = true
		elseif add then
			result = tonumber(num1) * tonumber(num2) + result
		end
	end
end

print(result)
