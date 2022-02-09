modifier_item_forest_cloak = class({})

--------------------------------------------------------------------------------

function modifier_item_forest_cloak:IsHidden()
	return true
end

--------------------------------------------------------------------------------

function modifier_item_forest_cloak:IsPurgable()
	return false
end

--------------------------------------------------------------------------------

function modifier_item_forest_cloak:OnCreated( kv )
	self.bonus_intelligence = self:GetAbility():GetSpecialValueFor( "bonus_intelligence" )
	self.bonus_mana = self:GetAbility():GetSpecialValueFor( "bonus_mana" )
	self.bonus_armor= self:GetAbility():GetSpecialValueFor( "bonus_armor" )
end

--------------------------------------------------------------------------------

function modifier_item_forest_cloak:DeclareFunctions()
	local funcs =
	{
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
        MODIFIER_PROPERTY_MANA_BONUS,
	}
	return funcs
end

--------------------------------------------------------------------------------

function modifier_item_forest_cloak:GetModifierManaBonus( params )
	return self.bonus_mana
end

--------------------------------------------------------------------------------

function modifier_item_forest_cloak:GetModifierBonusStats_Intellect( params )
	return self.bonus_intelligence
end

function modifier_item_forest_cloak:GetModifierPhysicalArmorBonus( params )
	return self.bonus_armor
end

