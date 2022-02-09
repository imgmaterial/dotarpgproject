modifier_item_forest_ring = class({})

--------------------------------------------------------------------------------

function modifier_item_forest_ring:IsHidden()
	return true
end

--------------------------------------------------------------------------------

function modifier_item_forest_ring:IsPurgable()
	return false
end

--------------------------------------------------------------------------------

function modifier_item_forest_ring:OnCreated( kv )
	self.bonus_strength = self:GetAbility():GetSpecialValueFor( "bonus_strength" )
	self.bonus_agility = self:GetAbility():GetSpecialValueFor( "bonus_agility" )
	self.bonus_health= self:GetAbility():GetSpecialValueFor( "bonus_health" )
	self.bonus_hp_regen= self:GetAbility():GetSpecialValueFor( "bonus_hp_regen" )
end

--------------------------------------------------------------------------------

function modifier_item_forest_ring:DeclareFunctions()
	local funcs =
	{
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_HEALTH_BONUS,
	}
	return funcs
end

--------------------------------------------------------------------------------

function modifier_item_forest_ring:GetModifierBonusStats_Strength( params )
	return self.bonus_strength
end

--------------------------------------------------------------------------------

function modifier_item_forest_ring:GetModifierBonusStats_Agility( params )
	return self.bonus_agility
end

function modifier_item_forest_ring:GetModifierConstantHealthRegen( params  )
	return self.bonus_hp_regen
end

function modifier_item_forest_ring:GetModifierHealthBonus( params  )
	return self.bonus_health
end

