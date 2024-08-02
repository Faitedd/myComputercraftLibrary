Scanner = peripheral.find("geoScanner")
XCur = 0
YCur = 0
ZCur = 0
Turns = 0

function table.removekey(table, key)
    local element = table[key]
    table[key] = nil
    return element
end 

function Scanley(block,radius)
    BlockList = Scanner.scan(radius)
    for i,v in pairs(BlockList) do
        if v.name ~= block then
            table.removekey(BlockList,i)
        end
    end
    return(BlockList)
end
 
function LookFor(block, radius)
    GoodBlocks = Scanley(block, radius)
    for i,v in pairs(GoodBlocks) do
        return v.x, v.y, v.z
    end
end

local function LavaCheck()
	BlockCheck, BlockData = turtle.inspect()
	if BlockData.name == "minecraft:lava"
	then
		turtle.select(1)
		turtle.place()
		turtle.refuel(1)
	end
	
		BlockCheck, BlockData = turtle.inspectDown()
	if BlockData.name == "minecraft:lava"
	then
		turtle.select(1)
		turtle.placeDown()
		turtle.refuel(1)
	end
	
		BlockCheck, BlockData = turtle.inspectUp()
	if BlockData.name == "minecraft:lava"
	then
		turtle.select(1)
		turtle.placeUp()
		turtle.refuel(1)
	end
end

local function GravelCheck()
	BlockCheck, BlockData = turtle.inspect()
	while BlockData.name == "minecraft:gravel" or BlockData.name == "minecraft:sand"
	do
		BlockCheck, BlockData = turtle.inspect()
		turtle.dig()
		sleep(3)	
	end
end

function Track(xNew, yNew, zNew)
	
	if Turns == 1 then 
	turtle.turnLeft() 
	Turns = -1
	end

	if Turns == 2 then
	turtle.turnLeft()
	turtle.turnLeft()
	Turns = -2
	end

	if Turns == 3 then
	turtle.turnRight()
	Turns = -3
	end

	if (xNew - XCur) < 0 
	then
		while (XCur ~= xNew)
		do
		XCur = XCur - 1
		turtle.dig()
		turtle.forward()
		LavaCheck()
		GravelCheck()
		end
	end
	
	turtle.turnRight()

	if (zNew - ZCur) > 0
	then
		while (ZCur ~= zNew)
		do
		ZCur = ZCur + 1
		turtle.dig()
		turtle.forward()
		LavaCheck()
		GravelCheck()
		end
	end
	
	turtle.turnRight()

	if (xNew - XCur) > 0
	then
		while (XCur ~= xNew)
		do
		XCur = XCur + 1
		turtle.dig()
		turtle.forward()
		LavaCheck()
		GravelCheck()
		end
	end
	
	turtle.turnRight()

	if (zNew - ZCur) < 0
	then
		while (ZCur ~= zNew)
		do
		ZCur = ZCur - 1
		turtle.dig()
		turtle.forward()
		LavaCheck()
		GravelCheck()
		end
	end
	
    if (yNew - YCur) < 0
    then
        while (YCur ~= yNew)
        do
        YCur = YCur - 1
        turtle.digDown()
        turtle.down()
        end
    end

    if (yNew - YCur) > 0
    then
        while (YCur ~= yNew)
        do
        YCur = YCur + 1
        turtle.digUp()
        turtle.up()
        end
    end

	turtle.turnRight()

	YCur = yNew
	XCur = xNew
    ZCur = zNew
end

function TrackBlock(block, radius)
    GoodBlocks = Scanley(block, radius)
	if next(GoodBlocks) ~= nil then
		for i,v in pairs(GoodBlocks) do
			print("Going to " .. "x: " .. v.x .. " y: " .. v.y .. " z: " .. v.z)
			-- Track(v.x,v.y,v.z)
		end
	end
	-- Track(0,0,0)
end