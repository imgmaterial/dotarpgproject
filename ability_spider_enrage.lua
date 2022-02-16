ability_spider_enrage = class({})
LinkLuaModifier( "modifier_ability_spider_enrage", "modifiers/modifier_ability_spider_enrage", LUA_MODIFIER_MOTION_NONE )

function ability_spider_enrage:OnSpellStart()
    caster = self:GetCaster()
    duration = self:GetSpecialValueFor("duration")
    caster:AddNewModifier(
        caster,
        self,
        "modifier_ability_spider_enrage",
        {
            duration = duration
        }
    )
end