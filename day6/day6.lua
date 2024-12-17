local inspect = require("inspect")

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

local input = parse_input("input")

Guard = {}

function Guard.new(x, y, char)
	local direction = ({
		["^"] = 0,
		[">"] = 90,
		["v"] = 180,
		["<"] = 270,
	})[char] or error("unexpected guard position")

	local self = { x = x, y = y, direction = direction }
	setmetatable(self, { __index = Guard })
	return self
end

function Guard:move(map)
	local movements = {
		[0] = { -1, 0 },
		[90] = { 0, 1 },
		[180] = { 1, 0 },
		[270] = { 0, -1 },
	}
	local move = movements[self.direction]
	local next_tile = { x = self.x + move[1], y = self.y + move[2] }

	if (map[next_tile.x] or {})[next_tile.y] == "#" then
		self.direction = (self.direction + 90) % 360
	else
		self.x = next_tile.x
		self.y = next_tile.y
	end
end

-- Find the guard's first position in the map
for i, line in ipairs(input) do
	for j, value in ipairs(line) do
		if value ~= "." and value ~= "#" then
			guard = Guard.new(i, j, value)
		end
	end
end

local monitored_tiles = {}

while guard.x >= 1 and guard.x <= #input and guard.y >= 1 and guard.y <= #input[1] do
	monitored_tiles[guard.x .. "-" .. guard.y] = true
	guard:move(input)
end

local count = 0
for _ in pairs(monitored_tiles) do
	count = count + 1
end

print(count)
