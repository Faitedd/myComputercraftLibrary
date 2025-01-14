rst = peripheral.find('rsBridge')
chat = peripheral.find('chatBox')
inv = { peripheral.find('inventoryManager') }
chest = { peripheral.find('minecraft:chest') }
barrels = peripheral.find('minecraft:barrel')
AllIt = rst.listItems()

function sanitize(str)
    if type(str) ~= "string" then error("str not passed to sanitize") end
    str = string.lower(str)
    str = string.gsub(str, "[^a-zA-Z0-9]", "")
    return str
end

function query(searchString)
    for i,item in pairs(AllIt) do
        local test1 = string.find(item.displayName, searchString)
        local test2 = string.find(item.name, searchString)
        if (test1 or test2) then
            return item
        end
        -- item = {amount, displayName, fingerprint, isCraftable, name, tags}
    end
end

function names()
    namie = {}
    for i,invie in pairs(inv) do
        table.insert(namie, invie.getOwner())
    end
    return namie
end

print(query("iron").name)
while true do
    event, arg1, arg2, arg3, arg4 = os.pullEvent()
    if event == "chat" then
        username = arg1
        message = arg2
        uuid = arg3
        isHidden = arg4
package    end
end
