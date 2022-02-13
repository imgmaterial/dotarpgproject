ability_poisonous_bite = class({})


LinkLuaModifier( "modifier_ability_poisonous_bite", "modifiers/modifier_ability_poisonous_bite", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_ability_poisonous_bite_stack", "modifiers/modifier_ability_poisonous_bite_stack", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_ability_poisonous_bite_debuff", "modifiers/modifier_ability_poisonous_bite_debuff", LUA_MODIFIER_MOTION_NONE )


function ability_poisonous_bite:GetIntrinsicModifierName()
    return "modifier_ability_poisonous_bite"
end

