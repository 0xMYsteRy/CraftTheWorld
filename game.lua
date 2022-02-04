function create()  -- on create level
end

function start() -- on start level
    --print("start game script...");

    world = World.new();
    planetId = world:getPlanetId();
    
    if isOwnerDLC_monsters() then
        if planetId == 4 then  -- underground
            world:setWaterDeadline(23);
        end
    end

    -- resources disallow
    --[[
    if isOwnerDLC_monsters() then
        if planetId == 1 then  -- desert
            world:disallowResource("rune1");
            world:disallowResource("rune2");
            world:disallowResource("rune3");
            world:disallowResource("rune4");
            world:disallowResource("rune5");
            world:disallowResource("rune6");
        end
    end
    --]]

end

function update(delta)  -- on update level
    --print("game update call...");
end