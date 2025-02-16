require("api")
require("keybindings")

function handle(key)
	for _, binding in pairs(keybindings) do
		if contains(binding.buttons, key) then
			binding.call()
			print(binding.description)
			break
		end
	end
end

-- checks whether element is in list (slightly hacky)
function contains(list, element)
	local set = {}
	for _, l in ipairs(list) do
		set[l] = true
	end
	return set[element]
end
