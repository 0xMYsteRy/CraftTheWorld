probability = math.random(1,5);
if probability > 4 then
	pos = getEventPosition();
	world = World.new();
	for i=1,5 do
		world:spawn("tf_skeleton", pos.x, pos.y);
	end
end