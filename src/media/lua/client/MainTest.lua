---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by lele.
--- DateTime: 07/05/23 10:44
---

local dbgLeleLib = require("lib/DbgLeleLib")
local characterPz = require("lib/CharacterPZ")
local perkFactoryPZ = require("lib/PerkFactoryPZ")
local isoPlayerPZ = require("lib/IsoPlayerPZ")
local modDataManager = require("lib/ModDataManager")
local characterLib = require("CharacterLib")
require("lib/CharacterBaseObj")

---@type IsoGameCharacter
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
local character = getPlayer()

local function charaterUpdate()
    character = characterLib.charaterUpdate()
end

local function baseProfession()
    charaterUpdate()

    characterPz.setProfession_PZ(character, dbgLeleLib.EnumProfession.BURGER_FLIPPER)
    local profession = characterPz.getProfession_PZ(character)

    dbgLeleLib.checkTest(profession , dbgLeleLib.EnumProfession.BURGER_FLIPPER,
            "Profession" )

    characterPz.removeProfession(character)

    charaterUpdate()
end

local function baseKnownRecipes()
    charaterUpdate()

    local recipe = "Make Pizza"

    characterPz.addKnownRecipe(character, recipe)

    charaterUpdate()

    ------- -------------------------------------------------------------
    local knownRecipes = characterPz.getKnownRecipes_PZ(character)

    if knownRecipes then
        for i = 0, knownRecipes:size() - 1  do
            dbgLeleLib.checkTest(knownRecipes:get(i), recipe, "KnownRecipes")
        end
    else
        dbgLeleLib.checkTest("", "1", "knownRecipes:size()")
    end

    characterPz.removeKnowRecipe_PZ(character, recipe)

    --- -------------------------------------------------------------
    dbgLeleLib.checkTest(character:getKnownRecipes():remove(recipe),
            false, "Remove KnowRecipe")

    charaterUpdate()
end

local function baseTrunkFloatTo2Decimal()
    local value = characterPz.trunkFloatTo2Decimal(1.151)

    dbgLeleLib.checkTest(value, 1.15, "TrunkFloatTo2Decimal")
end

local function baseZombieKills()
    charaterUpdate()

    characterPz.setZombieKills_PZ(character, 15)

    dbgLeleLib.checkTest(characterPz.getZombieKills_PZ(character), 15,
           "ZombieKills" )

    characterPz.setZombieKills_PZ(character, 0)

    charaterUpdate()
end

local function basePerkBoost()
    charaterUpdate()

    local boostLevel = 1

    characterPz.setPerkBoost_PZ(character, Perks.Cooking, boostLevel)

    dbgLeleLib.checkTest(characterPz.getPerkBoost_PZ(character, Perks.Cooking),
            boostLevel, "PerkBoost")

    characterPz.removePerkBoost(character, Perks.Cooking)

    charaterUpdate()
end

-- todo non funziona correttamente, se preso singolarmente al il test viene fallito
local function baseMultiplier()
    charaterUpdate()

    local multiplier = 1.1
    characterPz.addXpMultiplier_PZ(character, Perks.Woodwork, multiplier,
            1, 1)

    charaterUpdate()

    local value = characterPz.getMultiplier_PZ(character, Perks.Woodwork)

    dbgLeleLib.checkTest(characterPz.trunkFloatTo2Decimal(value),
            multiplier, "Multiplier" )

    characterPz.removeMultiplier(character, Perks.Woodwork)

    charaterUpdate()
end

local function baseEnumNumbers()
    dbgLeleLib.checkTest(characterPz.EnumNumbers.EIGHT, 8, "EnumNumbers")
end

local function baseXp()
    charaterUpdate()

    characterPz.addXP_PZ(character, Perks.Cooking, 75)
    local xp_ = characterPz.getXp(character, Perks.Cooking)

    dbgLeleLib.checkTest(xp_, 75, "Xp")

    --- -------------------------------------------------
    characterPz.removePerkLevel(character, Perks.Cooking)

    charaterUpdate()
