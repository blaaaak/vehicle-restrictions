--[[ Vehicle Configuration Examples
    Each vehicle configuration can include:
    - requiredPermissions: Table of ace permissions (player needs ANY ONE of these)
    - message: Custom denial message (optional, falls back to config.restrictMessage)
    - deleteOnRestrict: Whether to delete vehicle when restricted (optional, falls back to config.deleteOnRestrict)
]]

--[[ Basic Example
    [`sultanrs`] = {
        requiredPermissions = { 'vehicle.use' }
        -- Uses default message and deletion behavior
    }
]]

--[[ Custom Message Example
    [`adder`] = {
        requiredPermissions = { 'vehicle.sports' },
        message = 'This vehicle requires sports car certification.'
    }
]]

--[[ Multiple Permissions Example
    [`police`] = {
        -- Player needs EITHER police.vehicle OR leo.duty
        requiredPermissions = { 'police.vehicle', 'leo.duty' },
        message = 'This vehicle is for on-duty law enforcement only.',
        deleteOnRestrict = true -- Always delete on restriction
    }
]]

--[[ Custom Deletion Example
    [`zentorno`] = {
        requiredPermissions = { 'vip.vehicle' },
        message = 'This vehicle is for VIP players only.',
        deleteOnRestrict = false -- Never delete, just remove player
    }
]]


---@type VehicleConfig[]
return {
    --- Some example vehicles. Remove them after you've configured your own.
    [`sultanrs`] = {
        requiredPermissions = { 'vehicle.use' },
        -- No message or deleteOnRestrict preference so the defaults are used.
    },
    [`adder`] = {
        requiredPermissions = { 'vehicle.sports' },
        -- Custom message to show when access is denied.
        message = 'This vehicle requires sports car certification.',
        -- Never delete vehicle on restriction, just remove player
        deleteOnRestrict = false,
    },
    [`police`] = {
        -- Allows for multiple aces to be used, so you can assign diferent ace permissions to the same vehicle.
        requiredPermissions = { 'police.vehicle', 'leo.duty' },
        -- Custom message to show when access is denied.
        message = 'This vehicle is for on-duty law enforcement only.',
        -- Always delete vehicle on restriction, regardless of config or ownership
        deleteOnRestrict = true,
    },
}
