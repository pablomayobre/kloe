local baton = require 'kloe.lib.baton'
local cargo = require 'kloe.lib.cargo'
local inspect = require 'kloe.lib.inspect'
local lume = require 'kloe.lib.lume'
local object = require 'kloe.lib.classic'
local ochre = require 'kloe.lib.ochre'
local state = require 'kloe.lib.gamestate'
local talkback = require 'kloe.lib.talkback'
local timer = require 'kloe.lib.timer'
local vector = require 'kloe.lib.vector'

local kloe = {
	assets = {
		load = cargo.init,
	},
	class = {
		newClass = function() return object:extend() end
	},
	-- wrap love.graphics to accept vector arguments
	graphics = setmetatable({}, {
		__index = function(t, k)
			return function(...)
				local args = {...}
				local newArgs = {}
				for _, arg in ipairs(args) do
					if vector.isvector(arg) then
						table.insert(newArgs, arg.x)
						table.insert(newArgs, arg.y)
					else
						table.insert(newArgs, arg)
					end
				end
				love.graphics[k](unpack(newArgs))
			end
		end,
	}),
	input = {
		newPlayer = baton.new,
	},
	math = {
		clamp = lume.clamp,
		round = lume.round,
		sign = lume.sign,
		lerp = lume.lerp,
		choose = lume.randomchoice,
		newVector = vector,
	},
	message = {
		listen = function(...) return talkback:listen(...) end,
		say = function(...) return talkback:say(...) end,
		ignore = function(...) return talkback:ignore(...) end,
		reset = function(...) return talkback:reset(...) end,
		newGroup = function(...) return talkback:newGroup(...) end,
	},
	state = state,
	table = {
		inspect = inspect,
		remove = lume.remove,
		all = lume.all,
		any = lume.any,
		filter = lume.filter,
		reject = lume.reject,
		match = lume.match,
		serialize = lume.serialize,
		deserialize = lume.deserialize,
		ripairs = lume.ripairs,
	},
	timer = {
		newTimer = timer.new,
	},
	world = {
		newWorld = ochre.new,
	},
}

return kloe