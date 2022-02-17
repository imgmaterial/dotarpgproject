modifier_ability_spider_decompose = class({})

LinkLuaModifier( "modifier_ability_web_cocoon", "modifiers/modifier_ability_web_cocoon", LUA_MODIFIER_MOTION_NONE )



function modifier_ability_spider_decompose:IsHidden()
	return false
end

function modifier_ability_spider_decompose:IsDebuff()
	return true
end

function modifier_ability_spider_decompose:IsStunDebuff()
	return false
end

function modifier_ability_spider_decompose:IsPurgable()
	return true
end




function modifier_ability_spider_decompose:OnCreated( kv )
    self.radius = self:GetAbility():GetSpecialValueFor("radius")
    self.damage = self:GetAbility():GetSpecialValueFor("damage")
end

function modifier_ability_spider_decompose:OnRefresh( kv )
    self.radius = self:GetAbility():GetSpecialValueFor("radius")
    self.damage = self:GetAbility():GetSpecialValueFor("damage")
end

function modifier_ability_spider_decompose:OnDestroy( kv )

end

function modifier_ability_spider_decompose:OnRemoved( kv )
    if not IsServer() then return end
    local targetlist = FindUnitsInRadius(
        self:GetParent():GetTeamNumber(),
        self:GetParent():GetAbsOrigin(),
        nil,
        self.radius,
        DOTA_UNIT_TARGET_TEAM_FRIENDLY,
        DOTA_UNIT_TARGET_ALL,
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_ANY_ORDER,
        false)

    
    for i, target in ipairs(targetlist) do 
        if target ~= self:GetParent() then
            local damagetable = {
                victim = target,
                attacker = self:GetCaster(),
                damage = self.damage,
                damage_type = DAMAGE_TYPE_PURE,
                damage_flags = DOTA_DAMAGE_FLAG_NONE,
                ability = self:GetCaster():GetAbilityByIndex(2)
            }
            ApplyDamage(damagetable)
        end
    end

    self:PlayEffects()
end


function modifier_ability_spider_decompose:PlayEffects()
    local particle1 = "particles/units/heroes/hero_pugna/pugna_netherblast.vpcf"
    local effect_cast_a = ParticleManager:CreateParticle(particle1, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControl(effect_cast_a, 1, Vector(self.radius, 0, 0))
end

function modifier_ability_spider_decompose:GetEffectName()
    return "particles/econ/items/pugna/pugna_ti9_immortal/pugna_ti9_immortal_netherblast_dust.vpcf"
end

function modifier_ability_spider_decompose:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end