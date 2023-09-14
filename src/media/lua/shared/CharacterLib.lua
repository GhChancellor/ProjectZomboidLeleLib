---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by lele.
--- DateTime: 08/05/23 21:28
---

---@class CharacterLib

require("lib/CharacterBaseObj")
local characterPz = require("lib/CharacterPZ")
local perkFactoryPZ = require("lib/PerkFactoryPZ")

local CharacterLib = {}

--- **Get Character Traits Perk**
---@param character IsoGameCharacter
---@return CharacterBaseObj table - PerkFactory.Perk perk, int level
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
function CharacterLib.getTraitsPerk(character)
    if not character then
        return nil
    end

    ---@type CharacterBaseObj
    local CharacterObj01 = CharacterBaseObj:new()

    ---@type List
    local traits_PZ = characterPz.getTraitsPerk_PZ(character)

    for i = 0, traits_PZ:size() - 1 do

        ---@type TraitFactory.Trait
        local trait = TraitFactory.getTrait(traits_PZ:get(i) )

        CharacterObj01:addTrait( trait:getType() )

        ---@type TraitFactory.Trait
        local traitMap = trait:getXPBoostMap()

        ---@type KahluaTable
        local traitKahluaTable = transformIntoKahluaTable(traitMap)

        for perk, level in pairs(traitKahluaTable) do
            CharacterObj01:addPerkDetails(perk, level:intValue(), nil)
        end
    end

    return CharacterObj01
end

--- **Get Character Profession**
---@param character IsoGameCharacter
---@return CharacterBaseObj getPerkDetails() -- table PerkFactory.Perk perk, int level, float xp
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
function CharacterLib.getPerkProfession(character)
    if not character then
        return nil
    end

    ---@type CharacterBaseObj
    local CharacterObj01 = CharacterBaseObj:new()

    ---@type SurvivorDesc
    local profession = characterPz.getProfession_PZ(character)

    ---@type ProfessionFactory
    local professionMap = ProfessionFactory.getProfession(profession):getXPBoostMap()

    ---@type KahluaTable
    local professionKahluaTable = transformIntoKahluaTable(professionMap)

    for perk, level in pairs(professionKahluaTable) do
        CharacterObj01:addPerkDetails(perk, level:intValue(), nil)
    end

    CharacterObj01:setProfession(profession)

    return CharacterObj01
end

---@deprecated
--- **Get character and get current skill/trait**
---@param character IsoGameCharacter
---@param perk PerkFactory.Perk
---@return PerkDetailsObj getPerkDetailsObj()
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
--- - PerkFactory.Perk : zombie.characters.skills.PerkFactory
function CharacterLib.getCurrentSkill(character, perk)
    -- Perks.Maintenance
    -- Perks.Woodwork
    -- Perks.Sprinting
    if not character then
        return nil
    end

    ---@type CharacterBaseObj
    local CharacterObj01 = CharacterBaseObj:new()

    ---@type SurvivorDesc
    local profession = characterPz.getProfession_PZ(character)

    ---@type PerkFactory
    local perk_ = perkFactoryPZ.getPerk_PZ(perk)

    ---@type int
    local level = characterPz.getPerkLevel_PZ(character, perk_)

    ---@type double
    local xp = characterPz.getXp(character, perk_)

    CharacterObj01:currentCharacter(profession, perk_, level:intValue(), xp)

    return CharacterObj01
end

--- **Get character and get All skills/traits**
---@param character IsoGameCharacter
---@return CharacterBaseObj getPerkDetails() -- table PerkFactory.Perk perk, int level, float xp
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
function CharacterLib.getAllPerks(character)
    if not character then
        return nil
    end

    ---@type CharacterBaseObj
    local CharacterObj01 = CharacterBaseObj:new()

    for i = 0, Perks.getMaxIndex() - 1 do

        ---@type PerkFactory.Perks
        local perk = perkFactoryPZ.getPerk_PZ(Perks.fromIndex(i))

        ---@type int
        local level = characterPz.getPerkLevel_PZ(character, perk)

        ---@type double
        local xp = characterPz.getXp(character, perk)

        -- Add to objects
        CharacterObj01:addPerkDetails(perk, level, xp)
    end

    CharacterObj01:setProfession(characterPz.getProfession_PZ(character))

    return CharacterObj01
