item_forest_cloak = class({})
LinkLuaModifier( "modifier_item_forest_cloak", "modifiers/modifier_item_forest_cloak", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------

function item_forest_cloak:GetIntrinsicModifierName()
	return "modifier_item_forest_cloak"
end

--------------------------------------------------------------------------------

function item_forest_cloak:Spawn()
	self.required_level = self:GetSpecialValueFor( "required_level" )
    self.gear_type = self:GetSpecialValueFor( "gear_type" )
end

--------------------------------------------------------------------------------

function item_forest_cloak:OnHeroLevelUp()
	if IsServer() then
		if self:GetCaster():GetLevel() == self.required_level and self:IsInBackpack() == false then
			self:OnUnequip()
			self:OnEquip()
		end
	end
end


function item_forest_cloak:CanUnitPickUp( ItemOwner)
	
	if ItemOwner:GetLevel() < self.required_level then
		return false
	end
	

	for i = 0, 5, 1 
	do
		if ItemOwner:GetItemInSlot(i) == nil then
			
		elseif ItemOwner:GetItemInSlot(i):GetSpecialValueFor( "gear_type" ) == self.gear_type then
			return false	
		end		
	end
end
--------------------------------------------------------------------------------

function item_forest_cloak:IsMuted()	
	if self.required_level > self:GetCaster():GetLevel() then
		return true
	end
	if not self:GetCaster():IsHero() then
		return true
	end

	return self.BaseClass.IsMuted( self )
end