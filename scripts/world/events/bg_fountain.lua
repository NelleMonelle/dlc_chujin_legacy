local BGFountain, super = Class(Event)

function BGFountain:init(data)
	super.init(self, data)
    self:setPosition(0,0)
    self:setParallax(0,0)
    self:setSprite("world/events/bg_fountain", 1/4)
    self.sprite:setScale(1)
end

return BGFountain