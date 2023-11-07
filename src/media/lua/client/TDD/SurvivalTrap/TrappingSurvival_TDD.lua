---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by lele.
--- DateTime: 26/04/23 17:41
---

local bird = require("Bird")
local mouse = require("Mouse")
local rabbit = require("Rabbit")
local rat = require("Rat")
local squirrel = require("Squirrel")

local debugDiagnostics = require("lib/DebugDiagnostics")

local function checkSandBox()
    --- **Check SandboxVars 1 is default value**
    ---@type int
    local expectedDefaultValue = 1
    debugDiagnostics.checkTest(expectedDefaultValue, SandboxVars.TrappingSurvival.Bird, "SandBox - Bird" )
    debugDiagnostics.checkTest(expectedDefaultValue, SandboxVars.TrappingSurvival.BirdSize, "SandBox - Bird Size" )
    debugDiagnostics.checkTest(expectedDefaultValue, SandboxVars.TrappingSurvival.Mouse, "SandBox - Mouse" )
    debugDiagnostics.checkTest(expectedDefaultValue, SandboxVars.TrappingSurvival.MouseSize, "SandBox - Mouse Size" )
    debugDiagnostics.checkTest(expectedDefaultValue, SandboxVars.TrappingSurvival.Rabbit, "SandBox - Rabbit" )
    debugDiagnostics.checkTest(expectedDefaultValue, SandboxVars.TrappingSurvival.RabbitSize, "SandBox - Rabbit Size" )
    debugDiagnostics.checkTest(expectedDefaultValue, SandboxVars.TrappingSurvival.Rat, "SandBox - Rat" )
    debugDiagnostics.checkTest(expectedDefaultValue, SandboxVars.TrappingSurvival.RatSize, "SandBox - Rat Size" )
    debugDiagnostics.checkTest(expectedDefaultValue, SandboxVars.TrappingSurvival.Squirrel, "SandBox - Squirrel" )
    debugDiagnostics.checkTest(expectedDefaultValue, SandboxVars.TrappingSurvival.SquirrelSize, "SandBox - Squirrel Size" )
end

local function funcName()
    
end

---@param character IsoGameCharacter
local function key34(character, key)
    if key == 34 then -- <<<< g
        print("Key = g >  \n")
        local bird = bird.getBird()

        for i, v in pairs(bird) do
            if type(v) == "table" then
                print("--------------------")
                for i2, v2 in pairs(v) do
                    print(i2, " " .. tostring(v2))
                end
                print("--------------------")
            else
                print(i, " " .. tostring(v))
            end
        end
        local dbg
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
