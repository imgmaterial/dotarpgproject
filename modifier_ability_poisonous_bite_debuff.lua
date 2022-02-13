modifier_ability_poisonous_bite_debuff = class({})

-- Classifications
function modifier_ability_poisonous_bite_debuff:IsHidden()
	return false
end

function modifier_ability_poisonous_bite_debuff:IsDebuff()
	return true
end

function modifier_ability_poisonous_bite_debuff:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_ability_poisonous_bite_debuff:OnCreated( kv )
	-- references
	self.movespeed_loss = self:GetAbility():GetSpecialValueFor( "movespeed_loss" )
	self.armor_loss = self:GetAbility():GetSpecialValueFor( "armor_loss" )
	self.duration = kv.stack_duration

	if IsServer() then
		self:AddStack( self.duration )
	end
end

function modifier_ability_poisonous_bite_debuff:OnRefresh( kv )
	-- references
	self.movespeed_loss = self:GetAbility():GetSpecialValueFor( "movespeed_loss" )
	self.armor_loss = self:GetAbility():GetSpecialValueFor( "armor_loss" )
	self.duration = kv.stack_duration

	if IsServer() then
		self:AddStack( self.duration )
	end
end

function modifier_ability_poisonous_bite_debuff:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_ability_poisonous_bite_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
	}

	return funcs
end

function modifier_ability_poisonous_bite_debuff:GetModifierPhysicalArmorBonus()
	return self:GetStackCount() * -self.armor_loss
end

function modifier_ability_poisonous_bite_debuff:GetModifierMoveSpeedBonus_Constant()
	return self:GetStackCount() * -self.movespeed_loss
end

--------------------------------------------------------------------------------
-- Helper
function modifier_ability_poisonous_bite_debuff:AddStack( duration )
	-- Add modifier
	local mod = self:GetParent():AddNewModifier(
		self:GetParent(),
		self:GetAbility(),
		"modifier_ability_poisonous_bite_stack",
		{
			duration = self.duration,
		}
	)
	mod.modifier = self

	-- Add stack
	self:IncrementStackCount()
end

function modifier_ability_poisonous_bite_debuff:RemoveStack()
	if self:GetParent():IsAlive() == true then
		self:DecrementStackCount()
	end

	if self:GetStackCount()<=0 then
		self:Destroy()
	end
end