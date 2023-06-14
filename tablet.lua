while true do
    local event, arg1, arg2, arg3, arg4 = os.pullEvent()
    if event == "key"
    then
        ask = io.read()
        cutask = string.lower(string.sub(ask,1,8))
        if cutask == "give me " then
            req = string.lower(string.sub(ask,9))
            print(req .. "has been requested")
            x = giveMeThisThing(req)
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
            for i=1,max do
            wavepump()
            end
        end
    end
end