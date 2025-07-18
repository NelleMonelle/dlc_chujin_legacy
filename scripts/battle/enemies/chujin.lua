local Dummy, super = Class(EnemyBattler)

function Dummy:init()
    super.init(self)

    self.name = "Chujin"
    self:setActor("chujin")

    self.max_health = 4500
    self.health = 4500
    self.attack = 14
    self.defense = 0
    self.money = 0

    self.spare_points = 0
    self.tired_percentage = 0

    self.waves = {
        "basic",
        "aiming",
        "movingarena"
    }

    self.dialogue = {
        "..."
    }

    self.text = {
        "* The dummy gives you a soft\nsmile.",
        "* The power of fluffy boys is\nin the air.",
        "* Smells like cardboard.",
    }
    self.low_health_text = "* The dummy looks like it's\nabout to fall over."

    self:registerAct("Reason", nil, {"ceroba"})
end

function Dummy:onAct(battler, name)
    if name == "Check" then
        return "* CHUJIN KETSUKANE - AT 25 DF 5\n* A memory of a long lost person."
    elseif name == "Reason" then
        return "* Ceroba tries to reason...[wait:10]\n* No resonse."
    elseif name == "Standard" then
        if battler.chara.id == "ceroba" then
            self:addMercy(0)
            return "* But it failed."
        else
            return "* But "..battler.chara:getName().." was unable to do anything."
        end
    end

    return super.onAct(self, battler, name)
end

return Dummy