Player = peripheral.find('playerDetector')
Me = Player.getPlayersInRange(1)[1]
Target = io.read()
XSize, YSize = term.getSize()

local function round(number)
    return math.ceil(number-0.5)
end

function Track(r, theta)
    local x = round(r * math.cos(theta))
    local y = round(r * math.sin(theta))
    term.clear()
    local middle = {XSize / 2, YSize / 2}
    paintutils.drawPixel(middle[1]+x,middle[2]+y,colors.red)
    paintutils.drawPixel(middle[1],middle[2],colors.white)
    term.setBackgroundColor(colors.black)
end

while true do
    local myData = Player.getPlayerPos(Me)
    local theirData = Player.getPlayerPos(Target)
    local theirPos = {theirData.x, theirData.y, theirData.z}
    local myPos = {myData.x,myData.y,myData.z}
    local diff = {}
    local diff2 = {}
    for i=1,3 do
        diff[i] = theirPos[i] - myPos[i] + 0.1
    end
    local mag = (diff[3]^2 + diff[1]^2)^(1/2)
    diff2[3] = diff[3] / mag
    diff2[1] = diff[1] / mag
    local theta = math.atan2(diff2[3],diff2[1]) - (1 * math.pi / 2)
    local result = theta + math.rad(myData.yaw)

    local r = 3
    local smallestSize = XSize
    local x = round(r * diff2[1])
    local y = round(r * diff2[3])
    local x2 = round(r * math.cos(result))
    local y2 = round(r * math.sin(result))
    term.clear()
    local middle = {XSize / 2, YSize / 2}
    paintutils.drawPixel(middle[1]-x2,middle[2]+y2,colors.red)
    paintutils.drawPixel(middle[1],middle[2],colors.white)
    term.setBackgroundColor(colors.black)

    -- Track(round(smallestSize/3), theta)
    term.setCursorPos(1,YSize - 1)
    term.write("Angle: " .. result .. "," .. x .. "," .. x2 .. "," .. y .. "," .. y2)
    term.setCursorPos(1,YSize)
    term.write("Distance: " .. diff[1] .. "," .. diff[3])
end