local anim8 = require 'kloe.lib.anim8'
local baton = require 'kloe.lib.baton'
local cargo = require 'kloe.lib.cargo'
local inspect = require 'kloe.lib.inspect'
local lume = require 'kloe.lib.lume'
local object = require 'kloe.lib.classic'
local state = require 'kloe.lib.gamestate'
local talkback = require 'kloe.lib.talkback'
local timer = require 'kloe.lib.timer'
local vector = require 'kloe.lib.vector'

local world = require 'kloe.world'

local conversation = talkback.new()

local kloe = {
	assets = {
		load = cargo.init,
	},
	class = {
		newClass = function() return object:extend() end
	},
	graphics = {
		newGrid = anim8.newGrid,
		newAnimation = anim8.newAnimation,

		rectangleV = function(mode, p, s, r, segments)
			r = r or {}
			love.graphics.rectangle(mode, p.x, p.y, s.x, s.y, r.x, r.y, segments)
		end,
		circleV = function(mode, p, radius, segments)
			love.graphics.circle(mode, p.x, p.y, radius, segments)
		end,
	},
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
		listen = function(...) conversation:listen(...) end,
		say = function(...) return conversation:say(...) end,
		ignore = function(...) conversation:stopListening(...) end,
		newGroup = function(...) return conversation:newGroup(...) end,
	},
	state = state,
	table = {
		inspect = inspect,
		remove = lume.remove,
	},
	timer = {
		newTimer = timer.new,
	},
	world = {
		newWorld = world,
	},
}

return kloe