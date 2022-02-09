modifier_item_forest_staff = class({})

--------------------------------------------------------------------------------

function modifier_item_forest_staff:IsHidden()
	return true
end

--------------------------------------------------------------------------------

function modifier_item_forest_staff:IsPurgable()
	return false
end

--------------------------------------------------------------------------------

function modifier_item_forest_staff:OnCreated( kv )
	self.bonus_intelligence = self:GetAbility():GetSpecialValueFor( "bonus_intelligence" )
	self.bonus_damage = self:GetAbility():GetSpecialValueFor( "bonus_damage" )
	self.bonus_spell_amp = self:GetAbility():GetSpecialValueFor( "bonus_spell_amp" )
end

--------------------------------------------------------------------------------

function modifier_item_forest_staff:DeclareFunctions()
	local funcs =
	{
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}
	return funcs
end

--------------------------------------------------------------------------------


--------------------------------------------------------------------------------

function modifier_item_forest_staff:GetModifierBonusStats_Intellect( params )
	return self.bonus_intelligence
end

function modifier_item_forest_staff:GetModifierPreAttack_BonusDamage( params )
	return self.bonus_damage
end

function modifier_item_forest_staff:GetModifierSpellAmplify_Percentage( params )
	return self.bonus_spell_amp
end

