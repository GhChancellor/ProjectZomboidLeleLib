---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by lele.
--- DateTime: 07/05/23 10:44
---

-- Update 1850 - 14-09-2023

-- TODO Valutare un controllo per il valore recipe se non è string CharacterPz.addKnownRecipe(character, recipe) e CharacterPz.setZombieKills_PZ(character, killZombies)
--

local characterLib = require("CharacterLib")
local characterPz = require("lib/CharacterPZ")
local dataValidator = require("lib/DataValidator")
local debugDiagnostics = require("lib/DebugDiagnostics")
local isoPlayerPZ = require("lib/IsoPlayerPZ")
local modDataManager = require("lib/ModDataManager")
local perkFactoryPZ = require("lib/PerkFactoryPZ")

require("lib/CharacterBaseObj")

---@type IsoGameCharacter
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
local character = getPlayer()

--- **Character Update**
local function characterUpdate()
    -- TODO - sostituire characterLib con characterPz
    character = characterLib.characterUpdate()
end

local function baseProfession()
    characterUpdate()

    characterPz.setProfession_PZ(character, debugDiagnostics.Profession.BURGER_FLIPPER)

    ---@type string
    local profession = characterPz.getProfession_PZ(character)

    debugDiagnostics.checkTest(profession , debugDiagnostics.Profession.BURGER_FLIPPER,
            "Profession" )

    characterPz.removeProfession(character)

    characterUpdate()
end

local function baseKnownRecipes()
    characterUpdate()

    ---@type string
    local recipe = "Make Pizza"

    characterPz.addKnownRecipe(character, recipe)

    characterUpdate()

    ------- -------------------------------------------------------------
    ---@type List
    local knownRecipes = characterPz.getKnownRecipes_PZ(character)

    if knownRecipes then
        for i = 0, knownRecipes:size() - 1  do
            debugDiagnostics.checkTest(knownRecipes:get(i), recipe, "KnownRecipes")
        end
    else
        debugDiagnostics.checkTest("", "1", "knownRecipes:size()")
    end

    characterPz.removeKnowRecipe_PZ(character, recipe)

    --- -------------------------------------------------------------
    debugDiagnostics.checkTest(character:getKnownRecipes():remove(recipe),
            false, "Remove KnowRecipe")

    characterUpdate()
end

local function baseTrunkFloatTo2Decimal()
    local value = dataValidator.trunkFloatTo2Decimal(1.151)

    debugDiagnostics.checkTest(value, 1.15, "TrunkFloatTo2Decimal")
end

local function baseZombieKills()
    characterUpdate()

    characterPz.setZombieKills_PZ(character, 15)

    debugDiagnostics.checkTest(characterPz.getZombieKills_PZ(character), 15,
            "ZombieKills" )

    characterPz.setZombieKills_PZ(character, 0)

    characterUpdate()
end

local function basePerkBoost()
    characterUpdate()

    ---@type int
    local boostLevel = 1

    characterPz.setPerkBoost_PZ(character, Perks.Cooking, boostLevel)

    debugDiagnostics.checkTest(characterPz.getPerkBoost_PZ(character, Perks.Cooking),
            boostLevel, "PerkBoost")

    characterPz.removePerkBoost(character, Perks.Cooking)

    characterUpdate()
end

local function baseMultiplier()
    characterUpdate()

    ---@type float
    local multiplier = 1.1
    characterPz.addXpMultiplier_PZ(character, Perks.Woodwork, multiplier,
            1, 1)

    characterUpdate()

    local value = characterPz.getMultiplier_PZ(character, Perks.Woodwork)

    debugDiagnostics.checkTest(dataValidator.trunkFloatTo2Decimal(value),
            multiplier, "Multiplier" )

    characterPz.removeMultiplier(character, Perks.Woodwork)

    characterUpdate()
end

local function baseEnumNumbers()
    debugDiagnostics.checkTest(characterPz.EnumNumbers.EIGHT, 8, "EnumNumbers")
end

local function baseXp()
    characterUpdate()

    characterPz.addXP_PZ(character, Perks.Cooking, 75)

    ---@type float
    local xp_ = characterPz.getXp(character, Perks.Cooking)

    debugDiagnostics.checkTest(xp_, 75, "Xp")

    --- -------------------------------------------------
    characterPz.removePerkLevel(character, Perks.Cooking)

    characterUpdate()
end

