-- ------------------------ --
-- Math Functions
-- ------------------------ --
local function round(number)
    return math.ceil(number-0.5)
end

local function map(value, min1, max1)
    local size = max1 - min1
    if value < min1 then
        local val2 = value + size
        value = map(val2, min1, max1)
    elseif value > max1 then
        local val2 = value - size
        value = map(val2, min1, max1)
    end
    return value
end

-- ------------------------ --
-- Geoscanner Functions
-- ------------------------ --

function BlockSearch(block,radius)
    local blockList = Scanner.scan(radius)
    local blackList = {}
    if blockList ~= nil then
        for i,v in pairs(blockList) do
            if v.name == block then
                table.insert(blackList,v)
            end
        end
        return blackList
    end
end

-- ------------------------ --
-- Compass Functions
-- ------------------------ --

function CompDraw(r, theta)
    local x = round(r * math.cos(theta))
    local y = round(-r * math.sin(theta))
    term.clear()
    local middle = {round(XSize / 2), round(YSize / 2)}
    paintutils.drawPixel(middle[1]+x,middle[2]+y,colors.red)
    paintutils.drawPixel(middle[1],middle[2],colors.white)
    term.setBackgroundColor(colors.black)
    term.setCursorPos(1,1)
end

function CompTrack(x, y, z)
    Me = Player.getPlayersInRange(1)[1]
    local myData = Player.getPlayerPos(Me)
    local targetPos = {x = myData.x + x, y = myData.y + y, z = myData.z + z}

    -- Calculates 
    local diff = {targetPos.x - myData.x, targetPos.y - myData.y, targetPos.z - myData.z}
    local veckie = {diff[1],diff[3]}
    local distance = (diff[1]^2 + diff[2]^2 + diff[3]^2)^(1/2)
    local absAngle = map(math.atan2(-veckie[2],veckie[1]), -math.pi, math.pi)
    local localAngle = map(math.rad(-myData.yaw) + (3 * math.pi / 2), -math.pi, math.pi)

    local anglediff = absAngle - localAngle
    if anglediff < 0 then
        anglediff = map(anglediff, -math.pi, math.pi)
    end
    return distance, anglediff
end

-- ------------------------ --
-- Runtime
-- ------------------------ --
XSize, YSize = term.getSize()

local lines = {}
for line in io.lines("NetheriteHunt") do
    line = string.gsub(line, "\"", "")
    local stringCheck = "minecraft:ancient_debris"
    table.insert(lines, line)
end

local i = 1
StartTime = (os.time() * 1000)
if peripheral.hasType("back", "geoScanner") then
    Scanner = peripheral.find("geoScanner")
else
    pocket.equipBack()
    Scanner = peripheral.find("geoScanner")
end
local scanTime = Scanner.getOperationCooldown("scanBlocks")

CurrentTime = (os.time() * 1000)
while true do
    ElapsedTime = (os.time() * 1000) - CurrentTime
    CurrentTime = (os.time() * 1000)
    scanTime = scanTime - ElapsedTime

    if scanTime < 0 then
        pocket.equipBack()
    end

    if peripheral.hasType("back", "geoScanner") then
        Scanner = peripheral.find("geoScanner")
        TargetBlocks = BlockSearch(lines[i],8)
        i = (i)%(#lines)+1
        scanTime = Scanner.getOperationCooldown("scanBlocks") * (60/1000)
        pocket.equipBack()
        InitialPosition = {}
    end

    if peripheral.hasType("back", "playerDetector") then
        Player = peripheral.find('playerDetector')
        if next(InitialPosition) == nil then
            Me = Player.getPlayersInRange(1)[1]
            local myData = Player.getPlayerPos(Me)
            InitialPosition = {x = myData.x, y = myData.y, z = myData.z}
        end
        local myData = Player.getPlayerPos(Me)
        CurrentPosition = {x = myData.x, y = myData.y, z = myData.z}
        local minDistance = 100
        if next(TargetBlocks) ~= nil then
            for i,each in pairs(TargetBlocks) do
                RelativePosition = {x = CurrentPosition.x - InitialPosition.x, y = CurrentPosition.y - InitialPosition.y, z = CurrentPosition.z - InitialPosition.z}
                x,y,z = each.x - RelativePosition.x, each.y - RelativePosition.y, each.z - RelativePosition.z
                local distance, angle = CompTrack(x , y, z)
                each.angle = angle
                each.distance = distance
                if each.distance < minDistance then
                    minDistance = each.distance
                    CurrentRecord = i
                end
            end
            CompDraw(4, map(TargetBlocks[CurrentRecord].angle + math.pi/2, -math.pi, math.pi))  
        end
    end
    sleep(0.05)
end

-- --- 
-- Compass Code Not Implemented
-- ---
