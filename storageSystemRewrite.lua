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
        if elementIn(list, v) then
            return true
        end
    end
end

function buildContainer(data)
    local thisContainer = {}
    thisContainer.data = data
    thisContainer.storage = {}
    thisContainer.label = peripheral.getName(data)
    local type2 = "0"
    if elementIn({peripheral.getType(data)},"create:item_vault")
    then
        type2 = "LargeStorage"
    elseif elementIn({peripheral.getType(data)},"minecraft:chest")
    then
        type2 = "InteractChest"
    else
        error("Unknown Peripheral: " .. print(unpack({peripheral.getType(data)})))
    end
    thisContainer.type = type2
    return thisContainer
end

function itemLogger()
    for i,v in pairs(Barrels) do
        local container = buildContainer(v)
        for i2,v2 in pairs(v.list()) do
            print("This is:", i2, v2)
            local item = buildItem(v2,container,i2)
            table.insert(ItemLog, item)
            table.insert(container.storage, item)
        end
        table.insert(ContainerLog,container)
    end
end

function searchForItem(name)
    for i,container in pairs(ContainerLog) do
        for i2, item in pairs(container.storage) do
            if item.label == name then
                print(item.data.count, item.source.label)
            end
        end
    end
end

initBarrel()
itemLogger()
searchForItem("minecraft:iron_ingot")