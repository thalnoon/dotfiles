require("keybindings")
require("modes")

f = {}

function initUi()
	index = 1
	for _, binding in pairs(keybindings) do
		for _, button in pairs(binding.buttons) do
			declaration = "f" .. tostring(index) .. ' = function () handle("' .. button .. '") end'
			defineFunction = load(declaration)
			defineFunction()
			app.registerUi({
				["menu"] = binding.description,
				-- this doesn't work
				["callback"] = "f" .. tostring(index),
				["accelerator"] = button,
			})
			index = index + 1
		end
	end
end

lastPage = 1
sticky = false
