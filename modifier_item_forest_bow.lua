modifier_item_forest_bow = class({})

--------------------------------------------------------------------------------

function modifier_item_forest_bow:IsHidden()
	return true
end

--------------------------------------------------------------------------------

function modifier_item_forest_bow:IsPurgable()
	return false
end

--------------------------------------------------------------------------------

function modifier_item_forest_bow:OnCreated( kv )
	self.bonus_agility = self:GetAbility():GetSpecialValueFor( "bonus_agility" )
	self.bonus_damage= self:GetAbility():GetSpecialValueFor( "bonus_damage" )
	self.bonus_attack_speed = self:GetAbility():GetSpecialValueFor("attack_speed")
end

--------------------------------------------------------------------------------

function modifier_item_forest_bow:DeclareFunctions()
	local funcs =
	{
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
	return funcs
end

--------------------------------------------------------------------------------


--------------------------------------------------------------------------------

function modifier_item_forest_bow:GetModifierBonusStats_Agility( params )
	return self.bonus_agility
end

function modifier_item_forest_bow:GetModifierPreAttack_BonusDamage( params )
	return self.bonus_damage
end

function modifier_item_forest_bow:GetModifierAttackSpeedBonus_Constant( params )
	return self.bonus_attack_speed
end
