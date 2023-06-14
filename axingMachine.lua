ObjectList = {}
BlockData = {Pos = {x = 0,y = 0,z = 0},name = "fillerBlock"}
TurtleInfo = {Pos = {x = 0,y = 0,z = 0}, Rot = 0}

-- Necessary Math Function Do Not Touch
function Round(num)
    local mult = 10^(1 or 0)
    return math.floor(num * mult + 0.5) / mult
end
-- Necessary Math Function Do Not Touch

TurtleMove = {} -- Definitions for TurtleMove

function TurtleMove.forward()
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
    TurtleInfo.Pos.z = TurtleInfo.Pos.z + 1
end

function TurtleMove.down()
    turtle.digDown()
    turtle.down()
    TurtleInfo.Pos.z = TurtleInfo.Pos.z - 1
end

function TurtleMove.turnRight()
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
end

function TurtleMove.align()
    while(TurtleInfo.Rot ~= 0)
    do
        print(TurtleInfo.Rot)
        TurtleMove.turnRight()
    end
end
-- End of Definitions for TurtleMove

-- Definitions for myTurtle

myTurtle = {}

function myTurtle.getPos()
    local x,y,z
    x = TurtleInfo.Pos.x
    y = TurtleInfo.Pos.y
    z = TurtleInfo.Pos.z
    return({x,y,z})
end

function myTurtle.logg(x,y,z,block)
    tempObject = BlockData
    tempObject.Pos.x = x
    tempObject.Pos.y = y
    tempObject.Pos.z = z
    tempObject.name = block
    table.insert(ObjectList, tempObject)
end

function myTurtle.inspect(block)
    a,b = turtle.inspect(block)
    if a == true then
        if b.name == block then
            local x, y, z = TurtleInfo.Pos.x + Round(math.cos(TurtleInfo.Rot)), TurtleInfo.Pos.y + Round(math.sin(TurtleInfo.Rot)), TurtleInfo.Pos.z
            myTurtle.logg(x,y,z,block)
        end
    end
end

function turtleLook()
    
end

myTurtle.inspect("minecraft:grass_block")