end

--- **Get character Multiplier**
---@param character IsoGameCharacter
---@return CharacterBaseObj getPerkDetails() -- table PerkFactory.Perk perk, int level, float xp
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
function CharacterLib.getMultiplier(character)
    if not character then
        return nil
    end

    ---@type CharacterBaseObj
    local CharacterObj01 = CharacterBaseObj:new()
    CharacterObj01 = CharacterLib.getAllPerks(character)

    for _, v in pairs(CharacterObj01:getPerkDetails()) do
        local multiplier = characterPz.getMultiplier_PZ(character, v:getPerk())
        v:setMultiplier(characterPz.trunkFloatTo2Decimal(multiplier))
    end

    return CharacterObj01
end

--- **Get character Perks Boosts**
---@param character IsoGameCharacter
---@return CharacterBaseObj getPerkDetails() -- table PerkFactory.Perk perk, int level, float xp
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
function CharacterLib.getPerksBoost(character)
    if not character then
        return nil
    end

    ---@type CharacterBaseObj
    local CharacterObj01 = CharacterBaseObj:new()
    CharacterObj01 = CharacterLib.getAllPerks(character)

    for _, v in pairs(CharacterObj01:getPerkDetails()) do
        ---@type int
        local boost = characterPz.getPerkBoost_PZ(character, v:getPerk())
        v:setBoostLevel(boost)
    end

    return CharacterObj01
end

--- **Get Character Known Recipes**
---@param character IsoGameCharacter
---@return CharacterBaseObj getRecipes()
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
function CharacterLib.getKnownRecipes(character)
    if not character then
        return nil
    end

    ---@type CharacterBaseObj
    local CharacterObj01 = CharacterBaseObj:new()
    ---@type List
    local knowRecipes = characterPz.getKnownRecipes_PZ(character)

    for i = 0, knowRecipes:size() - 1 do
        CharacterObj01:addRecipe(knowRecipes:get(i))
    end

    return CharacterObj01
end

--- **Encode Perk Details convert the CharaterObj into a table. The ModData only accepts a table**
---@param characterObj CharacterBaseObj
---@return table
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
function CharacterLib.encodePerkDetails(characterObj)
    if not characterObj then
        return nil
    end

    ---@type table
    local lines = {}

    ---@param perk PerkFactory.Perk
    ---@param level int
    ---@param xp float
    for _, v in pairs(characterObj:getPerkDetails()) do
        local value = ( v.perk:getName() .. "-" ..
                tostring(v:getLevel())  .. "-" ..
                tostring(v:getXp()))

        table.insert(lines, value)
    end

    return lines
end

--- **Decode Perk Details convert a table into CharacterObj**
---@param characterPerkDetails table
---@return CharacterBaseObj getPerkDetails()
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
function CharacterLib.decodePerkDetails(characterPerkDetails)
    if not characterPerkDetails then
        return nil
    end

    ---@type CharacterBaseObj
    local CharacterObj01 = CharacterBaseObj:new()

    ---@type table
    local lines = {}

    for _, v in pairs(characterPerkDetails) do
        for s in v:gmatch("[^\r-]+") do
            table.insert(lines, s)
        end

        -- perk, level, xp
        CharacterObj01:addPerkDetails(perkFactoryPZ.getPerkByName_PZ(lines[1]),
                tonumber(lines[2]),
                tonumber(lines[3]) + 0.0)

        lines = {}
    end

    return CharacterObj01
end

--- **Update all the characteristics of the character**
function CharacterLib.charaterUpdate()
    return getPlayer()
end

return CharacterLib