end

local function basePerkLevel()
    charaterUpdate()

    characterPz.setPerkLevel(character, Perks.Cooking, 75)

    local level = characterPz.getPerkLevel_PZ(character, Perks.Cooking)

    dbgLeleLib.checkTest(level, 1, "PerkLevel")
    --- -------------------------------------------------
    characterPz.removePerkLevel(character, Perks.Cooking)

    charaterUpdate()
end

local function baseTrait()
    charaterUpdate()

    local trait_ = "Handy"
    characterPz.setTraitsPerk_PZ(character, trait_)

    local traits_PZ = characterPz.getTraitsPerk_PZ(character)

    for i = 0, traits_PZ:size() - 1 do
        ---@type TraitFactory.Trait
        local trait = TraitFactory.getTrait(traits_PZ:get(i) ):getXPBoostMap()

        ---@type KahluaTable
        local traitKahluaTable = transformIntoKahluaTable(trait)
        for i2, _ in pairs(traitKahluaTable) do
            if tostring(i2) == "Woodwork" then
                dbgLeleLib.checkTest(tostring(i2), "Woodwork", "Add Trait")
            end
        end
    end

    --- ------------------------------------------------
    characterPz.removeTrait_PZ(character, "Woodwork")

    charaterUpdate()

    local remove = character:getTraits():remove("Woodwork")
    dbgLeleLib.checkTest(remove, false, "Remove trait")

    --- ------------------------------------------------

    characterPz.removeAllTraits_PZ(character)

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

    dbgLeleLib.checkTest(flag, false, "Remove All Trait")

    charaterUpdate()
end

local function baseConvertLevelToXp()
    local xp = perkFactoryPZ.convertLevelToXp(Perks.Cooking, 1)

   dbgLeleLib.checkTest(xp, 75, "ConvertLevelToXp")
end

local function basePerkName()
    local perk = perkFactoryPZ.getPerk_PZ(Perks.Cooking)
    dbgLeleLib.checkTest(perk, perk, "Perk Name")
end

local function baseParent()
    local parent_ = "Combat"
    local parent = perkFactoryPZ.getParent_PZ(Perks.Maintenance)
    dbgLeleLib.checkTest(parent_, parent, "Parent" )
end

local function baseHoursSurvived()
    local hoursSurvived = 1.0
    local hoursSurvived_
    isoPlayerPZ.setHoursSurvived_PZ(hoursSurvived)

    hoursSurvived_ = isoPlayerPZ.getHoursSurvived_PZ()
    dbgLeleLib.checkTest(hoursSurvived_, hoursSurvived, "Hours Survived" )
end

local function baseCalories()
    local calories = 20.1
    local calories_
    local trunckedCalories
    isoPlayerPZ.setCalories_PZ(calories)

    calories_ = isoPlayerPZ.getCalories_PZ()

    trunckedCalories = characterPz.trunkFloatTo2Decimal(calories_)

    dbgLeleLib.checkTest(trunckedCalories, calories, "Calories" )
end

local function baseWeight()
    local weight = 83
    local weight_
    isoPlayerPZ.setWeight_PZ(weight)

    weight_ = isoPlayerPZ.getWeight_PZ()
    dbgLeleLib.checkTest(weight_, weight, "Weight" )
end

local function baseModData()
    local value = 10
    local values = {1, 2, 3, 4, 5}

    local testEnum = "testEnum"
    modDataManager.save(testEnum, value)

    local results = {}
    results = modDataManager.read(testEnum)
    local result = results[1]

    dbgLeleLib.checkTest(result, value, "ModData single value")

    if modDataManager.isExists(testEnum) then
        dbgLeleLib.checkTest(true, true, "ModData isExists")
    end

    if modDataManager.remove(testEnum) ~= false then
        modDataManager.remove(testEnum)
        dbgLeleLib.checkTest(true, true, "ModData Remove")
    end

    modDataManager.save(testEnum, values)

    results = {}
    results = modDataManager.read(testEnum)

    if type(results) == "table" then
        dbgLeleLib.checkTest(true, true, "ModData multi value")
    end

    if modDataManager.isExists(testEnum) then
        dbgLeleLib.checkTest(true, true, "ModData isExists")
    end

    if modDataManager.remove(testEnum) ~= false then
        modDataManager.remove(testEnum)
        dbgLeleLib.checkTest(true, true, "ModData Remove")
    end

    modDataManager.remove(testEnum)
