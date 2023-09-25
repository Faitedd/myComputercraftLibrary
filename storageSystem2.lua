-- Startup function

function initBarrel()
    j = 1
    barrels = {}
    local periList = peripheral.getNames()
    for i = 1, #periList do
        print("I have a "..peripheral.getType(periList[i]).." attached as \""..periList[i].."\".")
        name = periList[i]
        if peripheral.getType(name) == "minecraft:barrel" or peripheral.getType(name) == "ironchests:iron_chest" or peripheral.getType(name) == "ironchests:gold_chest" or peripheral.getType(name) == "ironchests:diamond_chest" or peripheral.getType(name) == "ironchests:netherite_chest" then
            barrels[j] = peripheral.wrap(name)
            barrels[j].name = name
            j = j + 1
        end
        if peripheral.getType(name) == "minecraft:chest" then
            Chest = peripheral.wrap(name)
            Chest.name = getmetatable(Chest).name
        end
    end
    print("There are " .. #barrels .. " barrels")
end

-- String Utilities

function remove_blanks (s)
    local b = string.find(s, ' ')
    while b do
      s = string.sub(s, 1, b-1) .. string.sub(s, b+1)
      b = string.find(s, ' ')
    end
    return s
end

function remove_spacer (s)
    local b = string.find(s, '_')
    while b do
      s = string.sub(s, 1, b-1) .. string.sub(s, b+1)
      b = string.find(s, ' _')
    end
    return s
end

function stringFix(s)
    s = string.lower(s)
    s = remove_blanks(s)
    s = remove_spacer(s)
    return(s)
end

function compareString(str1,str2)
    str1 = stringFix(str1)
    str2 = stringFix(str2)
    x = string.find(str1, str2)
    if x ~= nil then
        return(true)
    else
        return(false)
    end
end

function makeTextLookGood(s)
    local b = string.find(s, '_')
    while b do
      s = string.sub(s, 1, b-1) .. " " .. string.sub(s, b+1)
      b = string.find(s, '_')
    end
    b = string.find(s, ':')
    if b ~= nil then
        s = string.sub(s,b + 1)
    end
    return(s)
end

function pullOutNumbers(s)
    finalstring = ''
    stringtable = {}
    numbers = {'0','1','2','3','4','5','6','7','8','9'}
    for i,cha in ipairs(numbers) do
        local b = string.find(s, cha)
        while b do
            s = string.sub(s, 1, b-1) .. " " .. string.sub(s, b+1)
            b = string.find(s, '_')
            b = string.find(s, cha)
        end
    end
    return(remove_blanks(s))
end

function killLetters(s)
    finalstring = ''
    stringtable = {}
    numbers = {'0','1','2','3','4','5','6','7','8','9'}
    for i,cha in ipairs(numbers) do
        local b = string.find(s, cha)
        if b ~= nil then
            stringtable[b] = cha
        end
    end
    for i,v in pairs(stringtable) do
        finalstring = finalstring .. v
    end
    return(finalstring)
end

-- Pump Functions

function pump(Sbarrel, Tbarrel)
    print("Pushing from \n" .. Sbarrel.name .. " to \n" .. Tbarrel.name .. "\n")
    for i = 1, Sbarrel.size() do
        Sbarrel.pushItems(Tbarrel.name,i)
    end
end

function wavepump()
    for i = #barrels - 1, 1, -1 do
        pump(barrels[i],barrels[i+1])
    end
end

-- Find Item Functions

function findThing(string)
    for i = 1, #barrels do
        for slot, item in pairs(barrels[i].list()) do
            if item.name == string then
                return barrels[i], slot
            end
        end
    end
    return(false)
end

function findFuzzyThing(str)
    for i = 1, #barrels do
        for slot, item in pairs(barrels[i].list()) do
            if compareString(item.name, str) == true then
                return barrels[i], slot
            end
        end
    end
    return(false)
end

function findFuzzyList(str)
    local myList = {}
    for i = 1, #barrels do
        for slot, item in pairs(barrels[i].list()) do
            if compareString(item.name, str) == true then
                table.insert(myList,{item.name,barrels[i].name,slot,item.count})
            end
        end
    end
    return(myList)
end

--- Give To Player functions

function giveMeThing(barrel,slot)
    barrel.pushItems(Chest.name,slot)
end

function giveMeThisThing(string)
    this,that = findThing(string)
    if this ~= false then
        giveMeThing(this, that)
        return(true)
    end
    return(false)
end

function handMeThisThing(str)
    this,that = findFuzzyThing(str)
    if this ~= false then
        giveMeThing(this, that)
        return(true)
    end
    return(false)
end

-- Search table

function search(str)
    local lister = findFuzzyList(str)
    for i = 1, #lister do
        if lister[i] == 0 then break end
        local element  = lister[i]
        local itemName = makeTextLookGood(element[1])
        local barrelName =  makeTextLookGood(element[2])
        local slot =  makeTextLookGood(element[3])
        local itemCount = makeTextLookGood(element[4])
        print ("\n" .. itemCount .. " " .. itemName .. '\n ' .. barrelName .. ', slot: ' .. slot)
        if i % 6 == 0 then
            x = os.pullEvent('key')
        end
    end
end

-- Rewrite Part 1


-- Translates events

function eventChecker()
    if event == "key"
    then
        keyName = keys.getName(arg1)
        if keys.getName(arg1) == "up" and preask ~= nil then 
            print(preask)
            ask = preask
        else
            ask = io.read()
        end
        preask = ask
        cutask = string.lower(string.sub(ask,1,7))
        if cutask == "give me" then
            req = string.lower(string.sub(ask,9))
            print(req .. " has been requested")
            x = giveMeThisThing(req)
            if x == false then
                print("Unable to be sent")
            elseif x == true then
                print("It has been sent")
            else 
                print("You bungled hard")
            end
        end
        if cutask == "hand me" then
            req = string.lower(string.sub(ask,9))
            print(req .. " has been requested")
            x = handMeThisThing(req)
            if x == false then
                print("Unable to be sent")
            elseif x == true then
                print("It has been sent")
            else 
                print("You bungled hard")
            end
        end
        if cutask == "pump" then
            pump(chest,barrels[1])
            wavepump()
        end
        if cutask == "search " then
            req = string.lower(string.sub(ask,8))
            print(req .. " being searched for")
            search(req)
        end
        if cutask == "exit" then
            return('exit')
        end
    end
    if event == "chat" then
        username = arg1
        message = arg2
        uuid = arg3
        isHidden = arg4
        print("<" .. username .. "> " .. message)
        if username == 'esgamo' then
            message = string.lower(message)
            cutask = string.lower(string.sub(message,1,8))
            if cutask == "give me " then
                req = string.lower(string.sub(message,9))
                x = giveMeThisThing(req)
                if x == false then
                    print("Unable to be sent")
                elseif x == true then
                    print("It has been sent")
                else 
                    print("You bungled hard")
                end
                manager.addItemToPlayer("left",64)
            end
            if cutask == "hand me " then
                req = string.lower(string.sub(message,9))
                print(req .. "has been requested")
                x = handMeThisThing(req)
                if x == false then
                    print("Unable to be sent")
                elseif x == true then
                    print("It has been sent")
                else 
                    print("You bungled hard")
                end
                manager.addItemToPlayer("left",64)
            end
            if cutask == "toss me " then
                req = string.lower(string.sub(message,9))
                count = tonumber(killLetters(req))
                print('req is ' .. req)
                print('count is ' .. count)
                req = pullOutNumbers(req)
                print(req .. " has been requested")
                x = handMeThisThing(req)
                if x == false then
                    print("Unable to be sent")
                elseif x == true then
                    print("It has been sent")
                else 
                    print("You bungled hard")
                end
                manager.addItemToPlayer("left",count)
                pump(chest,barrels[1])
            end
            if message == "take it" then
                manager.removeItemFromPlayer("left",64,nil,manager.getItemInHand().name)
                pump(chest,barrels[1])
            end
            if message == "take it all" then
                for i = 1,9 do
                manager.removeItemFromPlayer("left",64,i)
                end
                pump(chest,barrels[1])
            end
        end
    end
end
--

initBarrel()
manager = peripheral.find("inventoryManager")
chest = peripheral.find("minecraft:chest")
chest.name = "funny chest"
while true do
    event, arg1, arg2, arg3, arg4 = os.pullEvent()
    x = eventChecker()
    if x == 'exit'
    then
        break
    end
end