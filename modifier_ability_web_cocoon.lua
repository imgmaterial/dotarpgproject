modifier_ability_web_cocoon = class({})
--Root modifier, creates a unit object on top of the hero, killing the unit removes modifier, single target, purgable

function modifier_ability_web_cocoon:IsHidden()
	return false
end

function modifier_ability_web_cocoon:IsDebuff()
	return true
end

function modifier_ability_web_cocoon:IsStunDebuff()
	return false
end

function modifier_ability_web_cocoon:IsPurgable()
	return true
end

function modifier_ability_web_cocoon:GetPriority()
	return MODIFIER_PRIORITY_HIGH
end

--------------------------------------------------------------------------------
-- Initializations

function modifier_ability_web_cocoon:OnCreated( kv )
    if not IsServer() then return end
    netunit = CreateUnitByName("npc_dota_creature_cocoon_dummy" ,self:GetParent():GetAbsOrigin() , true, nil, nil, DOTA_TEAM_NEUTRALS)
    self:StartIntervalThink(0.1)
end

function modifier_ability_web_cocoon:OnRefresh( kv )
	
end

function modifier_ability_web_cocoon:OnRemoved()
    if IsValidEntity(netunit) then
        netunit:RemoveSelf()
    end
end

function modifier_ability_web_cocoon:OnDestroy()
end

function modifier_ability_web_cocoon:OnIntervalThink()
    if IsValidEntity(netunit) then
        if netunit:IsAlive() == false then
            self:GetParent():RemoveModifierByName("modifier_ability_web_cocoon")
        end
    end
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_ability_web_cocoon:CheckState()
	local state = {
		[MODIFIER_STATE_INVISIBLE] = false,
		[MODIFIER_STATE_ROOTED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Graphics & Animations
--function modifier_ability_web_cocoon:GetEffectName()
--	return "particles/units/heroes/hero_siren/siren_net.vpcf"
--end

--function modifier_ability_web_cocoon:GetEffectAttachType()
--	return PATTACH_ABSORIGIN_FOLLOW
--end