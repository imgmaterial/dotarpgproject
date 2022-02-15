ability_web_cocoon = class({})
LinkLuaModifier( "modifier_ability_web_cocoon", "modifiers/modifier_ability_web_cocoon", LUA_MODIFIER_MOTION_NONE )
-- shoots projectile at multiple heroes in radius abblies linked modifer 

function ability_web_cocoon:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local targetlist = FindUnitsInRadius(
        self:GetCaster():GetTeamNumber(),
        self:GetCaster():GetAbsOrigin(),
        nil,
        1000,
        DOTA_UNIT_TARGET_TEAM_ENEMY,
        DOTA_UNIT_TARGET_ALL,
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_ANY_ORDER,
        false)

	-- load data
	local projectile_speed = self:GetSpecialValueFor( "net_speed" )
	local fake_radius = self:GetSpecialValueFor( "fake_ensnare_distance" )

	-- create projectile
	local projectile_name = "particles/units/heroes/hero_siren/siren_net_projectile.vpcf"
    for i, target in ipairs(targetlist) do
        local info = {
            Target = target,
            Source = caster,
            Ability = self,	
            
            EffectName = projectile_name,
            iMoveSpeed = projectile_speed,
            bDodgeable = true,                           
            ExtraData = {
                fake = 0,
            }
        }
        ProjectileManager:CreateTrackingProjectile(info)
    end

	-- play effects
	local sound_cast = "Hero_NagaSiren.Ensnare.Cast"
	EmitSoundOn( sound_cast, caster )
end


function ability_web_cocoon:OnProjectileHit_ExtraData( target, location, data )
	if not target then return end
	if data.fake==1 then return end

	if target:IsMagicImmune() then return end

	-- cancel if linken
	if target:TriggerSpellAbsorb( self ) then return end

	-- load data
	local duration = self:GetSpecialValueFor( "duration" )
	-- ensnare
	target:AddNewModifier(
		self:GetCaster(), -- player source
		self, -- ability source
		"modifier_ability_web_cocoon", -- modifier name
		{ duration = duration } -- kv
	)

	-- play effects
	local sound_cast = "Hero_NagaSiren.Ensnare.Target"
	EmitSoundOn( sound_cast, target )
end
