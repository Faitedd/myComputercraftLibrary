X = { peripheral.find('inventory') }
for i,v in pairs(X) do
    for i2, v2 in pairs(v) do
        for i3, v3 in pairs(v2) do
            print(i3,v3)
        end
    end
end