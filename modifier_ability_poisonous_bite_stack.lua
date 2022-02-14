require("Timers")
modifier_ability_poisonous_bite_stack = class({})

-- Classifications
function modifier_ability_poisonous_bite_stack:IsHidden()
	return true
end

function modifier_ability_poisonous_bite_stack:IsPurgable()
	return false
end
function modifier_ability_poisonous_bite_stack:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
--------------------------------------------------------------------------------
-- Initializations
function modifier_ability_poisonous_bite_stack:OnCreated( kv )

end

function modifier_ability_poisonous_bite_stack:OnRemoved()
	if IsServer() then
		self.modifier:RemoveStack()
	end
end