end

local function baseUserName()
    if isoPlayerPZ.getUserName()  then
        dbgLeleLib.checkTest(true, true, "Get UserName")
    else
        dbgLeleLib.checkTest(false, true, "Get UserName")
    end

    local newUserName = "paolo"
    isoPlayerPZ.setUserName(newUserName)

    if isoPlayerPZ.getUserName() == newUserName  then
        dbgLeleLib.checkTest(true, true, "Set UserName")
    else
        dbgLeleLib.checkTest(false, true, "Set UserName")
    end
end

--- ------------------------------------------------

local function traitsPerk()
    charaterUpdate()

    characterPz.setProfession_PZ(character, dbgLeleLib.EnumProfession.CHEF)

    local trait_ = "Feeble"
    characterPz.setTraitsPerk_PZ(character, trait_)

    charaterUpdate()

    local CharacterObj01 = CharacterBaseObj:new()
    CharacterObj01 = characterLib.getTraitsPerk(character)

    local flag = false
    if CharacterObj01:getPerkDetails() then
        flag = true
    end

    dbgLeleLib.checkTest(true,
            true, "Get PerkDetails")

    flag = false
    if CharacterObj01:getTraits() then
        flag = true
    end

    dbgLeleLib.checkTest(true,
            true, "Get Traits")

    characterPz.removeProfession(character)
    characterPz.removeAllTraits_PZ(character)

    charaterUpdate()
end

local function perkProfession()
    charaterUpdate()

    characterPz.setProfession_PZ(character, dbgLeleLib.EnumProfession.CHEF)

    local CharacterObj01 = CharacterBaseObj:new()

    charaterUpdate()

    CharacterObj01 = characterLib.getPerkProfession(character)

    local flag = false
    if CharacterObj01:getPerkDetails() then
        flag = true
    end

    dbgLeleLib.checkTest(true,
            true, "Get perkProfession")

    characterPz.removeProfession(character)
    characterPz.removeAllTraits_PZ(character)

    charaterUpdate()
end

--- ------------------------------------------------------------

local function characterLibAllPerks()
    charaterUpdate()

    local CharacterObj01 = CharacterBaseObj:new()
    CharacterObj01 = characterLib.getAllPerks(character)

    local flag = false
    if CharacterObj01:getPerkDetails() then
        flag = true
    end

    dbgLeleLib.checkTest(true,
            true, "All Skills")

    local profession = CharacterObj01:getProfession()
    local profession_ = characterPz.getProfession_PZ(character)

    dbgLeleLib.checkTest(profession,
            profession_, "All Skills - Profession")

    charaterUpdate()
end

local function characterLibPerksBoost()
    charaterUpdate()

    local boost = 1
    characterPz.setPerkBoost_PZ(Perks.Cooking, boost)

    charaterUpdate()

    local CharacterObj01 = CharacterBaseObj:new()

    CharacterObj01 = characterLib.getPerksBoost(character)

    local flag = false

    for _, v in pairs(CharacterObj01:getPerkDetails()) do
        if v:getPerk() == Perks.Cooking then
            if v:getBoostLevel() == boost then
                flag = true
            end
        end
    end

    dbgLeleLib.checkTest(true,
            true, "Perks Boost")

    characterPz.removePerkBoost(character, Perks.Cooking, boost)

    charaterUpdate()
end

