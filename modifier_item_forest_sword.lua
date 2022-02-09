modifier_item_forest_sword = class({})

--------------------------------------------------------------------------------

function modifier_item_forest_sword:IsHidden()
	return true
end

--------------------------------------------------------------------------------

function modifier_item_forest_sword:IsPurgable()
	return false
end

--------------------------------------------------------------------------------

function modifier_item_forest_sword:OnCreated( kv )
	self.bonus_agility = self:GetAbility():GetSpecialValueFor( "bonus_agility" )
	self.bonus_damage= self:GetAbility():GetSpecialValueFor( "bonus_damage" )
end

--------------------------------------------------------------------------------

function modifier_item_forest_sword:DeclareFunctions()
	local funcs =
	{
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}
	return funcs
end

--------------------------------------------------------------------------------


--------------------------------------------------------------------------------

function modifier_item_forest_sword:GetModifierBonusStats_Agility( params )
	return self.bonus_agility
end

function modifier_item_forest_sword:GetModifierPreAttack_BonusDamage( params )
	return self.bonus_damage
end