local function basePerkLevel()
    characterUpdate()

    characterPz.setPerkLevelFromXp(character, Perks.Cooking, 75)

    ---@type int
    local level = characterPz.getPerkLevel_PZ(character, Perks.Cooking)

    debugDiagnostics.checkTest(level, 1, "PerkLevel")
    --- -------------------------------------------------
    characterPz.removePerkLevel(character, Perks.Cooking)

    characterUpdate()
end

local function baseTrait()
    characterUpdate()

    ---@type string
    local trait_ = "Handy"

    characterPz.setTraitsPerk_PZ(character, trait_)

    ---@type List
    local traits_PZ = characterPz.getTraitsPerk_PZ(character)

    for i = 0, traits_PZ:size() - 1 do
        ---@type TraitFactory.Trait
        local trait = TraitFactory.getTrait(traits_PZ:get(i) ):getXPBoostMap()

        ---@type KahluaTable
        local traitKahluaTable = transformIntoKahluaTable(trait)
        for i2, _ in pairs(traitKahluaTable) do
            if tostring(i2) == "Woodwork" then
                debugDiagnostics.checkTest(tostring(i2), "Woodwork", "Add Trait")
            end
        end
    end

    --- ------------------------------------------------
    characterPz.removeTrait_PZ(character, "Woodwork")

    characterUpdate()

    local remove = character:getTraits():remove("Woodwork")
    debugDiagnostics.checkTest(remove, false, "Remove trait")

    --- ------------------------------------------------

    characterPz.removeAllTraits_PZ(character)

    ---@type boolean
    local flag = false

    for i = 0, traits_PZ:size() - 1 do
        ---@type TraitFactory.Trait
        local trait = TraitFactory.getTrait(traits_PZ:get(i) ):getXPBoostMap()

        ---@type KahluaTable
        local traitKahluaTable = transformIntoKahluaTable(trait)
        for _, _ in pairs(traitKahluaTable) do
            flag = true
        end
    end

    debugDiagnostics.checkTest(flag, false, "Remove All Trait")

    characterUpdate()
end

local function baseConvertLevelToXp()
    ---@type float
    local xp = perkFactoryPZ.convertLevelToXp(Perks.Cooking, 1)

    debugDiagnostics.checkTest(xp, 75, "ConvertLevelToXp")
end

local function basePerkName()
    local perk = perkFactoryPZ.getPerk_PZ(Perks.Cooking)
    debugDiagnostics.checkTest(perk, perk, "Perk Name")
end

local function baseParent()
    ---@type string
    local parent_ = "Combat"
    ---@type string
    local parent = perkFactoryPZ.getParent_PZ(Perks.Maintenance)
    debugDiagnostics.checkTest(parent_, parent, "Parent" )
end

local function baseHoursSurvived()
    ---@type float
    local hoursSurvived = 1.0
    ---@type float
    local hoursSurvived_
    isoPlayerPZ.setHoursSurvived_PZ(hoursSurvived)

    ---@type float
    hoursSurvived_ = isoPlayerPZ.getHoursSurvived_PZ()
    debugDiagnostics.checkTest(hoursSurvived_, hoursSurvived, "Hours Survived" )
end

local function baseCalories()
    ---@type float
    local calories = 20.1
    ---@type float
    local calories_
    ---@type double
    local trunckedCalories
    isoPlayerPZ.setCalories_PZ(calories)

    calories_ = isoPlayerPZ.getCalories_PZ()

    trunckedCalories = dataValidator.trunkFloatTo2Decimal(calories_)

    debugDiagnostics.checkTest(trunckedCalories, calories, "Calories" )
end

local function baseWeight()
    ---@type int
    local weight = 83
    ---@type int
    local weight_
    isoPlayerPZ.setWeight_PZ(weight)

    weight_ = isoPlayerPZ.getWeight_PZ()
    debugDiagnostics.checkTest(weight_, weight, "Weight" )
end

local function baseModData()
    ---@type table
    local initValues = { 1, 2, 3, 4, 5}

    ---@type table
    local results = {}

    ---@type string
    local testEnum = "testEnum"

    modDataManager.remove(testEnum)

    modDataManager.save(testEnum, initValues)

    results = modDataManager.read(testEnum)

    if dataValidator.isTable(results) then
        debugDiagnostics.checkTest(true, true, "Is a table")
    end

    -----@type number
    for i, v in pairs(results) do
        if v == initValues[i] then
            debugDiagnostics.checkTest(true, true, "ModData read value is " .. v)
        end
    end

    if modDataManager.isExists(testEnum) then
        debugDiagnostics.checkTest(true, true, "ModData isExists")
    end

    if modDataManager.remove(testEnum) ~= false then
        modDataManager.remove(testEnum)
        debugDiagnostics.checkTest(true, true, "ModData Remove")
    end

    modDataManager.remove(testEnum)
