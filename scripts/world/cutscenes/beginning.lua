return {
    ---@param cutscene WorldCutscene
    start = function(cutscene)
        local transition = Game.world:getEvent(15)
        local leader = Game.world.player
        cutscene:detachFollowers()
        transition:setPosition(0, transition.y)
        local darkness = Rectangle(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
        cutscene:wait(1)
        if #Game.party == 1 then
            leader:setPosition(320, -40)
            cutscene:wait(cutscene:slideToSpeed(leader, leader.x, 320, 20))
            Assets.playSound("impact")
            leader:setSprite("landed")
            cutscene:wait(1)
        elseif #Game.party == 2 then
            local party2 = cutscene:getCharacter(Game.party[2].id)
            leader:setPosition(350, -40)
            party2:setPosition(290, -40)
            cutscene:wait(cutscene:slideToSpeed(leader, leader.x, 320, 20))
            Assets.playSound("impact")
            leader:setSprite("landed")
            cutscene:wait(1)
            cutscene:wait(cutscene:slideToSpeed(party2, party2.x, 320, 20))
            Assets.playSound("impact")
            party2:setSprite("landed")
            cutscene:wait(1)
        elseif #Game.party == 3 then
            local party2 = cutscene:getCharacter(Game.party[2].id)
            local party3 = cutscene:getCharacter(Game.party[3].id)
            leader:setPosition(320, -40)
            party2:setPosition(260, -40)
            party3:setPosition(380, -40)
            cutscene:wait(cutscene:slideToSpeed(leader, leader.x, 320, 20))
            Assets.playSound("impact")
            leader:setSprite("landed")
            cutscene:wait(1)
            cutscene:wait(cutscene:slideToSpeed(party2, party2.x, 320, 20))
            Assets.playSound("impact")
            party2:setSprite("landed")
            cutscene:wait(1)
            cutscene:wait(cutscene:slideToSpeed(party3, party3.x, 320, 20))
            Assets.playSound("impact")
            party3:setSprite("landed")
            cutscene:wait(1)
        elseif #Game.party == 4 then
            local party2 = cutscene:getCharacter(Game.party[2].id)
            local party3 = cutscene:getCharacter(Game.party[3].id)
            local party4 = cutscene:getCharacter(Game.party[4].id)
            leader:setPosition(350, -40)
            party2:setPosition(290, -40)
            party3:setPosition(230, -40)
            party4:setPosition(410, -40)
            cutscene:wait(cutscene:slideToSpeed(leader, leader.x, 320, 20))
            Assets.playSound("impact")
            leader:setSprite("landed")
            cutscene:wait(1)
            cutscene:wait(cutscene:slideToSpeed(party2, party2.x, 320, 20))
            Assets.playSound("impact")
            party2:setSprite("landed")
            cutscene:wait(1)
            cutscene:wait(cutscene:slideToSpeed(party3, party3.x, 320, 20))
            Assets.playSound("impact")
            party3:setSprite("landed")
            cutscene:wait(1)
            cutscene:wait(cutscene:slideToSpeed(party4, party4.x, 320, 20))
            Assets.playSound("impact")
            party4:setSprite("landed")
            cutscene:wait(1)
        end
        cutscene:wait(1)
        transition:setPosition(240, transition.y)
        cutscene:attachFollowers()
        cutscene:interpolateFollowers()
    end,
    cg = function(cutscene)
        -- CG
        local cg = Sprite("world/cutscenes/cg", 0, 0)
        cg:setScale(2)
        cg:setParallax(0, 0)
        cg.layer = WORLD_LAYERS["top"] - 2
        Game.world:addChild(cg)

        -- character spawning
        local function spawnCharacter(id, x, y)
            local path1 = Game.world:getCharacter(id).actor.path
            local char = Sprite(path1.."/walk/up_1", x, y)
            char:setScale(6)
            char:setOrigin(0.5, 1)
            char.layer = WORLD_LAYERS["top"] - 1
            Game.world:addChild(char)
            return char
        end
        local characters = {}
        for i = 1, #Game.party do
            local chara = spawnCharacter(Game.party[i].id, 100 + (i * 200), SCREEN_HEIGHT + 100)
            table.insert(characters, chara)
        end

        -- fader or whatever it's called
        local thingy = Rectangle(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
        thingy:setParallax(0, 0)
        thingy.color = {0, 0, 0}
        thingy.layer = WORLD_LAYERS["top"]
        Game.world:addChild(thingy)

        -- placing party
        cutscene:detachFollowers()
        for i = 1, #Game.party do
            local chara = Game.world:getCharacter(Game.party[i].id)
            chara:setFacing("up")
            chara:setPosition(240 + (i * 60), 230)
        end

        -- now actual cutscene stuff
        cutscene:wait(0.5)
        Game.world.timer:tween(0.5, thingy, {color = {1, 1, 1}})
        cutscene:wait(0.5)
        thingy:fadeOutAndRemove(1)
        cutscene:wait(2)
        cutscene:slideTo(cg, cg.x - 1158, cg.y, 3)
        for _,spr in ipairs(characters) do
            cutscene:slideTo(spr, spr.x - 1158, spr.y, 3)
        end
        cutscene:wait(4)
        cg:fadeOutAndRemove(1)
        for _,spr in ipairs(characters) do
            spr:fadeOutAndRemove(1)
        end
        cutscene:wait(3)
        if Game:hasPartyMember("ceroba") then
            cutscene:text("* What...[wait:5] What is all this?", "surprised", "ceroba")
            cutscene:text("* Am I...[wait:5] Dreaming?", "nervous_smile", "ceroba")
            cutscene:runIf(Game:hasPartyMember("hero") or Game:hasPartyMember("susie"), function(cutscene)
                cutscene:textVariant("* Well...[wait:5] No.[wait:5] That is what we call a \"Dark World\".", {
                    hero = "neutral_opened",
                    susie = "nervous_side"
		        }, {priority={ -- --> order of priority
		        	"susie", "hero"
		        }})
                cutscene:textVariant("* If shortly...", {
                    hero = "neutral_closed_b",
                    susie = "nervous"
		        }, {priority={ -- --> order of priority
		        	"susie", "hero"
		        }})
                cutscene:textVariant("* Those appear when a Dark Fountain is made.", {
                    hero = "neutral_closed",
                    susie = "neutral"
		        }, {priority={ -- --> order of priority
		        	"susie", "hero"
		        }})
                cutscene:textVariant("* It transforms everything around it,[wait:5] turning it into...", {
                    hero = "neutral_closed",
                    susie = "neutral_side"
		        }, {priority={ -- --> order of priority
		        	"susie", "hero"
		        }})
                cutscene:textVariant("* Basically anything you can imagine.", {
                    hero = "neutral_closed_b",
                    susie = "smile"
		        }, {priority={ -- --> order of priority
		        	"susie", "hero"
		        }})
                cutscene:textVariant("* Cities,[wait:5] castles,[wait:5] sanctuaries...[wait:5] Dang,[wait:5] even whole kingdoms!", {
                    hero = "happy",
                    susie = "sincere_smile"
		        }, {priority={ -- --> order of priority
		        	"susie", "hero"
		        }})
                cutscene:text("* That's...[wait:5] A lot to take in.", "surprised", "ceroba")
                cutscene:text("* If any of that...[wait:5] Is true,[wait:5] that is.", "suspicious", "ceroba")
				if Game:hasPartyMember("jamm") then
					cutscene:text("* From what I've seen,[wait:5] it is...", "neutral", "jamm")
					cutscene:text("* I've seen a bunch of these worlds as well.", "neutral", "jamm")
					cutscene:text("* They're... truly amazing.", "relief", "jamm")
				end
            end)
        end
        cutscene:interpolateFollowers()
        cutscene:attachFollowers()
    end,
    dead_end = function(cutscene)
        local leader = Game.world.player
        local party2
        local party3
        local party4
        local susie = cutscene:getCharacter("susie")
        local ceroba = cutscene:getCharacter("ceroba")
        cutscene:wait(1)
        cutscene:detachCamera()
        cutscene:wait(cutscene:panTo(1840, 240, 1))
        cutscene:wait(1)
        if ceroba then
            cutscene:text("* Ugh,[wait:5] a dead end.[wait:5] Just great.", "muttering", "ceroba")
            cutscene:wait(1)
            ceroba:setFacing("up")
            cutscene:wait(1)
            cutscene:text("* Maybe we could jump if it isn't a far way down...", "closed_eyes", "ceroba")
        elseif susie then
            cutscene:text("* Damn,[wait:5] a dead end.", "annoyed", "susie")
        else
            cutscene:text("* (A dead end.)")
        end
        cutscene:detachFollowers()
        if #Game.party == 1 then
            cutscene:walkToSpeed(leader, 1780, 220, 8, "up")
            cutscene:wait(2)
        elseif #Game.party == 2 then
            party2 = cutscene:getCharacter(Game.party[2].id)
            cutscene:walkToSpeed(leader, 1750, 220, 8, "up")
            cutscene:walkToSpeed(party2, 1810, 220, 8, "up")
            cutscene:wait(2)
        elseif #Game.party == 3 then
            party2 = cutscene:getCharacter(Game.party[2].id)
            party3 = cutscene:getCharacter(Game.party[3].id)
            cutscene:walkToSpeed(leader, 1780, 220, 8, "up")
            cutscene:walkToSpeed(party2, 1720, 220, 8, "up")
            cutscene:walkToSpeed(party3, 1840, 220, 8, "up")
            cutscene:wait(2)
        elseif #Game.party == 4 then
            party2 = cutscene:getCharacter(Game.party[2].id)
            party3 = cutscene:getCharacter(Game.party[3].id)
            party4 = cutscene:getCharacter(Game.party[4].id)
            cutscene:walkToSpeed(leader, 1750, 220, 8, "up")
            cutscene:walkToSpeed(party2, 1810, 220, 8, "up")
            cutscene:walkToSpeed(party3, 1690, 220, 8, "up")
            cutscene:walkToSpeed(party4, 1870, 220, 8, "up")
            cutscene:wait(2)
        end
        if ceroba then
            cutscene:text("* Alright,[wait:5] it doesn't seem to be.", "unsure", "ceroba")
            cutscene:text("* Let's go.", "neutral", "ceroba")
        elseif susie then
            cutscene:text("* ...", "sus_nervous", "susie")
        end
        if #Game.party == 1 then
            leader:setSprite("landed")
            cutscene:wait(0.5)
            Assets.playSound("jump")
            leader:jumpTo(leader.x, 320, 2, 0.5, "ball")
            cutscene:wait(2)
        elseif #Game.party == 2 then
            leader:setSprite("landed")
            cutscene:wait(0.5)
            Assets.playSound("jump")
            cutscene:wait(leader:jumpTo(leader.x, 320, 1, 0.5, "ball"))
            cutscene:wait(2)
            party2:setSprite("landed")
            cutscene:wait(0.5)
            Assets.playSound("jump")
            cutscene:wait(party2:jumpTo(party2.x, 320, 1, 0.5, "ball"))
            cutscene:wait(2)
        elseif #Game.party == 3 then
            Assets.playSound("jump")
            cutscene:wait(leader:jumpTo(leader.x, 320, 1, 0.5, "ball"))
            Assets.playSound("jump")
            cutscene:wait(party2:jumpTo(party2.x, 320, 1, 0.5, "ball"))
            Assets.playSound("jump")
            cutscene:wait(party3:jumpTo(party3.x, 320, 1, 0.5, "ball"))
        elseif #Game.party == 4 then
            Assets.playSound("jump")
            cutscene:wait(leader:jumpTo(leader.x, 320, 1, 0.5, "ball"))
            Assets.playSound("jump")
            cutscene:wait(party2:jumpTo(party2.x, 320, 1, 0.5, "ball"))
            Assets.playSound("jump")
            cutscene:wait(party3:jumpTo(party3.x, 320, 1, 0.5, "ball"))
            Assets.playSound("jump")
            cutscene:wait(party4:jumpTo(party4.x, 320, 1, 0.5, "ball"))
        end
    end
}
