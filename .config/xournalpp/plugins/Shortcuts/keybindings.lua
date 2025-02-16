-- require "modes"
require("api")
--------------------
-- KEYBINDINGS:   --
--------------------
keybindings = {
	-- Tools
	pen = {
		description = "Pen",
		buttons = { "t" },
		call = function()
			clickPen()
			cleanShape()
		end,
	},
	eraser = {
		description = "Eraser",
		buttons = { "s" },
		call = function()
			clickEraser()
			cleanShape()
		end,
	},
	highlighter = {
		description = "Highlighter",
		buttons = { "r" },
		call = function()
			clickHighlighter()
			cleanShape()
		end,
	},
	hand = {
		description = "Hand",
		buttons = { "g" },
		call = clickHand,
	},
	selection = {
		description = "Selection",
		buttons = { "a" },
		call = clickSelectRegion,
	},

	-- History
	undo = {
		description = "Undo",
		buttons = { "d", "u", "z" },
		call = clickUndo,
	},
	redo = {
		description = "Redo",
		buttons = { "f" },
		call = clickRedo,
	},

	open = {
		description = "Open file",
		buttons = { "p" },
		call = clickOpen,
	},
}

-- helper functions
function cleanShape()
	clickRuler(false)
	clickArrow(false)
	clickRectangle(false)
	clickEllipse(false)
	clickSpline(false)
	clickFill(false)
	clickPlain()
end
