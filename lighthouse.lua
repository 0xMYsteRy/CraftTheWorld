--module(...,package.seeall)

function spawnLightHouse(x,y)
    if not isOwnerDLC_monsters() then return; end

    print("spawn lighthouse");
    world = World.new();
    
    -- clear blocks
    for i=y, y-5,-1 do
        for j=x-2,x+2 do
            world:removeBlock(j, i, false);
            world:removeBlock(j, i, true);
        end
    end

    --mountId = world:findBlockId("dirt");
    mountId = world:findBlockId("stone");
    for i=x-2,x+2  do
        world:setBlock(i, y+1, mountId, true);
    end

    world:instance("lighthouse", x, y);

    chestId = world:findBlockId("lighthouse_chest");
    world:setBlock(x+2, y, chestId, true);
end