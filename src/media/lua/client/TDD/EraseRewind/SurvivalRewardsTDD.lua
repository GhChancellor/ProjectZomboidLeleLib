---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by lele.
--- DateTime: 26/04/23 17:41
---

local dbgLeleLib = require("DebugDiagnostics")
local modDataManager = require("lib/ModDataManager")
local characterPz = require("lib/CharacterPZ")

local kilMilReachedValue = 15
local milReachedValue = 10
local reset = 0

local kilMilReached = "kilMilReachedX"
local milReached = "milReachedX"

---@param character IsoGameCharacter
--- - zombie.characters.IsoGameCharacter
local function survivalRewards_TDD()
    local character = getPlayer()

    character:getModData().kilMilReached = kilMilReachedValue
    character:getModData().milReached = milReachedValue

    modDataManager.save(kilMilReached,
            character:getModData().kilMilReached )

    modDataManager.save(milReached,
            character:getModData().milReached )

    local readKilMilReacheds = {}
    readKilMilReacheds = modDataManager.read(kilMilReached)

    local readMilReacheds = {}
    readMilReacheds =modDataManager.read(milReached)

    local readKilMilReached = 0
    local readMilReached = 0

    for i, v in pairs(readKilMilReacheds) do
        readKilMilReached = v
    end

    for i, v in pairs(readMilReacheds) do
        readMilReached = v
    end

    dbgLeleLib.checkTest(kilMilReachedValue, readKilMilReached, "Read KilMilReached" )
    dbgLeleLib.checkTest(milReachedValue, readMilReached, "Read MilReached" )

    modDataManager.remove(kilMilReached)
    modDataManager.remove(milReached)

    dbgLeleLib.checkTest(modDataManager.isExists(kilMilReached),
            false, "Remove KilMilReached" )

    dbgLeleLib.checkTest(modDataManager.isExists(milReached),
            false, "Remove MilReached" )

    character:getModData().kilMilReached = reset
    character:getModData().milReached = reset

    dbgLeleLib.printLine()
    dbgLeleLib.displayTest()
    dbgLeleLib.printLine()
end

-- Perks.Maintenance
-- Perks.Woodwork
-- Perks.Sprinting
-- self.character:playSound("CloseBook")
---@param character IsoGameCharacter
local function key34(character, key)
    if key == 34 then -- <<<< g
        print("Key = g >  \n")
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
        print("Key = j > survivalRewards TDD \n")
        dbgLeleLib.setVerbose(false)
        survivalRewards_TDD()
    end
end

---@param character IsoGameCharacter
local function key37(character, key)
    if key == 37 then -- <<<< k
        print("Key = k > delete \n")
        character:die()
    end
end

---@param character IsoGameCharacter
local function key16(character, key)
    if key == 16 then -- <<<< q
        print("Key = q >  \n")

    end
end

---@param character IsoGameCharacter
local function key17(character, key)
    if key == 17 then -- <<<< w
        print("Key = w >  \n")

    end
end

---@param character IsoGameCharacter
local function key18(character, key)
    if key == 18 then -- <<<< e
        print("Key = e >  \n")

    end
end

local function onCustomUIKeyPressed(key)
    local character = getPlayer()

    key16(character, key) -- <<<< q
    key17(character, key) -- <<<< w
    key18(character, key) -- <<<< e
    key34(character, key) -- <<<< g
    key35(character, key) -- <<<< h
    key36(character, key) -- <<<< j
    key37(character, key) -- <<<< k - Kill
end

-- ------------------------------------------------------------
-- ------------------------------------------------------------

local function OnGameStart()

end

-- Events.OnCustomUIKeyPressed.Add(onCustomUIKeyPressed)

