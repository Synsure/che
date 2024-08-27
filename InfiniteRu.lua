local mem = require "memory"

function main()
	while true do
	wait(0)
		if isSampAvailable() then
			mem.setint8(0xB7CEE4, 1)
		end
	end
end
