require("Timers")
LinkLuaModifier( "ai_modifier_common_creep", "ai/ai_modifier_common_creep", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "ai_modifier", "ai/ai_modifier", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "ai_modifier_spider_queen", "ai/ai_modifier_spider_queen", LUA_MODIFIER_MOTION_NONE )
if SpawnManager == nil then
    SpawnManager = {}
end


function SpawnManager:ContainsInList(item, list)

    for i, value in ipairs(list) do
        if value == item then
            return true
        end
    end

    return false

end


function SpawnManager:SpawnUnitsAtSpawner(spawnerentity, unit, vector)
    local spawner = Entities:FindByName(nil, spawnerentity)
    local unit = unit 
    local vector = vector

    CreateUnitByName(unit, spawner:GetAbsOrigin() + vector, true, nil, nil, DOTA_TEAM_NEUTRALS)
end


function SpawnManager:ActivateAllSpawnersByName(spawnername, unit)
    local spawner = spawnername
    local unit = unit
    spawner_list = Entities:FindAllByName(spawner)

    for i, spawner in ipairs(spawner_list) do
        if next(FindUnitsInRadius( DOTA_TEAM_NEUTRALS, spawner:GetAbsOrigin(),nil, 150.0,DOTA_UNIT_TARGET_TEAM_FRIENDLY,DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)) == nil then
            local spawnedunit = CreateUnitByName(unit, spawner:GetAbsOrigin(), true, nil, nil, DOTA_TEAM_NEUTRALS)
            spawnedunit:AddNewModifier(nil, nil, "ai_modifier_common_creep", { aggroRange = 600, leashRange = 800 })
        end
    end            

end

function SpawnManager:ActivateBossSpawners(spawner, unit)
    local spawner = spawner
    local unit = unit
    spawner_list = Entities:FindAllByName(spawner)
    for i, spawner in ipairs(spawner_list) do
        if SpawnManager:ContainsInList(spawnedunit, FindUnitsInRadius(DOTA_TEAM_NEUTRALS, spawner:GetAbsOrigin(),nil, FIND_UNITS_EVERYWHERE,DOTA_UNIT_TARGET_TEAM_FRIENDLY,DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)) == false  then
            spawnedunit = CreateUnitByName(unit, spawner:GetAbsOrigin(), true, nil, nil, DOTA_TEAM_NEUTRALS)
            if spawnedunit:GetUnitName() == "npc_dota_creature_spider_queen"	then
                print(spawnedunit:GetUnitName())
                spawnedunit:AddNewModifier(nil, nil, "ai_modifier_spider_queen", { aggroRange = 600, leashRange = 1600 }) 
            else
                print("else")
                spawnedunit:AddNewModifier(nil, nil, "ai_modifier", { aggroRange = 600, leashRange = 1600 })   
            end
        end
    end      


end

function SpawnManager:ActivateSpawners( kvinfo )
    local kvinfocreeps = kvinfo["common_creeps"]
    local kvinfobosses = kvinfo["Bosses"]


    Timers:CreateTimer(function()
        for spawner, unit in pairs(kvinfocreeps) do
            SpawnManager:ActivateAllSpawnersByName(spawner, unit)
        end

        for bossspawner, boss in pairs(kvinfobosses) do
            SpawnManager:ActivateBossSpawners(bossspawner, boss)
        end
        return 30.0
    end)

end

