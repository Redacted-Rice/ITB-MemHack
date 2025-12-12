local PilotLvlUpSkill = memhack.structManager.define("PilotLvlUpSkill", {
	-- Any other interesting values to pull out? (other than skills)
	-- Maybe pilot skill?
	id = { offset = 0x0, type = "string", maxLength = 16},
	-- String indexes into global string map. Seem to behave a bit oddly. If not
	-- found they will display the index value. Some skills seem to have smaller
	-- size limit? Maybe AE (16) vs OG (15)? Was testing with Move Bonus and Thick Skin
	displayNameIdx = { offset = 0x18, type = "string", maxLength = 16}, -- string ref to string in global string map
	fullNameIdx = { offset = 0x30, type = "string", maxLength = 16}, -- string ref to string in global string map
	descriptionIdx = { offset = 0x48, type = "string", maxLength = 16}, -- string ref to string in global string map
	coresBonus = { offset = 0x64, type = "int"},
	healthBonus = { offset = 0x68, type = "int"},
	moveBonus = { offset = 0x6C, type = "int"},
	saveVal = { offset = 0x70, type = "int"}, -- must be between 0-13
})

-- TODO integrate arrays/structs into defs. This is two PilotLvlUpSkill
local PilotLvlUpSkills = memhack.structManager.define("PilotLvlUpSkill", {
	-- Any other interesting values to pull out? (other than skills)
	-- Maybe pilot skill?
	name = { offset = 0x20, type = "string", maxLength = 15}, -- including null term. 15 instead of 16 for some reason
	xp = { offset = 0x3C, type = "int", setterPrefix="setInternal"},
	levelUpXp = { offset = 0x40, type = "int", setterPrefix="setInternal"},
	level = { offset = 0x68, type = "int", setterPrefix="setInternal"},
	id = { offset = 0x84, type = "string", maxLength = 15}, -- guess
	--skills = { offset = 0x30, type = "pointer", pointedType = TwoSkillsStruct},
})

local PilotStruct = memhack.structManager.define("Pilot", {
	-- Any other interesting values to pull out? (other than skills)
	-- Maybe pilot skill?
	name = { offset = 0x20, type = "string", maxLength = 15}, -- including null term. 15 instead of 16 for some reason
	xp = { offset = 0x3C, type = "int", setterPrefix="setInternal"},
	levelUpXp = { offset = 0x40, type = "int", setterPrefix="setInternal"},
	level = { offset = 0x68, type = "int", setterPrefix="setInternal"},
	id = { offset = 0x84, type = "string", maxLength = 15}, -- guess
	lvlUpSkills = { offset = 0xD8, type = "pointer", pointedType = PilotLvlUpSkills},
})

-- Convinience for defining fns
local Pilot = memhack.structs.Pilot

function onPawnClassInitialized(BoardPawn, pawn)
	-- TODO: any other functions?
	-- maybe one to change the pilot type?
	
	Pilot.LevelUp = function(self)
		local newLevel = self:getLevel() + 1
		if newLevel <= 2 then
			self:setInternalXp(0)
			self:setInternalLevel(newLevel)
			self:setInternalLevelUpXp((newLevel + 1) * 25)
		end
	end
	
	Pilot.LevelDown = function(self)
		local newLevel = self:getLevel() - 1
		if newLevel >= 0 then
			self:setInternalXp(0)
			self:setInternalLevel(newLevel)
			self:setInternalLevelUpXp((newLevel + 1) * 25)
		end
	end
end

-- Use on first load event or some other one?
modApi.events.onPawnClassInitialized:subscribe(onPawnClassInitialized)
