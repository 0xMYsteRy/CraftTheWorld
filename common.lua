--module(...,package.seeall)

local function setfenv(fn, env)
  local i = 1
  while true do
    local name = debug.getupvalue(fn, i)
    if name == "_ENV" then
      debug.upvaluejoin(fn, i, (function()
        return env
      end), 1)
      break
    elseif not name then
      break
    end

    i = i + 1
  end

  return fn
end

function searchPlatform(b, e, delta, length, max_height)
    
  print("search platform");
  world = World.new();
  c = world:getCoastPosition();
  minY = 0;
  maxY = 0;
  count = 0;
  for x = b,e do
      y = world:searchSurfaceY(x);
      if y < c.y - max_height then count = 0; end  -- out of max height
      if count == 0 then 
          minY = y; -- init
          maxY = y;
          count = 1;
      else
          minY = math.min(minY, y);
          maxY = math.max(maxY, y);

          if math.abs(minY - maxY) > delta then
              count = 0;
          else
              count = count + 1;
          end
      end

      --log_print(count);
      if count >= length then
          return x - count / 2, minY + (maxY - minY) / 2;
      end
  end

  return 0,0;
end

function deepcompare(t1,t2,ignore_mt)
  local ty1 = type(t1)
  local ty2 = type(t2)
  if ty1 ~= ty2 then return false end
  -- non-table types can be directly compared
  if ty1 ~= 'table' and ty2 ~= 'table' then return t1 == t2 end
  -- as well as tables which have the metamethod __eq
  local mt = getmetatable(t1)
  if not ignore_mt and mt and mt.__eq then return t1 == t2 end
  for k1,v1 in pairs(t1) do
  local v2 = t2[k1]
  if v2 == nil or not deepcompare(v1,v2) then return false end
  end
  for k2,v2 in pairs(t2) do
  local v1 = t1[k2]
  if v1 == nil or not deepcompare(v1,v2) then return false end
  end
  return true
  end