local GetVehicleNumberPlateText = GetVehicleNumberPlateText
local GetPedInVehicleSeat       = GetPedInVehicleSeat
local VehToNet                  = VehToNet
local lib                       = lib

string                          = lib.string
local config                    = lib.load('config.config')

local seatCacheFired            = false
local vehicleCacheFired         = false

local badWords                  = config.badWords
local debug                     = config.debug

local doPlateCheck              = config.checkNumberPlates or false

---@type LocalCache
local localCache                = {
    modelHash = 0,
    message = "",
    entitlement = false,
}

---@param plateText string The license plate text to check
---@param vehicle number The vehicle entity handle
---@return boolean Whether the plate contained a bad word and was changed
local function checkVehiclePlate(plateText, vehicle)
    local lowerPlateText = string.lower(plateText):gsub("%s+", "")
    if lib.table.contains(badWords, lowerPlateText) then
        local randomString = string.random('1A1A1A1A', 8)
        SetVehicleNumberPlateText(vehicle, randomString)
        if debug then lib.print.warn(("Bad word found in plate: %s. Changed to %s."):format(lowerPlateText, randomString)) end
        return true
    end
    return false
end

---@param vehicle number The vehicle entity handle
---@param message string The message to show the player
---@param shouldDelete boolean Whether the vehicle should be deleted
---@return nil
local function restrictVehicle(vehicle, message, shouldDelete)
    if debug then lib.print.warn(("Not allowed to drive vehicle. Restricting: %s."):format(tostring(vehicle))) end

    lib.notify({
        title = 'Vehicle Entitlement',
        description = message,
        type = 'error',
        duration = 7500,
        position = 'top',
    })

    if shouldDelete then
        DeleteEntity(vehicle)
        ClearPedTasksImmediately(cache.ped)
        if debug then lib.print.info(("Deleted vehicle: %s."):format(tostring(vehicle))) end
    else
        TaskLeaveVehicle(cache.ped, vehicle, 64)
        if debug then lib.print.info(("TaskLeaveVehicle: %s."):format(tostring(vehicle))) end
        ClearPedTasks(cache.ped)
    end
end

---@param vehicleHandle number The vehicle entity handle
---@return nil
local function handlePlateCheck(vehicleHandle)
    local plateText = GetVehicleNumberPlateText(vehicleHandle)
    if debug then lib.print.info(("Checking plate: %s"):format(plateText)) end
    checkVehiclePlate(plateText, vehicleHandle)
end

---@param vehicleHandle number The vehicle entity handle
---@return nil
local function handleVehicleCheck(vehicleHandle)
    local modelHash = GetEntityModel(vehicleHandle)
    if debug then lib.print.info(("Checking vehicle model hash: %s"):format(modelHash)) end

    if localCache.modelHash == modelHash and not localCache.entitlement then
        if debug then lib.print.info("Vehicle found in local cache and not entitled") end
        local isOwner = lib.callback.await('chroma:server:checkEntityOwner', false, VehToNet(vehicleHandle))
        if isOwner then
            restrictVehicle(vehicleHandle, localCache.message, true)
        else
            restrictVehicle(vehicleHandle, localCache.message, false)
        end
        seatCacheFired = false
        return
    end

    if debug then lib.print.info("Checking vehicle entitlement with server") end
    local resultData = lib.callback.await('chroma:server:checkVehicleEntitlement', false, VehToNet(vehicleHandle),
        modelHash)

    if not resultData.allowed then
        if debug then lib.print.info("Server denied vehicle access") end
        restrictVehicle(vehicleHandle, resultData.message, resultData.delete)
        localCache = {
            modelHash = modelHash,
            message = resultData.message,
            entitlement = false,
        }
        if debug then print(json.encode(localCache, { indent = true })) end
        return
    end

    localCache = {
        modelHash = modelHash,
        message = "",
        entitlement = true,
    }
    if debug then print(json.encode(localCache, { indent = true })) end
end


---@param value number|false
lib.onCache('seat', function(value)
    if vehicleCacheFired or not value or value ~= -1 or not cache.vehicle then
        if debug then lib.print.info("Seat cache fired but conditions not met") end
        return
    end

    seatCacheFired = true

    if doPlateCheck then
        if debug then lib.print.info("Performing plate check from seat cache") end
        handlePlateCheck(cache.vehicle)
    end

    if debug then lib.print.info("Performing vehicle check from seat cache") end
    handleVehicleCheck(cache.vehicle)

    seatCacheFired = false
    if debug then lib.print.info("Seat cache check complete") end
end)

---@param vehicleHandle number|false
lib.onCache('vehicle', function(vehicleHandle)
    if seatCacheFired or not vehicleHandle then
        if debug then lib.print.info("Vehicle cache fired but seatCacheFired or no vehicle handle") end
        return
    end

    if cache.seat ~= -1 then
        if debug then lib.print.info("User is not currently the driver") end
        return
    end

    vehicleCacheFired = true

    if doPlateCheck then
        if debug then lib.print.info("Performing plate check") end
        handlePlateCheck(vehicleHandle)
    end

    if debug then lib.print.info("Performing vehicle check") end
    handleVehicleCheck(vehicleHandle)

    vehicleCacheFired = false
    if debug then lib.print.info("Vehicle cache check complete") end
end)
