local actor, super = Class(Actor, "chujin")

function actor:init()
    super.init(self)

    self.name = "Chujin"

    self.width = 27
    self.height = 45

    self.hitbox = {0, 25, 19, 14}

    self.color = {1, 0, 0}

    self.flip = nil

    self.path = "world/npcs/chujin"
    self.default = "placeholder"

    self.voice = "chujin"
    self.portrait_path = "face/chujin"
    self.portrait_offset = {-19, -13}

    self.can_blush = false

    self.talk_sprites = {}

    self.animations = {}

    self.offsets = {}
end

return actor