modifier_ability_poisonous_bite = class({})

-- Classifications
function modifier_ability_poisonous_bite:IsHidden()
	return true
end

function modifier_ability_poisonous_bite:IsDebuff()
	return false
end

function modifier_ability_poisonous_bite:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_ability_poisonous_bite:OnCreated( kv )

end

function modifier_ability_poisonous_bite:OnRefresh( kv )

end

function modifier_ability_poisonous_bite:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_ability_poisonous_bite:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}

	return funcs
end
function modifier_ability_poisonous_bite:GetModifierProcAttack_Feedback( params )
	if IsServer() and (not self:GetParent():PassivesDisabled()) then
		-- filter enemy
		local target = params.target


		-- Apply debuff to enemy
		local debuff = params.target:AddNewModifier(
			self:GetParent(),
			self:GetAbility(),
			"modifier_ability_poisonous_bite_debuff",
			{
				stack_duration = self.duration,
			}
		)

		-- Apply buff to self
		self:AddStack( duration )

	end
end

--------------------------------------------------------------------------------
-- Helper
function modifier_ability_poisonous_bite:AddStack( duration )
	-- Add counter
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

function modifier_ability_poisonous_bite:RemoveStack()
	self:DecrementStackCount()
end
--------------------------------------------------------------------------------