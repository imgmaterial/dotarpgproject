modifier_item_forest_armor = class({})

--------------------------------------------------------------------------------

function modifier_item_forest_armor:IsHidden()
	return true
end

--------------------------------------------------------------------------------

function modifier_item_forest_armor:IsPurgable()
	return false
end

--------------------------------------------------------------------------------

function modifier_item_forest_armor:OnCreated( kv )
	self.bonus_strength = self:GetAbility():GetSpecialValueFor( "bonus_strength" )
	self.bonus_agility = self:GetAbility():GetSpecialValueFor( "bonus_agility" )
	self.bonus_armor= self:GetAbility():GetSpecialValueFor( "bonus_armor" )
end

--------------------------------------------------------------------------------

function modifier_item_forest_armor:DeclareFunctions()
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

function modifier_item_forest_armor:GetModifierBonusStats_Strength( params )
	return self.bonus_strength
end

--------------------------------------------------------------------------------

function modifier_item_forest_armor:GetModifierBonusStats_Agility( params )
	return self.bonus_agility
end

function modifier_item_forest_armor:GetModifierPhysicalArmorBonus( params )
	return self.bonus_armor
end

