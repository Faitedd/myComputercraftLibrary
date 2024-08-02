Scanner = peripheral.find("geoScanner")
XCur = 0
YCur = 0
ZCur = 0
Turns = 0

-- function removekey(table, key)
--     local element = table[key]
--     table[key] = nil
--     return element
-- end 

function Scanley(block,radius)
    local blockList = Scanner.scan(radius)
    for i,v in pairs(blockList) do
        if v.name ~= block then
            table.removekey(BlockList,i)
        end
    end
    return blockList
end
 
function LookFor(block, radius)
    GoodBlocks = Scanley(block, radius)
    for i,v in pairs(GoodBlocks) do
        return v.x, v.y, v.z
    end
end

function TrackBlock(block, radius)
    GoodBlocks = Scanley(block, radius)
	if next(GoodBlocks) ~= nil then
		for i,v in pairs(GoodBlocks) do
			print("It's at " .. "x: " .. v.x .. " y: " .. v.y .. " z: " .. v.z)
		end
	end
end

while true do
TrackBlock("minecraft:ancient_debris",10)
end