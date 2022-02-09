LinkLuaModifier( "modifier_ability_spider_web_debuff", "modifiers/modifier_ability_spider_web_debuff", LUA_MODIFIER_MOTION_NONE )

modifier_ability_spider_web = class({})


function modifier_ability_spider_web:CheckState()
	return{
		[MODIFIER_STATE_UNSELECTABLE] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
        [MODIFIER_STATE_NOT_ON_MINIMAP] = true,
        [MODIFIER_STATE_INVULNERABLE] = true
	}
end


