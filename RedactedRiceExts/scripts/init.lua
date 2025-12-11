
local extension =  {
	id = "redactedrice_exts",
	name = "Redacted Rice Extensions",
	version = "0.1.0",
	icon = "scripts/icon.png",
	description = "Extensions to support mods made by Redacted Rice",
	submodFolders = {"exts/"},
	modApiVersion = "2.9.4",
	gameVersion = "1.2.93",
	dependencies = {
        modApiExt = "1.23",
        memedit = "1.2.0",
    },
	isExtension = true,
}

function extension:metadata()
	-- nothing for now
end

function extension:init(options)
	-- nothing for now
end

function extension:load(options, version)
	-- nothing for now
end

return extension