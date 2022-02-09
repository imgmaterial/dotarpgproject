require("SaveLoadManager")
require("SpawnManager")

-- Generated from template
if CAddonTemplateGameMode == nil then
	CAddonTemplateGameMode = class({})
end

function Precache( context )
	--[[
		Precache things we know we'll use.  Possible file types include (but not limited to):
			PrecacheResource( "model", "*.vmdl", context )
			PrecacheResource( "soundfile", "*.vsndevts", context )
			PrecacheResource( "particle", "*.vpcf", context )
			PrecacheResource( "particle_folder", "particles/folder", context )
	]]
end


-- Create the game mode when we activate
function Activate()
	GameRules.AddonTemplate = CAddonTemplateGameMode()
	GameRules.AddonTemplate:InitGameMode()
end

function CAddonTemplateGameMode:InitGameMode()
	print( "Template addon is loaded." )
	GameRules:GetGameModeEntity():SetThink( "OnThink", self, "GlobalThink", 2 )

	GameRules.DropTable = LoadKeyValues("scripts/kv/Drops.kv")

	GameRules.SpawnerPairs = LoadKeyValues("scripts/kv/spawners.kv")

	ListenToGameEvent('entity_killed', Dynamic_Wrap(CAddonTemplateGameMode, 'OnEntityKilled'), self)

	ListenToGameEvent('player_chat', Dynamic_Wrap(CAddonTemplateGameMode, 'OnPLayerChat'), self)

	GameRules:SetCustomGameSetupTimeout(0) 

	PlayerResource:SetCustomTeamAssignment( 0, DOTA_TEAM_GOODGUYS )

	SpawnManager:ActivateSpawners(GameRules.SpawnerPairs)

end




-- Evaluate the state of the game
function CAddonTemplateGameMode:OnThink()

	if GameRules:State_Get() == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
		--print( "Template addon script is running." )
	elseif GameRules:State_Get() >= DOTA_GAMERULES_STATE_POST_GAME then
		return nil
	end
	return 1
end




function RollDrops(unit)
    local DropInfo = GameRules.DropTable[unit:GetUnitName()]
    if DropInfo then
        for item_name,chance in pairs(DropInfo) do
            if RollPercentage(chance) then
                -- Create the item
                local item = CreateItem(item_name, nil, nil)
                local pos = unit:GetAbsOrigin()
                local drop = CreateItemOnPositionSync( pos, item )
                local pos_launch = pos+RandomVector(RandomFloat(150,200))
                item:LaunchLoot(false, 200, 0.75, pos_launch)
            end
        end
    end
end


function CAddonTemplateGameMode:OnEntityKilled( keys )
    local killedUnit = EntIndexToHScript( keys.entindex_killed )
    if killedUnit:IsCreature() then
        RollDrops(killedUnit)
    end
end

function CAddonTemplateGameMode:OnPLayerChat( keys )

	local player = keys.playerid
	local text = keys.text

	if text == "-load" then
		local steamid = PlayerResource:GetSteamID(player)
		local hero_name = PlayerResource:GetSelectedHeroEntity(player)
		if 	PlayerResource:GetSelectedHeroEntity(player):GetLevel() == 1 then
			SaveLoadManager:LoadHero(steamid, hero_name)
		else
		end
	end

	if text == "-save" then
		local hero_name = PlayerResource:GetSelectedHeroEntity(player)
		local steamid = PlayerResource:GetSteamID(player)
		SaveLoadManager:SaveHero(steamid, hero_name)
	end

end