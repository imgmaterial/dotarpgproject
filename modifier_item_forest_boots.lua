modifier_item_forest_boots = class({})

--------------------------------------------------------------------------------

function modifier_item_forest_boots:IsHidden()
	return true
end

--------------------------------------------------------------------------------

function modifier_item_forest_boots:IsPurgable()
	return false
end

--------------------------------------------------------------------------------

function modifier_item_forest_boots:OnCreated( kv )
	self.bonus_movement_speed = self:GetAbility():GetSpecialValueFor( "bonus_movement_speed" )
end

--------------------------------------------------------------------------------

function modifier_item_forest_boots:DeclareFunctions()
	local funcs =
	{
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
	}
	return funcs
end

--------------------------------------------------------------------------------


--------------------------------------------------------------------------------

function modifier_item_forest_boots:GetModifierMoveSpeedBonus_Constant( params )
	return self.bonus_movement_speed
end


