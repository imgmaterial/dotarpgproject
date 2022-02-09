modifier_item_forest_ring_int = class({})

--------------------------------------------------------------------------------

function modifier_item_forest_ring_int:IsHidden()
	return true
end

--------------------------------------------------------------------------------

function modifier_item_forest_ring_int:IsPurgable()
	return false
end

--------------------------------------------------------------------------------

function modifier_item_forest_ring_int:OnCreated( kv )
	self.bonus_mana_regen = self:GetAbility():GetSpecialValueFor( "bonus_mana_regen" )
	self.bonus_intelligence = self:GetAbility():GetSpecialValueFor( "bonus_intelligence" )
	self.bonus_mana= self:GetAbility():GetSpecialValueFor( "bonus_mana" )
	self.bonus_hp_regen= self:GetAbility():GetSpecialValueFor( "bonus_hp_regen" )
end

--------------------------------------------------------------------------------

function modifier_item_forest_ring_int:DeclareFunctions()
	local funcs =
	{
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_MANA_BONUS,
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
	}
	return funcs
end

--------------------------------------------------------------------------------

function modifier_item_forest_ring_int:GetModifierConstantManaRegen( params )
	return self.bonus_mana_regen
end


function modifier_item_forest_ring_int:GetModifierManaBonus( params )
	return self.bonus_mana
end

function modifier_item_forest_ring_int:GetModifierConstantHealthRegen( params  )
	return self.bonus_hp_regen
end

function modifier_item_forest_ring_int:GetModifierBonusStats_Intellect( params  )
	return self.bonus_intelligence
end