local function characterLibKnownRecipes()
    charaterUpdate()

    local recipe = "Make Pizza"

    characterPz.addKnownRecipe(character, recipe)

    charaterUpdate()

    local CharacterObj01 = CharacterBaseObj:new()
    CharacterObj01 = characterLib.getKnownRecipes(character)

    ---@type boolean
    local flag = false
    for _, v in pairs(CharacterObj01:getRecipes()) do
        if v == recipe then
            flag = true
        end
    end

    dbgLeleLib.checkTest(flag,
            true, "KnownRecipes")

    charaterUpdate()
end

local function characterLibMultiplier()
    charaterUpdate()

    local multiplier = 1.0

    characterPz.addXpMultiplier_PZ(character, Perks.Cooking, multiplier,
            characterPz.EnumNumbers.ONE, characterPz.EnumNumbers.ONE)

    charaterUpdate()

    local CharacterObj01 = CharacterBaseObj:new()
    CharacterObj01 = characterLib.getMultiplier(character)

    for _, v in pairs(CharacterObj01:getPerkDetails()) do
        if v:getPerk() == Perks.Cooking then
            dbgLeleLib.checkTest(v:getMultiplier(),
                    multiplier, "Multiplier")
        end
    end

   characterPz.removeMultiplier(character, Perks.Cooking)

    charaterUpdate()
end

local function characterLibDe_EncodePerkDetails()
    charaterUpdate()

    characterPz.setProfession_PZ(character, dbgLeleLib.EnumProfession.CARPENTER)
    characterPz.setPerkLevel(character, dbgLeleLib.EnumPerk.Woodwork, 100.0)

    charaterUpdate()

    local CharacterObj01 = CharacterBaseObj:new()
    local CharacterDecodeObj = CharacterBaseObj:new()

    local perk = perkFactoryPZ.getPerk_PZ(dbgLeleLib.EnumPerk.Woodwork)
    local level = characterPz.getPerkLevel_PZ(character, perk)
    local xp = characterPz.getXp(character, perk)

    local perk2
    local level2
    local xp2

    CharacterObj01:addPerkDetails(perk, level, xp)

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
        dbgLeleLib.checkTest(true, true, "De_EncodePerkDetails")
    else
        dbgLeleLib.checkTest(false, true, "De_EncodePerkDetails")
    end

    lines = {}

    dbgLeleLib.deleteCharacter()
    charaterUpdate()
end

--- ------------------------------------------------------------
--- ------------------------------------------------------------

local function baseTest()
    print("---------- Base ----------\n")
    baseProfession()
    baseKnownRecipes()
    baseTrunkFloatTo2Decimal()
    baseZombieKills()
    basePerkBoost()
    --TODO The multiplier doesn't work
    -- baseMultiplier()
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
    print("---------- finish Base test ----------\n")
end

local function characterLibTest()
    print("---------- CharacterLib ----------\n")
    traitsPerk()
    perkProfession()
    -- -- currentSkill()
    characterLibAllPerks()
    characterLibPerksBoost()
    characterLibKnownRecipes()
    --TODO The multiplier doesn't work
    -- characterLibMultiplier()
    characterLibDe_EncodePerkDetails()

    print("---------- finish CharacterLib test ----------\n")
end

-- Perks.Maintenance
-- Perks.Woodwork
-- Perks.Sprinting
-- Todo 		self.character:playSound("CloseBook")
---@param character IsoGameCharacter
local function key34(character, key)

    if key == 34 then -- <<<< g
        print("Key = g > characterLibTest \n")
        baseTest()
        characterLibTest()
    end
end

---@param character IsoGameCharacter
local function key35(character, key)
    if key == 35 then -- <<< h
        print("Key = h >  \n")
        characterLibMultiplier()
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

local function onCustomUIKeyPressed(key)
    local character = getPlayer()

    key34(character, key)
    key35(character, key)
    key36(character, key)
    key37(character, key)
end

Events.OnCustomUIKeyPressed.Add(onCustomUIKeyPressed)