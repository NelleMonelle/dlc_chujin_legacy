local Vignette, super = Class(Event)

function Vignette:init(data)
	super.init(self, data)
    self:setPosition(0,0)
    self:setParallax(0,0)
    self:setSprite("world/events/vignette")
end

function Vignette:onAdd(parent)
    super.onAdd(self,parent)
    self:setLayer(WORLD_LAYERS["below_ui"])
end

return Vignette