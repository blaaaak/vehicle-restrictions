local config = lib.load('config.config')
local vehicleConfig = lib.load('config.vehicles')
local debug = config.debug

local IsPlayerAceAllowed = IsPlayerAceAllowed
local NetworkGetEntityFromNetworkId = NetworkGetEntityFromNetworkId
local DoesEntityExist = DoesEntityExist
local NetworkGetFirstEntityOwner = NetworkGetFirstEntityOwner
local DoesPlayerExist = DoesPlayerExist


--- Validates a source to ensure it is a valid number and player is connected.
---@param source number Player source
---@return boolean
local function validateSource(source)
    if not source or type(source) ~= 'number' or source <= 0 then return false end
    if not DoesPlayerExist(source --[[@as string]]) then return false end

    return true
end

---Checks if a player has permission to use a vehicle
---@param source number The player source ID
---@param netId number The vehicle net ID
---@param modelHash number The vehicle model hash
---@return VehicleCheckResult Result containing allowed status, message and delete flag
lib.callback.register('chroma:server:checkVehicleEntitlement', function(source, netId, modelHash)
    local result = { allowed = true, message = "", delete = false }
    if not validateSource(source) then
        lib.print.warn("Warning invalid source: " .. (source or "unknown"))
        return { allowed = false, message = "Error: Invalid source", delete = true }
    end

    local entity = NetworkGetEntityFromNetworkId(netId)
    local originalOwner = 0
    if DoesEntityExist(entity) then
        originalOwner = NetworkGetFirstEntityOwner(entity)
        if not originalOwner then
            lib.print.error(("Failed to get entity owner: %s"):format(originalOwner))
        end
    end

    local modelConfig = vehicleConfig[modelHash]

    if debug then
        lib.print.info(("Original Owner: %s"):format(originalOwner))
        lib.print.info(("Source: %s"):format(source))
    end

    if not modelConfig then
        if config.restrictIfNotFound then
            if debug then
                lib.print.warn("Vehicle model not found in config and restrictIfNotFound is true")
            end
            result.allowed = false
            result.message = config.restrictMessage
            result.delete = source == originalOwner
            return result
        end
        if debug then lib.print.info("Vehicle model not found in config but restrictIfNotFound is false") end
        return result
    end

    if not modelConfig.requiredPermissions then
        if debug then lib.print.info("No permissions required for this vehicle") end
        return result
    end

    local modelPerms = modelConfig.requiredPermissions

    if debug then lib.print.info(("Checking %s permissions for source %s"):format(#modelPerms, source)) end
    for i = 1, #modelPerms do
        local permission = modelPerms[i]
        if debug then lib.print.info(("Checking permission: %s"):format(permission)) end
        if IsPlayerAceAllowed(source --[[@as string]], permission) then
            if debug then lib.print.info(("Player has required permission: %s"):format(permission)) end
            result.allowed = true
            result.message = ""
            return result
        end
        if debug then lib.print.warn(("Player does not have permission: %s"):format(permission)) end
    end

    if debug then lib.print.warn("Player does not have any required permissions") end

    result.allowed = false
    result.message = modelConfig.message or config.restrictMessage

    if modelConfig.deleteOnRestrict == nil then
        result.delete = source == originalOwner
    else
        result.delete = modelConfig.deleteOnRestrict
    end

    return result
end)

---@param source number The player source ID
---@param netId number The vehicle net ID
---@return boolean
lib.callback.register('chroma:server:checkEntityOwner', function(source, netId)
    if not validateSource(source) then return false end
    local entity = NetworkGetEntityFromNetworkId(netId)
    if not DoesEntityExist(entity) then
        return false
    end
    return NetworkGetFirstEntityOwner(entity) == source
end)
