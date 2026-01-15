return {
    ---@param cutscene WorldCutscene
    main = function(cutscene, map, partyleader)
        local susie = Game.world:getCharacter("susie")
        local ceroba = Game.world:getCharacter("ceroba_dw")
        local jamm = Game.world:getCharacter("jamm") or Game.world:getCharacter("jammarcy")
        if map == "start" then
            if susie then
                cutscene:text("* So,[wait:5] new dark world,[wait:5] huh?", "neutral_side", "susie")
                cutscene:text("* ...", "neutral_side", "susie")
                cutscene:text("* It's awfully quiet in here.", "sus_nervous", "susie")
				if jamm then
					cutscene:text("* Too quiet...", "suspicious", "jamm")
				end
            end
        elseif map == "cityview" then
            if susie then
                cutscene:text("* ...[wait:5] wow.", "surprise", "susie")
                cutscene:text("* This city reminds me of the one from the Cyber World.", "smirk", "susie")
            end
        else
            cutscene:text("* (But your voice echoed aimlessly.)")
        end
    end
}
