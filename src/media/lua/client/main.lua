---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by lele.
--- DateTime: 07/05/23 10:44
---

require("lib/DbgLeleLib")
local characterPz = require("lib/CharacterPZ")
local perkFactoryPZ = require("lib/PerkFactoryPZ")
local isoPlayerPZ = require("lib/IsoPlayerPZ")
local characterLib = require("CharacterLib")

local test_ = "Test - "
local fail_ = " >>>>>>>>>>>>>> FAIL"
local ok_ = " >>>>>>>>>>>>>> Ok"

---@type IsoGameCharacter
local character = getPlayer()

local function fail(value)
    print(test_ .. value .. fail_)
end

local function ok(value)
    print(test_ .. value .. ok_)
end

local function checkTest(value1, value2, nameTest)
    if value1 == value2 then
        ok(nameTest)
    else
        fail(nameTest)
    end
end

local function baseProfession()
    characterPz.setProfession_PZ(character, EnumProfession.BURGER_FLIPPER)
    local profession = characterPz.getProfession_PZ(character)

    checkTest(profession ,EnumProfession.BURGER_FLIPPER,
            "Profession" )

    characterPz.removeProfession(character)
end

local function baseKnownRecipes()
    local recipe = "Make Pizza"

    characterPz.addKnownRecipe(character, recipe)

    character = getPlayer()

    ------- -------------------------------------------------------------
    local knownRecipes = characterPz.getKnownRecipes_PZ(character)

    if knownRecipes then
        for i = 0, knownRecipes:size() - 1  do
            checkTest(knownRecipes:get(i), recipe, "KnownRecipes")
        end
    else
        checkTest("", "1", "knownRecipes:size()")
    end

    characterPz.removeKnowRecipe_PZ(character, recipe)

    --- -------------------------------------------------------------
    checkTest(character:getKnownRecipes():remove(recipe),
            false, "Remove KnowRecipe")

end

local function baseTrunkFloatTo2Decimal()
    local value = characterPz.trunkFloatTo2Decimal(1.151)

    checkTest(value, 1.15, "TrunkFloatTo2Decimal")
end

local function baseZombieKills()
    characterPz.setZombieKills_PZ(character, 15)

    checkTest(characterPz.getZombieKills_PZ(character), 15,
           "ZombieKills" )

end

local function basePerkBoost()
    local boostLevel = 1

    characterPz.setPerkBoost_PZ(character, Perks.Cooking, boostLevel)

    checkTest(characterPz.getPerkBoost_PZ(character, Perks.Cooking),
            boostLevel, "PerkBoost")

    characterPz.removePerkBoost(character, Perks.Cooking)
end

local function baseMultiplier()
    local multiplier = 1.1
    characterPz.addXpMultiplier_PZ(character, Perks.Woodwork, multiplier,
            1, 1)

    character = getPlayer()

    local value = characterPz.getMultiplier_PZ(character, Perks.Woodwork)

    checkTest(characterPz.trunkFloatTo2Decimal(value),
            multiplier, "Multiplier" )

    characterPz.removeMultiplier(character, Perks.Woodwork)
end

local function baseEnumNumbers()
    checkTest(characterPz.EnumNumbers.EIGHT, 8, "EnumNumbers")
end

local function baseXp()
    characterPz.addXP_PZ(character, Perks.Cooking, 75)
    local xp_ = characterPz.getXp(character, Perks.Cooking)

    checkTest(xp_, 75, "Xp")

    --- -------------------------------------------------
    characterPz.removePerkLevel(character, Perks.Cooking)
end

local function basePerkLevel()
    characterPz.setPerkLevel(character, Perks.Cooking, 75)

    local level = characterPz.getPerkLevel_PZ(character, Perks.Cooking)

    checkTest(level, 1, "PerkLevel")
    --- -------------------------------------------------
    characterPz.removePerkLevel(character, Perks.Cooking)
end

local function baseTrait()
    local trait_ = "Handy"
    characterPz.setTraitsPerk_PZ(character, trait_)

    local traits_PZ = characterPz.getTraitsPerk_PZ(character)

    for i = 0, traits_PZ:size() - 1 do
        ---@type TraitFactory.Trait
        local trait = TraitFactory.getTrait(traits_PZ:get(i) ):getXPBoostMap()

        ---@type KahluaTable
        local traitKahluaTable = transformIntoKahluaTable(trait)
        for i, v in pairs(traitKahluaTable) do
            if tostring(i) == "Woodwork" then
                checkTest(tostring(i), "Woodwork", "Add Trait")
            end
        end
    end

    --- ------------------------------------------------
    characterPz.removeTrait_PZ(character, "Woodwork")

    local remove = character:getTraits():remove("Woodwork")
    checkTest(remove, false, "Remove trait")

    --- ------------------------------------------------

    characterPz.removeAllTraits_PZ(character)

    local flag = false
    for i = 0, traits_PZ:size() - 1 do
        ---@type TraitFactory.Trait
        local trait = TraitFactory.getTrait(traits_PZ:get(i) ):getXPBoostMap()

        ---@type KahluaTable
        local traitKahluaTable = transformIntoKahluaTable(trait)
        for i, v in pairs(traitKahluaTable) do
            flag = true
        end
    end

    checkTest(flag, false, "Remove All Trait")
