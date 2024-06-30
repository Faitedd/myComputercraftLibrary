function initBarrel()
    Barrels = { peripheral.find('inventory') }
end

ItemLog = {}

function itemLogger()
    for i,v in pairs(Barrels) do
        table.insert(ItemLog,v.list())
    end
end

initBarrel()
itemLogger()

for i,v in pairs(ItemLog) do
    print(i, v)
    thisThing = table.unpack(v)
end