end

local function baseUserName()
    if isoPlayerPZ.getUserName()  then
        debugDiagnostics.checkTest(true, true, "Get UserName")
    else
        debugDiagnostics.checkTest(false, true, "Get UserName")
    end

    ---@type string
    local newUserName = "paolo"

    isoPlayerPZ.setUserName(newUserName)

    if isoPlayerPZ.getUserName() == newUserName  then
        debugDiagnostics.checkTest(true, true, "Set UserName")
    else
        debugDiagnostics.checkTest(false, true, "Set UserName")
    end
end

--- ------------------------------------------------

local function traitsPerk()
    characterUpdate()

    characterPz.setProfession_PZ(character, debugDiagnostics.Profession.CHEF)

    ---@type string
    local trait_ = "Feeble"
    characterPz.setTraitsPerk_PZ(character, trait_)

    characterUpdate()

    local CharacterObj01 = CharacterBaseObj:new()
    CharacterObj01 = characterLib.getTraitsPerk(character)

    ---@type boolean
    local flag = false

    if CharacterObj01:getPerkDetails() then
        flag = true
    end

    debugDiagnostics.checkTest(true,
            true, "Get PerkDetails")

    flag = false

    if CharacterObj01:getTraits() then
        flag = true
    end

    debugDiagnostics.checkTest(true,
            true, "Get Traits")

    characterPz.removeProfession(character)
    characterPz.removeAllTraits_PZ(character)

    characterUpdate()
end

local function perkProfession()
    characterUpdate()

    characterPz.setProfession_PZ(character, debugDiagnostics.Profession.CHEF)

    local CharacterObj01 = CharacterBaseObj:new()

    characterUpdate()

    CharacterObj01 = characterLib.getPerkProfession(character)

    ---@type boolean
    local flag = false

    if CharacterObj01:getPerkDetails() then
        flag = true
    end

    debugDiagnostics.checkTest(true,
            true, "Get perkProfession")

    characterPz.removeProfession(character)
    characterPz.removeAllTraits_PZ(character)

    characterUpdate()
end

--- ------------------------------------------------------------

local function characterLibAllPerks()
    characterUpdate()

    local CharacterObj01 = CharacterBaseObj:new()
    CharacterObj01 = characterLib.getAllPerks(character)

    ---@type boolean
    local flag = false

    if CharacterObj01:getPerkDetails() then
        flag = true
    end

    debugDiagnostics.checkTest(true,
            true, "All Skills")

    ---@type string
    local profession = CharacterObj01:getProfession()
    ---@type string
    local profession_ = characterPz.getProfession_PZ(character)

    debugDiagnostics.checkTest(profession,
            profession_, "All Skills - Profession")

    characterUpdate()
end

local function characterLibPerksBoost()
    characterUpdate()

    ---@type int
    local boost = 1
    characterPz.setPerkBoost_PZ(Perks.Cooking, boost)

    characterUpdate()

    local CharacterObj01 = CharacterBaseObj:new()

    CharacterObj01 = characterLib.getPerksBoost(character)

    ---@type boolean
    local flag = false

    for _, v in pairs(CharacterObj01:getPerkDetails()) do
        if v:getPerk() == Perks.Cooking then
            if v:getBoostLevel() == boost then
                flag = true
            end
        end
    end

    debugDiagnostics.checkTest(true,
            true, "Perks Boost")

    characterPz.removePerkBoost(character, Perks.Cooking, boost)

    characterUpdate()
end

local function characterLibKnownRecipes()
    characterUpdate()

    ---@type string
    local recipe = "Make Pizza"

    characterPz.addKnownRecipe(character, recipe)

    characterUpdate()

    local CharacterObj01 = CharacterBaseObj:new()
    CharacterObj01 = characterLib.getKnownRecipes(character)

    ---@type boolean
    local flag = false

    for _, v in pairs(CharacterObj01:getRecipes()) do
        if v == recipe then
            flag = true
        end
    end

    debugDiagnostics.checkTest(flag,
            true, "KnownRecipes")

    characterUpdate()
