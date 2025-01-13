-- -- Example vehicle configurations:
-- -- Each vehicle can have required permissions, custom messages, and deletion behavior

-- -- Basic vehicle with single permission requirement
-- [`sultanrs`] = {
--     -- Only requires basic vehicle usage permission
--     requiredPermissions = { 'vehicle.use' },
-- },

-- -- Vehicle with custom denial message
-- [`adder`] = {
--     -- Requires sports car certification
--     requiredPermissions = { 'vehicle.sports' },
--     -- Custom message shown when access denied
--     message = 'This vehicle requires sports car certification.',
-- },

-- -- Vehicle requiring one of multiple permissions
-- [`police`] = {
--     -- Player needs EITHER police.vehicle OR leo.duty permission
--     requiredPermissions = { 'police.vehicle', 'leo.duty' },
--     -- Custom denial message
--     message = 'This vehicle is for on-duty law enforcement only.',
--     -- Always delete vehicle on restriction, regardless of config or ownership
--     deleteOnRestrict = true,
-- },

-- -- VIP vehicle with custom deletion behavior
-- [`zentorno`] = {
--     -- Requires VIP vehicle permission
--     requiredPermissions = { 'vip.vehicle' },
--     -- Custom denial message
--     message = 'This vehicle is for VIP players only.',
--     -- Never delete vehicle on restriction, just remove player
--     deleteOnRestrict = false,
-- },


---@type VehicleConfig[]
return {
    [`sultanrs`] = {
        requiredPermissions = { 'vehicle.use' },
    },
    [`adder`] = {
        requiredPermissions = { 'vehicle.sports' },
        message = 'This vehicle requires sports car certification.',
        deleteOnRestrict = false,
    },
    [`police`] = {
        requiredPermissions = { 'police.vehicle', 'leo.duty' },
        message = 'This vehicle is for on-duty law enforcement only.',
        deleteOnRestrict = true,
    },
}
