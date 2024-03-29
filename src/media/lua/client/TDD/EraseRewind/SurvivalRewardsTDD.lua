---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by lele.
--- DateTime: 26/04/23 17:41
---

local debugDiagnostics = require("lib/DebugDiagnostics")
local modDataManager = require("lib/ModDataManager")
local patchSurvivalRewards = require("patchSurvivalRewards/PatchSurvivalRewards")

local kilMilReachedValue = 15
local milReachedValue = 10
local reset = 0

local kilMilReached = "kilMilReachedX"
local milReached = "milReachedX"

---@param character IsoGameCharacter
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
local function survivalRewards_TDD()
    local character = getPlayer()

    character:getModData().kilMilReached = kilMilReachedValue
    character:getModData().milReached = milReachedValue

    ---@type boolean
    local modIsActive = patchSurvivalRewards.isModActive()
    debugDiagnostics.checkTest(modIsActive, true, "Mod is Active")

    ---@type table
    local lines = {}
    table.insert(lines, character:getModData().kilMilReached)
    modDataManager.save(kilMilReached,
            lines )

    lines = {}
    table.insert(lines, character:getModData().milReached)
    modDataManager.save(milReached,
            lines )

    ---@type table
    local readKilMilReacheds = {}
    readKilMilReacheds = modDataManager.read(kilMilReached)

    ---@type table
    local readMilReacheds = {}
    readMilReacheds =modDataManager.read(milReached)

    ---@type int
    local readKilMilReached = 0

    ---@type int
    local readMilReached = 0

    readKilMilReached = readKilMilReacheds[1]

    readMilReached = readMilReacheds[1]

    --- **Check KilMilReached**
    debugDiagnostics.checkTest(kilMilReachedValue, readKilMilReached, "Read KilMilReached" )

    --- **Check MilReached**
    debugDiagnostics.checkTest(milReachedValue, readMilReached, "Read MilReached" )

    --- **Remove KilMilReached**
    modDataManager.remove(kilMilReached)

    --- **Remove MilReached**
    modDataManager.remove(milReached)

    --- **Check Remove KilMilReached**
    debugDiagnostics.checkTest(modDataManager.isExists(kilMilReached),
            false, "Remove KilMilReached" )

    --- **Check Remove MilReached**
    debugDiagnostics.checkTest(modDataManager.isExists(milReached),
            false, "Remove MilReached" )

    character:getModData().kilMilReached = reset
    character:getModData().milReached = reset

    debugDiagnostics.displayTest()
end

---@param character IsoGameCharacter
local function key34(character, key)
    if key == 34 then -- <<<< g
        print("Key = g >  \n")
        debugDiagnostics.setVerbose(false)
        survivalRewards_TDD()
    end
end

---@param character IsoGameCharacter
local function key35(character, key)
    if key == 35 then -- <<< h
        print("Key = h >  \n")

    end
end

---@param character IsoGameCharacter
local function key36(character, key)
    if key == 36 then -- <<<< j
        print("Key = j >  \n")

    end
end

---@param character IsoGameCharacter
local function key37(character, key)
    if key == 37 then -- <<<< k
        print("Key = k >  \n")

    end
end

---@param character IsoGameCharacter
local function key17(character, key)
    if key == 17 then -- <<<< w
        print("Key = w >   \n")

    end
end

---@param character IsoGameCharacter
local function key18(character, key)
    if key == 18 then -- <<<< e
        print("Key = e >  \n")

    end
end

---@param character IsoGameCharacter
local function key16(character, key)
    if key == 16 then -- <<<< q
        print("Key = q > kill Character \n")
        character:die()
    end
end

local function onCustomUIKeyPressed(key)
    local character = getPlayer()

    key16(character, key) -- q kill character
    key17(character, key) -- w
    key18(character, key) -- e
    key34(character, key) -- g
    key35(character, key) -- h
    key36(character, key) -- j
    key37(character, key) -- k
end

--Events.OnCustomUIKeyPressed.Add(onCustomUIKeyPressed)