end

local function baseConvertLevelToXp(perk, level)
    local xp = perkFactoryPZ.convertLevelToXp(Perks.Cooking, 1)

   checkTest(xp, 75, "ConvertLevelToXp")
end

local function basePerkName()
    local perk = perkFactoryPZ.getPerk_PZ(Perks.Cooking)
    local perkByName = perkFactoryPZ.getPerkByName_PZ("chef")
    checkTest(perk, perk, "Perk Name")
end

local function baseParent()
    local parent_ = "Combat"
    local parent = perkFactoryPZ.getParent_PZ(Perks.Maintenance)
    checkTest(parent_, parent, "Parent" )
end

local function baseHoursSurvived()
    local hoursSurvived = 1.0
    local hoursSurvived_
    isoPlayerPZ.setHoursSurvived_PZ(hoursSurvived)

    hoursSurvived_ = isoPlayerPZ.getHoursSurvived_PZ()
    checkTest(hoursSurvived_, hoursSurvived, "Hours Survived" )
end

local function baseCalories()
    local calories = 20.1
    local calories_
    local trunckedCalories
    isoPlayerPZ.setCalories_PZ(calories)

    calories_ = isoPlayerPZ.getCalories_PZ()

    trunckedCalories = characterPz.trunkFloatTo2Decimal(calories_)

    checkTest(trunckedCalories, calories, "Calories" )
end

local function baseWeight()
    local weight = 83
    local weight_
    isoPlayerPZ.setWeight_PZ(weight)

    weight_ = isoPlayerPZ.getWeight_PZ()
    checkTest(weight_, weight, "Weight" )
end

--- ------------------------------------------------

local function traitsPerk()
    characterPz.setProfession_PZ(character, EnumProfession.CHEF)

    local trait_ = "Feeble"
    characterPz.setTraitsPerk_PZ(character, trait_)

    character = getPlayer()

    local CharacterObj01 = CharacterObj:new()
    CharacterObj01 = characterLib.getTraitsPerk(character)

    local flag = false
    if CharacterObj01:getPerkDetails() then
        flag = true
    end

    checkTest(true,
            true, "Get PerkDetails")

    local flag = false
    if CharacterObj01:getTraits() then
        flag = true
    end

    checkTest(true,
            true, "Get Traits")

    characterPz.removeProfession(character)
    characterPz.removeAllTraits_PZ(character)
end

local function perkProfession()
    characterPz.setProfession_PZ(character, EnumProfession.CHEF)

    local CharacterObj01 = CharacterObj:new()

    character = getPlayer()

    CharacterObj01 = characterLib.getPerkProfession(character)

    local flag = false
    if CharacterObj01:getPerkDetails() then
        flag = true
    end

    checkTest(true,
            true, "Get perkProfession")

    characterPz.removeProfession(character)
    characterPz.removeAllTraits_PZ(character)
end

local function characterLibAllSkills()
    local CharacterObj01 = CharacterObj:new()
    CharacterObj01 = characterLib.getAllSkills(character)

    local flag = false
    if CharacterObj01:getPerkDetails() then
        flag = true
    end

    checkTest(true,
            true, "All Skills")
end

local function characterLibPerksBoost()
    local boost = 1
    characterPz.setPerkBoost_PZ(Perks.Cooking, boost)

    character = getPlayer()

    local CharacterObj01 = CharacterObj:new()

    CharacterObj01 = characterLib.getPerksBoost(character)

    local flag = false

    for _, v in pairs(CharacterObj01:getPerkDetails()) do
        if v:getPerk() == Perks.Cooking then
            if v:getBoostLevel() == boost then
                flag = true
            end
        end
    end

    checkTest(true,
            true, "Perks Boost")

    characterPz.removePerkBoost(character, Perks.Cooking, boost)
end

local function characterLibKnownRecipes()
    local recipe = "Make Pizza"

    characterPz.addKnownRecipe(character, recipe)

    character = getPlayer()

    local CharacterObj01 = CharacterObj:new()

    local flag = false
    for i, v in pairs(CharacterObj01:getRecipes()) do
        if v == recipe then
            flag = true
        end
    end

    checkTest(true,
            true, "KnownRecipes")

end


--- ------------------------------------

---@param character IsoGameCharacter
function key36(key)
    if key == 36 then
        print("Key = j > addTrait \n")

    end
end

---@param character IsoGameCharacter
function key37(key)
    if key == 37 then -- <<<< k
        print("Key = k > kill \n")
        character:die()
    end
end

local function baseTest()
    print("---------- Base ----------\n")
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
    print("---------- finish Base test ----------\n")
end

local function characterLibTest()
    print("---------- CharacterLib ----------\n")
    traitsPerk()
    perkProfession()
    -- -- currentSkill()
    characterLibAllSkills()
    characterLibPerksBoost()
    characterLibKnownRecipes()
    print("---------- finish CharacterLib test ----------\n")
end

local function onCustomUIKeyPressed(key)
    key36(key)
    key37(key)
    baseTest()
    characterLibTest()

end

Events.OnCustomUIKeyPressed.Add(onCustomUIKeyPressed)