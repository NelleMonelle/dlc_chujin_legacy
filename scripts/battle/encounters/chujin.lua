local Dummy, super = Class(Encounter)

function Dummy:init()
    super.init(self)

    self.text = "* Petals rain from heavens."

    self.music = "mothers_love_phase_2"
    self.background = false

    self:addEnemy("chujin")
end

return Dummy