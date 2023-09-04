---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by lele.
--- DateTime: 12/05/23 15:30
---

local dbgLeleLib = require("lib/DbgLeleLib")
local characterPz = require("lib/CharacterPZ")
local isoPlayerPZ = require("lib/IsoPlayerPZ")
local characterLib = require("CharacterLib")
require("lib/CharacterBaseObj")

local character = getPlayer()

local function character_TDD()
    local CharacterDeleteObj = CharacterBaseObj:new()

    character = getPlayer()

    -- check Profession
    dbgLeleLib.checkTest(characterPz.getProfession_PZ(character),
            dbgLeleLib.EnumProfession.CARPENTER, "Profession" )

    -- check Perk Level
    dbgLeleLib.checkTest( characterPz.getXp(character, Perks.Fitness),
            37500, "PerkLevel Fitness")
    dbgLeleLib.checkTest( characterPz.getXp(character, Perks.Strength),
            37500, "PerkLevel Strength")
    dbgLeleLib.checkTest( characterPz.getXp(character, Perks.Woodwork),
            1275, "PerkLevel Woodwork")
    dbgLeleLib.checkTest( characterPz.getXp(character, Perks.Maintenance),
            75, "PerkLevel Maintenance")
    dbgLeleLib.checkTest( characterPz.getXp(character, Perks.SmallBlunt),
            75, "PerkLevel SmallBlunt")

    -- check Perk Boost
    dbgLeleLib.checkTest( characterPz.getPerkBoost_PZ(character, Perks.Fitness),
            3, "PerkBoost Fitness")
    dbgLeleLib.checkTest( characterPz.getPerkBoost_PZ(character, Perks.Strength),
            3, "PerkBoost Strength")
    dbgLeleLib.checkTest( characterPz.getPerkBoost_PZ(character, Perks.Woodwork),
            3, "PerkBoost Woodwork")

    -- check Zombie Kills
    dbgLeleLib.checkTest( characterPz.getZombieKills_PZ(character),
            15, "Zombie")

    -- check recipe
    local recipe = "Make Pizza"
    CharacterDeleteObj = characterLib.getKnownRecipes(character)

    for _, v in pairs(CharacterDeleteObj:getRecipes()) do
        dbgLeleLib.checkTest(v,
                recipe, "Recipe")
    end

    -- check multipier
    local multipier1 =
        characterPz.getMultiplier_PZ(character, Perks.Cooking)

    multipier1 = characterPz.trunkFloatTo2Decimal(multipier1)

    local multiplier2 = 1.0
    dbgLeleLib.checkTest(multipier1,
            multiplier2, "Multiplier")

    -- check Calories
    dbgLeleLib.checkTest(isoPlayerPZ.getCalories_PZ(),
            1500, "HoursSurvived")

    -- check Weight
    dbgLeleLib.checkTest(isoPlayerPZ.getWeight_PZ(),
            92, "Weight")

    dbgLeleLib.displayTest()
end

-- Todo 		self.character:playSound("CloseBook")
---@param character IsoGameCharacter
local function key34(character, key)
    if key == 34 then -- <<<< g
        print("Key = g > writeBook \n")
        dbgLeleLib.deleteCharacter()
        dbgLeleLib.createCharacter()
        writeBook(character)
        readBook(character)
        character_TDD()
    end
end

---@param character IsoGameCharacter
local function key35(character, key)
    if key == 35 then -- <<< h
        print("Key = h > deleteCharacter \n")
        dbgLeleLib.deleteCharacter()
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

-- https://theindiestone.com/forums/index.php?/topic/9799-key-code-reference/
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

-- Events.OnCustomUIKeyPressed.Add(onCustomUIKeyPressed)
