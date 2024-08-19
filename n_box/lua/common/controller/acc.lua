local M = {}

local accTime = nil
local accDist = nil
local decTime = nil
local decDist = nil

local accDis = nil
local desDis = nil

local ifDisplay = nil

local zeroV = 0.01

local function display(num)
    ifDisplay = num
end

local function updateGFX(dt)
    local velocity = electrics.values.airspeed
    local deltaTime = dt

    -- log("D", "velocity", velocity)

    if velocity <= zeroV then
        accTime = 0
        accDist = 0
        accDis = 0
    elseif velocity < 27.78 then
        accTime = accTime + dt
        accDist = accDist + deltaTime * velocity
    else
        if accDis == 0 then
            if ifDisplay == 1 then
                guihooks.message("0-100 kph time is " .. string.format("%.2f", accTime) .. " seconds, 0-100 kph distance is " .. string.format("%.2f", accDist) .. " meters." , 3, "")
                log("D", "accelerate", "0-100 kph time is " .. string.format("%.2f", accTime) .. " seconds, 0-100 kph distance is " .. string.format("%.2f", accDist) .. " meters.")
            end
            accDis = 1
        end
    end

    if velocity >= 27.78 then
        decTime = 0
        decDist = 0
        desDis = 0
    elseif velocity >= zeroV then
        decTime = decTime + dt
        decDist = decDist + deltaTime * velocity
    else
        if desDis == 0 then
            if ifDisplay == 1 then
                guihooks.message("100-0 kph time is " .. string.format("%.2f", decTime) .. " seconds, 100-0 kph distance is " .. string.format("%.2f", decDist) .. " meters." , 3, "")
                log("D", "decelerate", "100-0 kph time is " .. string.format("%.2f", decTime) .. " seconds, 100-0 kph distance is " .. string.format("%.2f", decDist) .. " meters.")
            end
            desDis = 1
        end
    end

end

local function init()
    accTime = 0
    accDist = 0
    decTime = 0
    decDist = 0

    accDis = 1
    desDis = 1

    ifDisplay = 1
end

local function reset()
    accTime = 0
    accDist = 0
    decTime = 0
    decDist = 0

    accDis = 1
    desDis = 1

    ifDisplay = 1
end

M.display = display

M.new = init
M.init = init
M.onReset = reset
M.reset = reset
M.updateGFX = updateGFX

return M