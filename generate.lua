require "scripts/common"
require "scripts/lighthouse"

function generate()
    world = World.new();

    size = world:getSize();
    home = world:getHomePosition();
    shop = world:getShopPosition();
    c = world:getCoastPosition();

    roomSize = 14;

    if not isOwnerDLC_monsters() then return; end

    -- place lighthouse
    planetId = world:getPlanetId();

       -------------------------------------------------------------------------------------------
    if planetId == 1 then  -- desert worlds
        -- find place
        offsetFromCoast = 20;  -- offset from coasts

        -- search pyramide block on horizont line
        found = false;
        pos = Vector.new();
        pyramideId = world:findBlockId("pyramid");
        for x = home.x, size.x do   -- right way
            if world:getBlock(x, c.y, true) == pyramideId then
                found = true;
                pos.x = x;
                pos.y = c.y;

                if pos.x - roomSize <= shop.x then pos.x = shop.x + roomSize; end
                    
                world:putRoom("sand_temple.map", pos.x, pos.y + 6, -0.8,-1, true);
                break;
            end
        end

        if not found then
            for x = home.x, 0, -1 do  -- left way
                if world:getBlock(x, c.y, true) == pyramideId then
                    pos.x = x;
                    pos.y = c.y;
                    
                    if pos.x + roomSize >= shop.x then pos.x = shop.x - roomSize; end

                    world:putRoom("sand_temple.map", pos.x, pos.y + 6, 0.8,-1, true);
                    break;
                end
            end
        end
    end

    -------------------------------------------------------------------------------------------
    if planetId == 2 or planetId == 3 then  -- forest and winter worlds
        -- find place
        offsetFromCoast = 20;  -- offset from coasts

        x,y = searchPlatform(c.x + offsetFromCoast, home.x - 10, 3, 3, 20);
        if x == 0 then
            x,y = searchPlatform(home.x + 10, size.x - c.x - offsetFromCoast, 3, 2, 20);
        end

        spawnLightHouse(x, y);
    end

    -------------------------------------------------------------------------------------------
    if planetId == 4 then
        print("underground world");

        graniteId = world:findBlockId("granite");

        -- Boss Kracken
        -- prepare landscape

        -- remove lava
        for y = size.y-3, size.y-1 do
            for x = 0, size.x do
                if world:checkBlockProperty("lava",x,y) then
                    world:setBlock(x, y, -1, true);
                    world:setBlock(x, y, -1, false);
                end
            end
        end

        -- build granite surface
        for x = 0, size.x do
            if world:getBlock(x, size.y-5, true) == -1 then
                world:setBlock(x, size.y-4, graniteId, true);
                world:setBlock(x, size.y-4, graniteId, false);
                world:addWater(x, size.y-5, 2);
            end
        end

        -- kraken place
        beginx = size.x /2;
        endx = beginx + 8;

        -- build hollow
        for y = size.y-4, size.y-1 do
            for x = beginx, endx do
                if (x == beginx or x == endx) or (y == size.y-1) then
                    world:setBlock(x, y, graniteId, true);
                    world:setBlock(x, y, graniteId, false);
                else
                    world:setBlock(x, y, -1, true);
                    world:addWater(x, y, 5);
                end
            end
        end

        world:setWaterDeadline(23);

        --world:setBlock(beginx+1, sizeY-4, graniteId, true);
        --world:setBlock(endx-1, sizeY-4, graniteId, true);

        -- spawn boss
        x = (beginx + 4);
        y = (size.y - 5);
        world:spawn('kraken', x,y);
    end

    -------------------------------------------------------------------------------------------
    -- DLC Highland
    -- planet = world:getPlanet();

    -- if planet == "lonely_mountain" then

    --     horizontLine = c.y;
    --     validAreaHeight = 40;
    --     border = 15;

    --     x = math.random(10, math.floor(size.x-10));
    --     y = math.random(math.floor(size.y - validAreaHeight - border), math.floor(size.y - border));

    --     world:putRoom("portal.map", x, y, 0.5, 0.5, false);
    -- end

end