end

local function characterLibMultiplier()
    characterUpdate()

    ---@type float
    local multiplier = 1.0

    characterPz.addXpMultiplier_PZ(character, Perks.Cooking, multiplier,
            characterPz.EnumNumbers.ONE, characterPz.EnumNumbers.ONE)

    characterUpdate()

    local CharacterObj01 = CharacterBaseObj:new()
    CharacterObj01 = characterLib.getMultiplier(character)

    for _, v in pairs(CharacterObj01:getPerkDetails()) do
        if v:getPerk() == Perks.Cooking then
            debugDiagnostics.checkTest(v:getMultiplier(),
                    multiplier, "Multiplier")
        end
    end

    characterPz.removeMultiplier(character, Perks.Cooking)

    characterUpdate()
end

local function characterLibDe_EncodePerkDetails()
    characterUpdate()

    characterPz.setProfession_PZ(character, debugDiagnostics.Profession.CARPENTER)
    characterPz.setPerkLevelFromXp(character, debugDiagnostics.Perks.WOODWORK, 100.0)

    characterUpdate()

    local CharacterObj01 = CharacterBaseObj:new()
    local CharacterDecodeObj = CharacterBaseObj:new()

    ---@type PerkFactory.Perk
    local perk = perkFactoryPZ.getPerk_PZ(debugDiagnostics.Perks.WOODWORK)
    ---@type int
    local level = characterPz.getPerkLevel_PZ(character, perk)
    ---@type float
    local xp = characterPz.getXp(character, perk)

    ---@type PerkFactory.Perk
    local perk2
    ---@type int
    local level2
    ---@type float
    local xp2

    CharacterObj01:addPerkDetails(perk, level, xp)

    ---@type table
    local lines = {}

    -- encode
    for _, v in pairs(CharacterObj01:getPerkDetails()) do
        lines = characterLib.encodePerkDetails(CharacterObj01)
    end

    CharacterDecodeObj = characterLib.decodePerkDetails(lines)

    for _, v in pairs(CharacterObj01:getPerkDetails()) do
        perk = v:getPerk()
        level = v:getLevel()
        xp = v:getXp()
    end

    -- decode
    for _, v in pairs(CharacterDecodeObj:getPerkDetails()) do
        perk2 = v:getPerk()
        level2 = v:getLevel()
        xp2 = v:getXp()
    end

    if perk == perk2 and level == level2 and xp == xp2 then
        debugDiagnostics.checkTest(true, true, "De_EncodePerkDetails")
    else
        debugDiagnostics.checkTest(false, true, "De_EncodePerkDetails")
    end

    lines = {}

    debugDiagnostics.deleteCharacter()
    characterUpdate()
end

--- ------------------------------------------------------------
--- ------------------------------------------------------------

local function baseTest()
    baseProfession()
    baseKnownRecipes()
    baseTrunkFloatTo2Decimal()
    baseZombieKills()
    basePerkBoost()
    baseMultiplier()
    baseEnumNumbers()
    baseXp()
    basePerkLevel()
    baseTrait()
    baseConvertLevelToXp()
    basePerkName()
    baseParent()
    baseWeight()
    baseHoursSurvived()
    baseCalories()
    baseModData()
    baseUserName()
end

local function characterLibTest()
    --- CharacterLib
    traitsPerk()
    perkProfession()
    -- -- currentSkill()
    characterLibAllPerks()
    characterLibPerksBoost()
    characterLibKnownRecipes()
    characterLibMultiplier()
    characterLibDe_EncodePerkDetails()

    debugDiagnostics.displayTest()

end

-- Perks.Maintenance
-- Perks.Woodwork
-- Perks.Sprinting
-- self.character:playSound("CloseBook")
---@param character IsoGameCharacter
local function key34(character, key)

    if key == 34 then -- <<<< g
        print("Key = g > characterLibTest \n")
        debugDiagnostics.setVerbose(false)
        baseTest()
        characterLibTest()
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
        print("Key = k  \n")
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
    character = getPlayer()

    key16(character, key) -- q kill character
    -- key17(character, key) -- w
    -- key18(character, key) -- e
    key34(character, key) -- g
    key35(character, key) -- h
    key36(character, key) -- j
    key37(character, key) -- k
end

Events.OnCustomUIKeyPressed.Add(onCustomUIKeyPressed)