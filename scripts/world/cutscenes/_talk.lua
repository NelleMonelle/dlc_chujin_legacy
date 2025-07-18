return {
    ---@param cutscene WorldCutscene
    main = function(cutscene, map, partyleader)
        local susie = Game.world:getCharacter("susie")
        local ceroba = Game.world:getCharacter("ceroba_dw")
        if map == "start" then
            if susie then
                cutscene:text("* So,[wait:5] new dark world,[wait:5] huh?", "neutral_side", "susie")
                cutscene:text("* ...", "neutral_side", "susie")
                cutscene:text("* It's awfully quiet in here.", "sus_nervous", "susie")
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
