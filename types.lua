---@meta

---@class VehicleConfig
---@field requiredPermissions string[] The permissions required to use this vehicle
---@field message? string The message to show when access is denied (optional, defaults to config.restrictMessage)
---@field deleteOnRestrict? boolean Whether to delete the vehicle when access is denied (optional, defaults to config.deleteOnRestrict)

---@class LocalCache
---@field modelHash number The model hash of the last checked vehicle
---@field message string The restriction message for the last checked vehicle
---@field entitlement boolean Whether the player has permission to drive the last checked vehicle

---@class VehicleCheckResult
---@field allowed boolean Whether the player is allowed to use the vehicle
---@field message string Message to display if not allowed
---@field delete boolean Whether to delete the vehicle if restricted
