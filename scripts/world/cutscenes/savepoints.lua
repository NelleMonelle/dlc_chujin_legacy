return function(cutscene, map)
    if map == "cityview" then -- this idiot (me) really thought you could put cutscenes to savepoints
        cutscene:text("* Looking at the city on the horizon...")
        cutscene:text("* You can't help but wonder...")
        cutscene:text("* How did it end up in Ceroba's basement?")
        cutscene:text("* You're fileed with the power of questioning.")
    end
end