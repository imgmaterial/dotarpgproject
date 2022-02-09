modifier_item_forest_circlet = class({})

--------------------------------------------------------------------------------

function modifier_item_forest_circlet:IsHidden()
	return true
end

--------------------------------------------------------------------------------

function modifier_item_forest_circlet:IsPurgable()
	return false
end

--------------------------------------------------------------------------------

function modifier_item_forest_circlet:OnCreated( kv )
	self.bonus_intelligence = self:GetAbility():GetSpecialValueFor( "bonus_intelligence" )
	self.bonus_mana_regen = self:GetAbility():GetSpecialValueFor( "bonus_mana_regen" )
	self.bonus_armor= self:GetAbility():GetSpecialValueFor( "bonus_armor" )
end

--------------------------------------------------------------------------------

function modifier_item_forest_circlet:DeclareFunctions()
	local funcs =
	{
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
	return funcs
end

--------------------------------------------------------------------------------

function modifier_item_forest_circlet:GetModifierConstantManaRegen( params )
	return self.bonus_mana_regen
end

--------------------------------------------------------------------------------

function modifier_item_forest_circlet:GetModifierBonusStats_Intellect( params )
	return self.bonus_intelligence
end

function modifier_item_forest_circlet:GetModifierPhysicalArmorBonus( params )
	return self.bonus_armor
end

