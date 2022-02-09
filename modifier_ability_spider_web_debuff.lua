modifier_ability_spider_web_debuff = class({})


function modifier_ability_spider_web_debuff:IsHidden()
    return false
end

function modifier_ability_spider_web_debuff:IsDebuff()
    return true
end

function modifier_ability_spider_web_debuff:IsStunDebuff()
    return false
end

function modifier_ability_spider_web_debuff:IsPurgable()
    return false
end


function modifier_ability_spider_web_debuff:ContainsInList(item, list)

    for i, value in ipairs(list) do
        if value:GetUnitName() == item then
            return true
        end
    end

    return false

end

function modifier_ability_spider_web_debuff:SpawnWebSpiders(location)
	local webspider = CreateUnitByName("npc_dota_creature_forest_spider" ,location , true, nil, nil, DOTA_TEAM_NEUTRALS)
end



function modifier_ability_spider_web_debuff:OnCreated( kv )
	local parent = self:GetParent()
    self.thinker = kv.isProvidedByAura~=1

    if not IsServer() then return end
    if not self.thinker then return end

    self:StartIntervalThink(5.0)
end


function modifier_ability_spider_web_debuff:OnRemoved()
end

function modifier_ability_spider_web_debuff:OnDestroyed()
    if not IsServer() then return end
	if not self.thinker then return end

	UTIL_Remove( self:GetParent() )
end

function modifier_ability_spider_web_debuff:OnIntervalThink()
    local parent = self:GetParent()
    local enemies = FindUnitsInRadius(
		DOTA_TEAM_NEUTRALS,	-- int, your team number
		self:GetParent():GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		1000.0,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		0,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

    for i, enemy in pairs(enemies) do
        self:SpawnWebSpiders(enemy:GetAbsOrigin())
    end
end


function modifier_ability_spider_web_debuff:IsAura()
    return self.thinker
end

function modifier_ability_spider_web_debuff:GetModifierAura()
    return "modifier_ability_spider_web_debuff"
end


function modifier_ability_spider_web_debuff:GetAuraRadius()
    return 1000
end

function modifier_ability_spider_web_debuff:GetAuraDuration()
    return 0.5
end

function modifier_ability_spider_web_debuff:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_ability_spider_web_debuff:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_ability_spider_web_debuff:GetAuraSearchFlags()
	return 0
end