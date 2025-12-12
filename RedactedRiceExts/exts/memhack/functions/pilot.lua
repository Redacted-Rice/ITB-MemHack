
local PilotStruct = memhack.structManager.define("Pilot", {
	-- Any other interesting values to pull out? (other than skills)
	-- Maybe pilot skill?
	name = { offset = 0x20, type = "string", maxLength = 15}, -- including null term. 15 instead of 16 for some reason
	xp = { offset = 0x3C, type = "int", setterPrefix="setInternal"},
	levelUpXp = { offset = 0x40, type = "int", setterPrefix="setInternal"},
	level = { offset = 0x68, type = "int", setterPrefix="setInternal"},
	id = { offset = 0x84, type = "string", maxLength = 15}, -- guess
	--skills = { offset = 0x30, type = "pointer", pointedType = TwoSkillsStruct},
})

-- Convinience for defining fns
local Pilot = memhack.structs.Pilot

function onPawnClassInitialized(BoardPawn, pawn)
	-- TODO: any other functions?
	-- maybe one to change the pilot type?
	
	Pilot.LevelUp = function(self)
		local newLevel = self:getLevel() + 1
		if level <= 2 then
			self:setInternalXp(0)
			self:setInternalLevel(newLevel)
			self:setInternalLevelUpXp((newLevel + 1) * 25)
		end
	end
	
	Pilot.LevelDown = function(self)
		local newLevel = self:getLevel() - 1
		if level >= 0 then
			self:setInternalXp(0)
			self:setInternalLevel(newLevel)
			self:setInternalLevelUpXp((newLevel + 1) * 25)
		end
	end
end

-- Use on first load event or some other one?
modApi.events.onPawnClassInitialized:subscribe(onPawnClassInitialized)
