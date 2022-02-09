modifier_item_forest_helm = class({})

--------------------------------------------------------------------------------

function modifier_item_forest_helm:IsHidden()
	return true
end

--------------------------------------------------------------------------------

function modifier_item_forest_helm:IsPurgable()
	return false
end

--------------------------------------------------------------------------------

function modifier_item_forest_helm:OnCreated( kv )
	self.bonus_strength = self:GetAbility():GetSpecialValueFor( "bonus_strength" )
	self.bonus_agility = self:GetAbility():GetSpecialValueFor( "bonus_agility" )
	self.bonus_armor= self:GetAbility():GetSpecialValueFor( "bonus_armor" )
end

--------------------------------------------------------------------------------

function modifier_item_forest_helm:DeclareFunctions()
	local funcs =
	{
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
	return funcs
end

--------------------------------------------------------------------------------

function modifier_item_forest_helm:GetModifierBonusStats_Strength( params )
	return self.bonus_strength
end

--------------------------------------------------------------------------------

function modifier_item_forest_helm:GetModifierBonusStats_Agility( params )
	return self.bonus_agility
end

function modifier_item_forest_helm:GetModifierPhysicalArmorBonus( params )
	return self.bonus_armor
end

