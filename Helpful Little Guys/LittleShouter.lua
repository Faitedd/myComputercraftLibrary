 -- Note: Chunk Controller is in left hand, rotate device in right hand for other uses:

Inventory = {

}

function Init()
    EquipmentList = {}
    local file = io.open("EquipmentList.txt")
    if file then
        for line in file:lines() do
            EquipmentList.append(line)
        end 
    end
end

function InventoryRead()
    local tempTable = {}
    for i = 1,16 do
        tempTable.append(turtle.getItemDetail(i))
    end
    Inventory.data = tempTable
end

function FindEquipment()
    for each in Inventory.data do
        print(each.name)
    end
end