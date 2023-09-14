-----
----- Generated by EmmyLua(https://github.com/EmmyLua)
----- Created by lele.
----- DateTime: 09/09/23 11:08
-----
--
---- ---@class ActivityCalendar
--
--local ActivityCalendar = {}
--
--local month = {
--    Jan = 1, Feb = 2, Mar = 3, Apr = 4, May = 5, Jun = 6,
--    Jul = 7, Aug = 8, Sep = 9, Oct = 10, Nov = 11, Dec = 12
--}
--
-----@type int
--local SECOND_IN_DAY = 86400
--
-----@type double
--local expectedDate
--
----- **Extract Date**
-----@param date string
-----@return table int ( day ), int ( month ), int ( year )
--local function extractDate(date)
--    ---@type table
--    local dateParts = {}
--
--    if not date or type(date) ~= "string" then
--        return nil
--    end
--
--    for datePart in date:gmatch("%S+") do
--        table.insert(dateParts, datePart)
--        print(datePart)
--    end
--
--    ---@type table
--    local datePartsConverted = {}
--
--    ---@type int
--    local day = tonumber(dateParts[3])
--    table.insert(datePartsConverted, day)
--    print(day)
--
--    ---@type int
--    local month = month[dateParts[2]]
--    table.insert(datePartsConverted, month)
--    print(month)
--
--    ---@type int
--    local year = tonumber(dateParts[6])
--    table.insert(datePartsConverted, year)
--    print(year)
--
--     return datePartsConverted
--end
--
----- **Get Star Time**
-----@return double seconds
--local function getStarTime()
--    ---@type string
--    local date = tostring( getGameTime():getCalender():getTime() )
--    --
--    ----local dateFromLua = 1694078266 -- oggi
--    ----local dateFromFakePZ = "Fri Jul 09 09:43:41 CEST 1993"
--    ----local date = dateFromFakePZ
--    --
--    return extractDate(date)
--    -- return "x"
--end
--
--function ActivityCalendar.funcName()
--    local values = {}
--    values = getStarTime()
--    print(tostring(values[1]) .. " " .. tostring(values[2]) .. " " .. tostring(values[3]))
--end
--
----local values = {}
----values = getStarTime()
----
----print(tostring(values[1]) .. " " .. tostring(values[2]) .. " " .. tostring(values[3]))
--
--
--return ActivityCalendar