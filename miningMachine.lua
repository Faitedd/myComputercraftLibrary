local a = 0
local b = 0
local fuelNeed
local inventory_full
local item
local turns = 0
local pos = {}
local xCur = 0
local yCur = 0
local xNew = 0
local yNew = 0
local xOld = 0
local yOld = 0
local turnsStorage

function track(xNew, yNew)
	
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

	if (xNew - xCur) > 0 
	then
		while (xCur ~= xNew)
		do
		xCur = xCur + 1
		turtle.dig()
		turtle.forward()
		print("east")
		end
	end
	
	turtle.turnRight()

	if (yNew - yCur) > 0
	then
		while (yCur ~= yNew)
		do
		yCur = yCur + 1
		turtle.dig()
		turtle.forward()
		print("north")
		end
	end
	
	turtle.turnRight()

	if (xNew - xCur) < 0
	then
		while (xCur ~= xNew)
		do
		xCur = xCur - 1
		turtle.dig()
		turtle.forward()
		print("west")
		end
	end
	
	turtle.turnRight()

	if (yNew - yCur) < 0
	then
		while (yCur ~= yNew)
		do
		yCur = yCur - 1
		turtle.dig()
		turtle.forward()
		print("south")
		end
	end
	
	turtle.turnRight()

	yCur = yNew
	xCur = xNew
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

local function Inventory()
	inventory_full = turtle.getItemCount(16)
	if inventory_full > 0
	then
		MyTurtle.WasteDisposal({"forge:cobblestone","forge:stone","forge:netherrack"})
	end
	inventory_full = turtle.getItemCount(16)
	if inventory_full > 0
	then
		turnsStorage = turns
		xOld = xCur
		yOld = yCur
		print("")		
		track(0,0)
		for i = 2,16 
		do
			turtle.select(i)
			if turtle.getItemCount() > 0
			then
			    if turtle.getFuelLevel() < 1000 
        		then
            		fuelNeed = true
        		else
            		fuelNeed = false
        		end
			    item = turtle.getItemDetail()
			    if item.name == "minecraft:coal" and fuelNeed == true
				then
					print("This is coal")
					turtle.refuel(64)
				end
			end
			turtle.dropDown()
		end
		track(xOld,yOld)
		
		if turns == -1 then 
			turtle.turnRight() 
			turns = 1
		end

		if turns == -2 then
			turtle.turnLeft()
			turtle.turnLeft()
			turns = 2
		end

		if turns == -3 then
			turtle.turnLeft()
			turns = 3
		end

		turtle.select(1)
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

MyTurtle = {}

ObjectList = {}
BlockData = {Pos = {x = 0,y = 0,z = 0},name = "fillerBlock"}
TurtleInfo = {Pos = {x = 0,y = 0,z = 0}, Rot = 0}
TurtleMovement = {}

-- Necessary Math Function Do Not Touch
function Round(num)
    local mult = 10^(1 or 0)
    return math.floor(num * mult + 0.5) / mult
end

function dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
 end 
-- Necessary Math Function Do Not Touch

TurtleMove = {} -- Definitions for TurtleMove

function TurtleMove.forward()
    turtle.dig()
    turtle.forward()
    TurtleInfo.Pos.x,TurtleInfo.Pos.y = TurtleInfo.Pos.x + Round(math.cos(TurtleInfo.Rot)), TurtleInfo.Pos.y + Round(math.sin(TurtleInfo.Rot))
    table.insert(TurtleMovement,'f')
-- x and y are changed with respect to the angle which considers x to be forward and y to be side to side
end

function TurtleMove.lessforward()
    turtle.dig()
    turtle.forward()
    TurtleInfo.Pos.x,TurtleInfo.Pos.y = TurtleInfo.Pos.x + Round(math.cos(TurtleInfo.Rot)), TurtleInfo.Pos.y + Round(math.sin(TurtleInfo.Rot))
-- x and y are changed with respect to the angle which considers x to be forward and y to be side to side
end

function TurtleMove.backward()
    turtle.turnLeft()
    turtle.turnLeft()
    turtle.dig()
    turtle.forward()
    turtle.turnLeft()
    turtle.turnLeft()
    TurtleInfo.Pos.x,TurtleInfo.Pos.y = TurtleInfo.Pos.x + Round(math.cos(TurtleInfo.Rot)), TurtleInfo.Pos.y + Round(math.sin(TurtleInfo.Rot))
    table.insert(TurtleMovement,'-f')
end

function TurtleMove.lessbackward()
    turtle.turnLeft()
    turtle.turnLeft()
    turtle.dig()
    turtle.forward()
    turtle.turnLeft()
    turtle.turnLeft()
    TurtleInfo.Pos.x,TurtleInfo.Pos.y = TurtleInfo.Pos.x + Round(math.cos(TurtleInfo.Rot)), TurtleInfo.Pos.y + Round(math.sin(TurtleInfo.Rot))
end

function TurtleMove.left()
    turtle.turnLeft()
    turtle.dig()
    turtle.forward()
    turtle.turnLeft()
    TurtleInfo.Pos.x,TurtleInfo.Pos.y = TurtleInfo.Pos.x + Round(math.cos(TurtleInfo.Rot)), TurtleInfo.Pos.y + Round(math.sin(TurtleInfo.Rot))
end


function TurtleMove.right()
    turtle.turnRight()
    turtle.dig()
    turtle.forward()
    turtle.turnLeft()
    TurtleInfo.Pos.x,TurtleInfo.Pos.y = TurtleInfo.Pos.x + Round(math.cos(TurtleInfo.Rot)), TurtleInfo.Pos.y + Round(math.sin(TurtleInfo.Rot))
end

