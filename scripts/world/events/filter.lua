---@class Event.filter : Event
local event, super = Class(Event, "filter")

function event:init(data)
    super.init(self, data)
    local properties = data and data.properties or {}
    self.fx = self:createFX(properties)
    self.fx.parent = self
    if data.shape ~= "point" then
        self:addFX(MaskFX(self))
    end
    Game.world.filter = self
end

function event:onAdd(parent)
    super.onAdd(self, parent)

    -- I'm too lazy to add a seperate overlay object layer on every map it appears in
    if Game.battle then
        self.layer = BATTLE_LAYERS["top"] + 100
    else
        self.layer = WORLD_LAYERS["top"] + 100
    end
end

function event:onRemoveFromStage(stage)
    super.onRemoveFromStage(self, stage)
    if self.parent and self.parent:includes(Battle) and Game.world then
        local x, y = self:getScreenPos()
        self:setParent(Game.world)
        self:setScreenPos(x, y)
		Game.world.filter = self
    else
        Game.world.filter = nil
    end
end

function event:drawMask()
    if self.collider then
        self.collider:drawFill()
    else
        love.graphics.rectangle("fill", 0,0,self:getSize())
    end
end

function event:update()
    super.update(self)
    if self.fx then
        self.fx:update()
    end
end

--- *Override* Returns an instance of the desired DrawFX, depending on the properties.
---@return DrawFX?
function event:createFX(properties)
    local fxtype = (properties.type or "study"):lower()
    if fxtype == "study" then
        return ShaderFX("studygrayscale")
    end
end

function event:fullDraw(...)
    self.main_canvas = love.graphics.getCanvas() -- Usually SCREEN_CANVAS, but not always.
    super.fullDraw(self)
end

function event:draw()
    if not (self.fx and self.fx:isActive()) then
        return super.draw(self)
    end
    love.graphics.push()
    Draw.pushCanvasLocks()
    love.graphics.origin()
    local c = Draw.pushCanvas(SCREEN_WIDTH, SCREEN_HEIGHT)
    Draw.drawCanvas(self.main_canvas)
    Draw.popCanvas(true)
    love.graphics.clear(0, 0, 0, 1)
    self.fx:draw(c)
    Draw.popCanvasLocks()
    love.graphics.pop()
    super.draw(self)
end

return event