scanner = peripheral.find("geoScanner")
xCur = 0
yCur = 0
zCur = 0
turns = 0

function table.removekey(table, key)
    local element = table[key]
    table[key] = nil
    return element
end 

function scanley(block,radius)
    blockList = scanner.scan(radius)
    for i,v in pairs(blockList) do
        if v.name ~= block then
            table.removekey(blockList,i)
            print("block removed")
        end
    end
    return(blockList)
end
 
function lookFor(block, radius)
    goodBlocks = scanley(block, radius)
    for i,v in pairs(goodBlocks) do
        return v.x, v.y, v.z
    end
end

local function LavaCheck()
	blockCheck, blockData = turtle.inspect()
	if blockData.name == "minecraft:lava"
	then
		turtle.select(1)
		turtle.place()
		turtle.refuel(1)
	end
	
		blockCheck, blockData = turtle.inspectDown()
	if blockData.name == "minecraft:lava"
	then
		turtle.select(1)
		turtle.placeDown()
		turtle.refuel(1)
	end
	
		blockCheck, blockData = turtle.inspectUp()
	if blockData.name == "minecraft:lava"
	then
		turtle.select(1)
		turtle.placeUp()
		turtle.refuel(1)
	end
end

local function GravelCheck()
	blockCheck, blockData = turtle.inspect()
	while blockData.name == "minecraft:gravel" or blockData.name == "minecraft:sand"
	do
		blockCheck, blockData = turtle.inspect()
		turtle.dig()
		sleep(3)	
	end
end

function track(xNew, yNew, zNew)
	
	if turns == 1 then 
	turtle.turnLeft() 
	turns = -1
	end

	if turns == 2 then
	turtle.turnLeft()
	turtle.turnLeft()
	turns = -2
	end

	if turns == 3 then
	turtle.turnRight()
	turns = -3
	end

	if (xNew - xCur) < 0 
	then
		while (xCur ~= xNew)
		do
		xCur = xCur - 1
		turtle.dig()
		turtle.forward()
		LavaCheck()
		GravelCheck()
		end
	end
	
	turtle.turnRight()

	if (zNew - zCur) > 0
	then
		while (zCur ~= zNew)
		do
		zCur = zCur + 1
		turtle.dig()
		turtle.forward()
		LavaCheck()
		GravelCheck()
		end
	end
	
	turtle.turnRight()

	if (xNew - xCur) > 0
	then
		while (xCur ~= xNew)
		do
		xCur = xCur + 1
		turtle.dig()
		turtle.forward()
		LavaCheck()
		GravelCheck()
		end
	end
	
	turtle.turnRight()

	if (zNew - zCur) < 0
	then
		while (zCur ~= zNew)
		do
		zCur = zCur - 1
		turtle.dig()
		turtle.forward()
		LavaCheck()
		GravelCheck()
		end
	end
	
    if (yNew - yCur) < 0
    then
        while (yCur ~= yNew)
        do
        yCur = yCur - 1
        turtle.digDown()
        turtle.down()
        end
    end

    if (yNew - yCur) > 0
    then
        while (yCur ~= yNew)
        do
        yCur = yCur + 1
        turtle.digUp()
        turtle.up()
        end
    end

	turtle.turnRight()

	yCur = yNew
	xCur = xNew
    zCur = zNew
end

function trackBlock(block, radius)
    goodBlocks = scanley(block, radius)
    for i,v in pairs(goodBlocks) do
		print("Going to " .. "x: " .. v.x .. " y: " .. v.y .. " z: " .. v.z)
        track(v.x,v.y,v.z)
    end
	track(0,0,0)
end