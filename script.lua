
function onTick()
    enable = input.getBool(1)
    warningEnable = input.getBool(2)
    dx = input.getNumber(5) - input.getNumber(3) -- des-curr
    dy = input.getNumber(6) - input.getNumber(4) -- des-curr
    manualYaw = input.getNumber(7)
    heading = input.getNumber(8)
    warningDis = input.getNumber(9)

    nearingWarn = false
    distence = 0
    calcYaw = 0
    recommendYaw = 0

    pilotDir = -math.atan(dx, dy) / (2 * math.pi)
    dirDiff = heading - pilotDir
    if(dirDiff > 0.5)
    then 
        dirDiff = dirDiff - 1
    elseif (dirDiff < -0.5)
    then 
        dirDiff = dirDiff + 1
    end
    if(dirDiff > 0.1)
    then 
        recommendYaw = 1
    elseif(dirDiff > -0.1)
    then 
        recommendYaw = 10 * dirDiff
    else
        recommendYaw = -1
    end
    distence = math.sqrt(dx * dx + dy * dy)
    if(enable)
    then 
        absManualYaw = math.abs(manualYaw)
        calcYaw = absManualYaw * manualYaw + (1 - absManualYaw)  * recommendYaw
        nearingWarn = warningEnable and distence < warningDis
    else
        calcYaw = manualYaw
    end
    output.setBool(1, nearingWarn)
    output.setNumber(2, distence)
    output.setNumber(3, calcYaw)
    output.setNumber(4, recommendYaw)
end

function onDraw()
end
