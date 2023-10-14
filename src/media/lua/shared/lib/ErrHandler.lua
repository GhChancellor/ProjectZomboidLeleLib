---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by lele.
--- DateTime: 02/10/23 09:54
---

---@class ErrHandler

local ErrHandler = {}

--- **Function to Handler errors**
--- @param sourceError string
--- @param errorMessage string
--- @return string
function ErrHandler.errMsg(sourceError, errorMessage)
    ---@type string
    local srcErr = tostring(sourceError)

    ---@type string
    local errMsg = tostring(errorMessage)

    ---@type string
    local messageError = "\nERROR: >>>>>>>>>>>>> " .. srcErr .. " : "
            .. errMsg .. " <<<<<<<<<<<<<<\n"
    return messageError
end

--- **Validate Param**
---@param value any
---@param dataValidatorFn function
---@param errMsg string
function ErrHandler.validateParam(value, dataValidatorFn, errMsg)
    local success, err = pcall(function()
        dataValidatorFn(value)
    end)

    if not success then
        error(errMsg, 1)
    end
end

ErrHandler.err = {
    IS_NULL_CHARACTERS = "is null characters",
    IS_NULL_PERK = "is null perk",
    IS_NULL_XP = "is null xp",
    IS_NULL = "is null",
    IS_NOT_STRING = "is not string",
    IS_NOT_BOOLEAN = "is not boolean",
    IS_NOT_DOUBLE_FLOAT = "is not double float",
    IS_NOT_INT = "is not int",
    IS_NOT_TABLE = "is not table",
}


return ErrHandler