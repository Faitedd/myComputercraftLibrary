Player = peripheral.find('playerDetector')
Me = Player.getPlayersInRange(1)[1]
Target = io.read()
XSize, YSize = term.getSize()
InitialPosition = Player.getPlayerPos(Me)

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

function Track(r, theta)
    local x = round(r * math.cos(theta))
    local y = round(-r * math.sin(theta))
    term.clear()
    local middle = {round(XSize / 2), round(YSize / 2)}
    paintutils.drawPixel(middle[1]+x,middle[2]+y,colors.red)
    paintutils.drawPixel(middle[1],middle[2],colors.white)
    term.setBackgroundColor(colors.black)
end

while true do
    local myData = Player.getPlayerPos(Me)
    -- local theirData = Player.getPlayerPos(Target)
    local theirData = InitialPosition

    local diff = {theirData.x - myData.x, theirData.y - myData.y, theirData.z - myData.z}
    local veckie = {diff[1],diff[3]}

    local distance = (diff[1]^2 + diff[2]^2 + diff[3]^2)^(1/2)
    local anglier = map(math.atan2(-veckie[2],veckie[1]), -math.pi, math.pi)

    local myangle = map(math.rad(-myData.yaw) + (3 * math.pi / 2), -math.pi, math.pi)

    local anglediff = anglier - myangle
    if anglediff < 0 then
        anglediff = map(anglediff, -math.pi, math.pi)
    end
    Track(4, map(anglediff + math.pi/2, -math.pi, math.pi))
    print(map(anglediff + math.pi/2, -math.pi, math.pi))
    print("Position vector:" .. anglier .. "\n Local angle:".. myangle)
end