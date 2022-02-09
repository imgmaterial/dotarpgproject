 ai_modifier_common_creep = class({})

local AI_STATE_IDLE = 0
local AI_STATE_AGGRESSIVE = 1
local AI_STATE_RETURNING = 2

local AI_THINK_INTERVAL = 0.5

function ai_modifier_common_creep:OnCreated(params)
    -- Only do AI on server
    if IsServer() then
        -- Set initial state
        self.state = AI_STATE_IDLE

        -- Store parameters from AI creation:
        -- unit:AddNewModifier(caster, ability,  ai_modifier_common_creep", { aggroRange = X, leashRange = Y })
        self.aggroRange = params.aggroRange
        self.leashRange = params.leashRange

        -- Store unit handle so we don't have to call self:GetParent() every time
        self.unit = self:GetParent()

        -- Set state -> action mapping
        self.stateActions = {
            [AI_STATE_IDLE] = self.IdleThink,
            [AI_STATE_AGGRESSIVE] = self.AggressiveThink,
            [AI_STATE_RETURNING] = self.ReturningThink,
        }

        -- Start thinking
        self:StartIntervalThink(AI_THINK_INTERVAL)
    end
end

function ai_modifier_common_creep:OnIntervalThink()
    -- Execute action corresponding to the current state
    self.stateActions[self.state](self)    
end

function ai_modifier_common_creep:IdleThink()
    -- Find any enemy units around the AI unit inside the aggroRange
    local units = FindUnitsInRadius(self.unit:GetTeam(), self.unit:GetAbsOrigin(), nil,
        self.aggroRange, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, 
        FIND_ANY_ORDER, false)

    -- If one or more units were found, start attacking the first one
    if #units > 0 then
        self.spawnPos = self.unit:GetAbsOrigin() -- Remember position to return to
        self.aggroTarget = units[1] -- Remember who to attack
        self.unit:MoveToTargetToAttack(self.aggroTarget) --Start attacking
        self.state = AI_STATE_AGGRESSIVE --State transition
        return -- Stop processing this state
    end

    -- Nothing else to do in Idle state
end

function ai_modifier_common_creep:AggressiveThink()
    -- Check if the unit has walked outside its leash range
    if (self.spawnPos - self.unit:GetAbsOrigin()):Length() > self.leashRange then
        self.unit:MoveToPosition(self.spawnPos) --Move back to the spawnpoint
        self.state = AI_STATE_RETURNING --Transition the state to the 'Returning' state(!)
        return -- Stop processing this state
    end
    
    -- Check if the target has died
    if not self.aggroTarget:IsAlive() then
        self.unit:MoveToPosition(self.spawnPos) --Move back to the spawnpoint
        self.state = AI_STATE_RETURNING --Transition the state to the 'Returning' state(!)
        return -- Stop processing this state
    end
    
    -- Still in the aggressive state, so do some aggressive stuff.
    self.unit:MoveToTargetToAttack(self.aggroTarget)
end

function ai_modifier_common_creep:ReturningThink()
    -- Check if the AI unit has reached its spawn location yet
    if (self.spawnPos - self.unit:GetAbsOrigin()):Length() < 10 then
        self.state = AI_STATE_IDLE -- Transition the state to the 'Idle' state(!)
        return -- Stop processing this state
    end

    -- If not at return position yet, try to move there again
    self.unit:MoveToPosition(self.spawnPos)
end