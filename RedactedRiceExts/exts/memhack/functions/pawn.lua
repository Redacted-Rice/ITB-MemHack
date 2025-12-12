function onPawnClassInitialized(BoardPawn, pawn)
	BoardPawn.GetPilot = function(self)
		-- Pawn contains a double pointer at 0x980 and 0x984 to
		-- the same memory offset by 12 bytes. Just use the second
		-- because it points to the lower of the two addresses, presumably
		-- the wrapper class around pilot - maybe an AE pilot struct?
		local pilotPtr = memhack.dll.memory.readPointer(memhack.dll.memory.getUserdataAddr(self) + 0x984)
		-- If no pilot, address will be set to 0
		if pilotPtr == 0 then
			return nil
		end
		return memhack.structs.Pilot.new(pilotPtr)
	end
end

modApi.events.onPawnClassInitialized:subscribe(onPawnClassInitialized)