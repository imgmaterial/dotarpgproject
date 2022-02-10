LinkLuaModifier( "modifier_ability_spider_web", "modifiers/modifier_ability_spider_web", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_ability_spider_web_debuff", "modifiers/modifier_ability_spider_web_debuff", LUA_MODIFIER_MOTION_NONE )
spider_boss_web_ability = class ({})


function spider_boss_web_ability:GetAOERadius()
    return self:GetSpecialValueFor("radius")
end

function spider_boss_web_ability:GetFilterResultLocation( vLocation)
    return UF_SUCCESS
end

function spider_boss_web_ability:OnSpellStart()
    local vTarget = self:GetCursorPosition()
    local webunit = CreateUnitByName("npc_dota_creature_spider_queen_web" ,vTarget , true, nil, nil, DOTA_TEAM_NEUTRALS)
    webunit:AddNewModifier(nil, nil, "modifier_ability_spider_web", nil)
    --webunit:AddNewModifier(nil, nil, "modifier_ability_spider_web_debuff", nil)
    local caster = self:GetCaster()

    Timers:CreateTimer(function()
        if caster:IsAlive() == false then
            webunit:Kill(nil, nil)
        end

        return 5.0
    end)


    CreateModifierThinker(
		caster, 
		self, 
		"modifier_ability_spider_web_debuff", 
		{ 120 }, 
		vTarget,
		caster:GetTeamNumber(),
		false)
end