function TurtleMove.up()
    turtle.digUp()
    turtle.up()
    TurtleInfo.Pos.z = TurtleInfo.Pos.z + 1
    table.insert(TurtleMovement,'u')
end

function TurtleMove.lessup()
    turtle.digUp()
    turtle.up()
    TurtleInfo.Pos.z = TurtleInfo.Pos.z + 1
end

function TurtleMove.lessdown()
    turtle.digDown()
    turtle.down()
    TurtleInfo.Pos.z = TurtleInfo.Pos.z - 1
end


function TurtleMove.down()
    turtle.digDown()
    turtle.down()
    TurtleInfo.Pos.z = TurtleInfo.Pos.z - 1
    table.insert(TurtleMovement,'-u')
end

function TurtleMove.turnRight()
    turtle.turnRight()
    TurtleInfo.Rot = TurtleInfo.Rot + math.rad(90)
    if TurtleInfo.Rot == math.rad(360)
    then
        TurtleInfo.Rot = 0
    end
    table.insert(TurtleMovement,'l')
end

function TurtleMove.lessturnRight()
    turtle.turnRight()
    TurtleInfo.Rot = TurtleInfo.Rot + math.rad(90)
    if TurtleInfo.Rot == math.rad(360)
    then
        TurtleInfo.Rot = 0
    end
end

function TurtleMove.turnLeft()
    turtle.turnLeft()
    TurtleInfo.Rot = TurtleInfo.Rot + math.rad(90)
    if TurtleInfo.Rot == math.rad(360)
    then
        TurtleInfo.Rot = 0
    end
    table.insert(TurtleMovement,'-l')
end

function TurtleMove.lessturnLeft()
    turtle.turnLeft()
    TurtleInfo.Rot = TurtleInfo.Rot + math.rad(90)
    if TurtleInfo.Rot == math.rad(360)
    then
        TurtleInfo.Rot = 0
    end
end

function TurtleMove.align()
    while(TurtleInfo.Rot ~= 0)
    do
        print(TurtleInfo.Rot)
        TurtleMove.turnRight()
    end
end

function TurtleMove.reverse()
    if TurtleMovement[#TurtleMovement] == 'f' then
        TurtleMove.lessbackward()
    elseif TurtleMovement[#TurtleMovement] == '-f' then
        TurtleMove.lessforward()
    elseif TurtleMovement[#TurtleMovement] == 'u' then
        TurtleMove.lessdown()
    elseif TurtleMovement[#TurtleMovement] == '-u' then
        TurtleMove.lessup()
    elseif TurtleMovement[#TurtleMovement] == 'l' then
        TurtleMove.lessturnLeft()
    elseif TurtleMovement[#TurtleMovement] == '-l' then
        TurtleMove.lessturnRight()
    end
    table.remove(TurtleMovement,#TurtleMovement)
end


function MyTurtle.Search(blockInfo,tag)
    if type(tag) == "string" then
        for i,v in pairs(blockInfo.tags) do
            if ((i == tag) and (v == true)) then
                return(true)
            end
        end
    elseif type(tag) == "table" then
        for i2,v2 in pairs(tag) do
            local x = MyTurtle.Search(blockInfo,v2)
            if x == true then return(true) end
        end
    end
end


function MyTurtle.hunt(tag)
    local a, blockInfo = turtle.inspect()
    if a == true then
        return(MyTurtle.Search(blockInfo, tag))
    end
end

function MyTurtle.huntUp(tag)
    local a, blockInfo = turtle.inspectUp()
    if a == true then
        return(MyTurtle.Search(blockInfo, tag))
    end
end

function MyTurtle.huntDown(tag)
    local a, blockInfo = turtle.inspectDown()
    if a == true then
        return(MyTurtle.Search(blockInfo, tag)) 
    end
end

function MyTurtle.gatherOre(tag)
    for i = 1,6 do
        if i < 5 then
            local x = MyTurtle.hunt(tag)
            if x == true then
                TurtleMove.forward()
                print(TurtleMovement[#TurtleMovement])
                MyTurtle.gatherOre(tag)
            end
            TurtleMove.turnRight()
            if i == 4 then
                for i = 1,4 do
                    table.remove(TurtleMovement,#TurtleMovement)
                end
            end
        elseif i == 5 then
            local x = MyTurtle.huntUp(tag)
            if x == true then
                TurtleMove.up()
                print(TurtleMovement[#TurtleMovement])
                MyTurtle.gatherOre(tag)
            end
        elseif i == 6 then
            local x = MyTurtle.huntDown(tag)
            if x == true then
                TurtleMove.down()
                print(TurtleMovement[#TurtleMovement])
                MyTurtle.gatherOre(tag)
            end
        end
    end
    TurtleMove.reverse()
end

function MyTurtle.WasteDisposal(tag)
	for i = 1,16 do
        turtle.select(i)
		local a = turtle.getItemDetail(i,true)
        if a ~= nil then
            local x = MyTurtle.Search(a,tag)
            if x == true then
                turtle.dropDown()
            end
        end
	end
    turtle.select(1)
end

while true do
	b = b + 1
	if b == 2
	then
		b = 0
		a = a + 1
	end

	for i = 1,a,1
	do
		turtle.dig()
		GravelCheck()
		LavaCheck()
		turtle.forward()
			if	turns == 0 then xCur = xCur + 1 end
			if	turns == 1 then yCur = yCur + 1 end
			if	turns == 2 then xCur = xCur - 1 end
			if	turns == 3 then yCur = yCur - 1 end
		print("x: " .. xCur .. "\ny: " .. yCur .. "\n")
        MyTurtle.gatherOre("forge:ores")
		turtle.digDown()
		turtle.digUp()
		Inventory()

	end

	turtle.turnRight()
	turns = turns + 1
	if turns == 4 then turns = 0 end
end