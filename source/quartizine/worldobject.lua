local object = require 'quartizine.lib.classic'

local worldObject = object:extend()

function worldObject:new(world)
	self.world = world
end

function worldObject:start() end

return worldObject