modifier_ability_spider_enrage = class({})


function modifier_ability_spider_enrage:IsHidden()
	return false
end

function modifier_ability_spider_enrage:IsDebuff()
	return false
end

function modifier_ability_spider_enrage:IsStunDebuff()
	return false
end

function modifier_ability_spider_enrage:IsPurgable()
	return true
end

function modifier_ability_spider_enrage:OnCreated( kv )
    self.lifesteal = self:GetAbility():GetSpecialValueFor("lifesteal")
    self.status_res = self:GetAbility():GetSpecialValueFor("status_res")
    self.bonus_damage = self:GetAbility():GetSpecialValueFor("bonus_damage")
    self.bonus_ats = self:GetAbility():GetSpecialValueFor("bonus_ats")
end

function modifier_ability_spider_enrage:OnRefresh( kv )
    self.lifesteal = self:GetAbility():GetSpecialValueFor("lifesteal")
    self.status_res = self:GetAbility():GetSpecialValueFor("status_res")
    self.bonus_damage = self:GetAbility():GetSpecialValueFor("bonus_damage")
    self.bonus_ats = self:GetAbility():GetSpecialValueFor("bonus_ats")
end

function modifier_ability_spider_enrage:OnDestroy( kv )

end

function modifier_ability_spider_enrage:DeclareFunctions()
	local funcs =
	{
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_STATUS_RESISTANCE,
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}
	return funcs
end

function modifier_ability_spider_enrage:GetModifierProcAttack_BonusDamage_Physical( params )
	if IsServer() then
		if self:GetParent():PassivesDisabled() then return end

		-- leech
		local lifesteal = self:GetParent():GetAverageTrueAttackDamage(self:GetParent()) * self.lifesteal
		self:GetParent():Heal( lifesteal, self:GetParent() )
		self:PlayEffects()
		return leech
	end
end

function modifier_ability_spider_enrage:GetModifierStatusResistance( params )
    return self.status_res
end

function modifier_ability_spider_enrage:GetModifierPreAttack_BonusDamage( params )
    return self.bonus_damage
end

function modifier_ability_spider_enrage:GetModifierAttackSpeedBonus_Constant( params )
    return self.bonus_ats
end


function modifier_ability_spider_enrage:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/generic_gameplay/generic_lifesteal.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )

	ParticleManager:ReleaseParticleIndex( effect_cast )
end