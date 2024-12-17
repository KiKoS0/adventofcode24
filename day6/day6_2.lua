local tablex = require("pl.tablex")

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
Guard.__index = Guard

function Guard.new(x, y, char)
	local direction = ({
		["^"] = 0,
		[">"] = 90,
		["v"] = 180,
		["<"] = 270,
	})[char] or error("unexpected guard position")

	local self = { x = x, y = y, direction = direction }
	setmetatable(self, Guard)
	return self
end

function Guard:copy()
	local guard = tablex.deepcopy(self)
	setmetatable(guard, Guard)
	return guard
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

local guard
-- Find the guard's first position in the map
for i, line in ipairs(input) do
	for j, value in ipairs(line) do
		if value ~= "." and value ~= "#" then
			guard = Guard.new(i, j, value)
		end
	end
end

function in_bounds(input, guard)
	return guard.x >= 1 and guard.x <= #input and guard.y >= 1 and guard.y <= #input[1]
end

function pos_key(guard)
	return guard.x .. "-" .. guard.y .. "-" .. guard.direction
end

local positions = 0

for i, line in ipairs(input) do
	for j, _ in ipairs(line) do
		if input[i][j] ~= "." then
			goto continue
		end

		local map = tablex.deepcopy(input)
		local guard_copy = guard:copy()
		local found = false
		local visited = {}

		map[i][j] = "#"
		while visited[pos_key(guard_copy)] == nil do
			if not in_bounds(map, guard_copy) then
				break
			end

			visited[pos_key(guard_copy)] = true
			guard_copy:move(map)
		end
		found = visited[pos_key(guard_copy)] ~= nil

		if found then
			positions = positions + 1
		end

		::continue::
	end
end

print(positions)
