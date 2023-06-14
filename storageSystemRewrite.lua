function initBarrel()
    max = 0
    barrels = {}
    while peripheral.isPresent("minecraft:barrel_" .. max) == true do
        name = "minecraft:barrel_" .. max
        barrels[max+1] = peripheral.wrap(name)
        barrels[max+1].name = name
        max = max + 1
    end
    print("There are " .. max .. " barrels")
end

itemLog = {}

function itemLogger()
    for i = 1, max do
        table.insert(barrels[i].list)
    end
end