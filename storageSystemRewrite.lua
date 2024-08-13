function initBarrel()
    Barrels = { peripheral.find('inventory') }
end

ItemLog = {}
ContainerLog = {}

function buildItem(data, source, slot)
    local thisItem = {}
    thisItem.data = data
    thisItem.source = source
    thisItem.label = data.name
    thisItem.slot = slot
    return thisItem
end

function elementIn(list, value)
    for i,v in pairs(list) do
        if v == value then
            return true
        end
    end
end

function elementIn2(list, listOfValues)
    for i,v in pairs(listOfValues) do
        return elementIn()
    end
end

function buildContainer(data)
    local thisItem = {}
    thisItem.data = data
    thisItem.storage = {}
    thisItem.label = peripheral.getName(data)
    local type2 = "0"
    if elementIn(peripheral.getType(data),"create:item_vault")
    then
        type2 = "LargeStorage"
    else
        error("Unknown Peripheral")
    end
    thisItem.type = type2
end

function itemLogger()
    for i,v in pairs(Barrels) do
        local roger = buildContainer()
        table.insert(ContainerLog,roger)
        for i2,v2 in pairs(v.list()) do
            print(i2, v2)
            table.insert(ItemLog,buildItem(v2,peripheral.getName(v)),i2)
        end
    end
end

function searchForItem(name)
    for i,v in pairs(ContainerLog) do
    
    end
end

initBarrel()
itemLogger()