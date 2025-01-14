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

function Search(blockInfo,tag)
    if type(tag) == "string" then
        for i,v in pairs(blockInfo.tags) do
            if ((i == tag) and (v == true)) then
                return(true)
            end
        end
    elseif type(tag) == "table" then
        for i2,v2 in pairs(tag) do
            local x = Search(blockInfo,v2)
            if x == true then return(true) end
        end
    end
end

function HuntId(name)
    local a, blockInfo = turtle.inspect()
    if a == true then
        return(SearchId(blockInfo, name))
    end
end

function HuntUpId(name)
    local a, blockInfo = turtle.inspectUp()
    if a == true then
        return(SearchId(blockInfo, name))
    end
end

function HuntDownId(name)
    local a, blockInfo = turtle.inspectDown()
    if a == true then
        return(SearchId(blockInfo, name)) 
    end
end

function SearchId(blockInfo,name)
    if blockInfo.name == name then
        return(true)
    end
end

function Hunt(tag)
    local a, blockInfo = turtle.inspect()
    if a == true then
        return(Search(blockInfo, tag))
    end
end

function HuntUp(tag)
    local a, blockInfo = turtle.inspectUp()
    if a == true then
        return(Search(blockInfo, tag))
    end
end

function HuntDown(tag)
    local a, blockInfo = turtle.inspectDown()
    if a == true then
        return(Search(blockInfo, tag)) 
    end
end


function WasteDisposal(tag)
	for i = 1,16 do
        turtle.select(i)
		local a = turtle.getItemDetail(i,true)
        if a ~= nil then
            local x = Search(a,tag)
            if x == true then
                turtle.dropDown()
            end
        end
	end
end

function GatherOreId(name)
    for i = 1,6 do
        if i < 5 then
            local x = HuntId(name)
            if x == true then
                TurtleMove.forward()
                print(TurtleMovement[#TurtleMovement])
                GatherOreId(name)
            end
            TurtleMove.turnRight()
            if i == 4 then
                for i = 1,4 do
                    table.remove(TurtleMovement,#TurtleMovement)
                end
            end
        elseif i == 5 then
            local x = HuntUpId(name)
            if x == true then
                TurtleMove.up()
                print(TurtleMovement[#TurtleMovement])
                GatherOreId(name)
            end
        elseif i == 6 then
            local x = HuntDownId(name)
            if x == true then
                TurtleMove.down()
                print(TurtleMovement[#TurtleMovement])
                GatherOreId(name)
            end
        end
    end
    print("I am trying to reverse")
    TurtleMove.reverse()
end

function GatherOre(tag)
    for i = 1,6 do
        if i < 5 then
            local x = Hunt(tag)
            if x == true then
                TurtleMove.forward()
                print(TurtleMovement[#TurtleMovement])
                GatherOre(tag)
            end
            TurtleMove.turnRight()
            if i == 4 then
                for i = 1,4 do
                    table.remove(TurtleMovement,#TurtleMovement)
                end
            end
        elseif i == 5 then
            local x = HuntUp(tag)
            if x == true then
                TurtleMove.up()
                print(TurtleMovement[#TurtleMovement])
                GatherOre(tag)
            end
        elseif i == 6 then
            local x = HuntDown(tag)
            if x == true then
                TurtleMove.down()
                print(TurtleMovement[#TurtleMovement])
                GatherOre(tag)
            end
        end
    end
    print("I am trying to reverse")
    TurtleMove.reverse()
end


function GatherLiquid(tag)
    for i = 1,6 do
        if i < 5 then
            local x = Hunt(tag)
            if x == true then
                turtle.place()
                turtle.refuel(1)
                TurtleMove.forward()
                print(TurtleMovement[#TurtleMovement])
                GatherOre(tag)
            end
            TurtleMove.turnRight()
            if i == 4 then
                for i = 1,4 do
                    table.remove(TurtleMovement,#TurtleMovement)
                end
            end
        elseif i == 5 then
            local x = HuntUp(tag)
            if x == true then
                turtle.placeUp()
                turtle.refuel(1)
                TurtleMove.up()
                print(TurtleMovement[#TurtleMovement])
                GatherOre(tag)
            end
        elseif i == 6 then
            local x = HuntDown(tag)
            if x == true then
                turtle.placeDown()
                turtle.refuel(1)
                TurtleMove.down()
                print(TurtleMovement[#TurtleMovement])
                GatherOre(tag)
            end
        end
    end
end