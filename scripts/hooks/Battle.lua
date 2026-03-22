local Battle, super = HookSystem.hookScript(Battle)

function Battle:init(...)
    super.init(self, ...)
end

function Battle:postInit(...)
    super.postInit(self, ...)
    self.timer:after(1/30, function()
        if Game.world and Game.world.filter and Game.world.filter.parent and Game.world.filter.parent:includes(World) then
            local x, y = Game.world.filter:getScreenPos()
            Game.world.filter:setParent(self)
            Game.world.filter:setScreenPos(x, y)
            self.filter = Game.world.filter
        end
    end)
end

return Battle