-- Global constants
APP_VERSION_MAJOR = 0x01 -- major.minor
APP_VERSION_MINOR = 0x10
	
APP_VERSION = ((APP_VERSION_MAJOR << 0x01) | (APP_VERSION_MINOR << 0x10)) -- Union Binary

UPDATE_PORT = channel.new("UPDATE_PORT")

local version = http.get("https://raw.githubusercontent.com/ONElua/AccountManager/master/version")
if version and tonumber(version) then
	version = tonumber(version)
	local major = (version >> 0x18) & 0xFF;
	local minor = (version >> 0x10) & 0xFF;
	if version > APP_VERSION then
		UPDATE_PORT:push(version)
	end
end