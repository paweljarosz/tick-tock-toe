local IMMUTABLE = require "immutable.immutable"

local M = {}

function M.on_input(action_id, action)
	local game_logic_input = { row = 0, col = 0, action = "none" }

	if action.released and action_id == hash("touch") then
		-- Map the input position to a cell (row, col)
		-- For simplicity, assume the game board is in the center of the screen
		-- and each cell is 100x100 pixels
		local cell_size = 100
		local screen_width = tonumber(sys.get_config("display.width"))
		local screen_height = tonumber(sys.get_config("display.height"))

		local board_origin_x = (screen_width - cell_size * 3) / 2
		local board_origin_y = (screen_height - cell_size * 3) / 2

		local x_input = action.x
		local y_input = screen_height - action.y -- Y is inverted

		if x_input < board_origin_x or x_input > board_origin_x + cell_size * 3 or
		y_input < board_origin_y or y_input > board_origin_y + cell_size * 3 then
			return IMMUTABLE(game_logic_input)
		end

		game_logic_input.col = math.floor((x_input - board_origin_x) / cell_size) + 1
		game_logic_input.row = math.floor((y_input - board_origin_y) / cell_size) + 1
	end

	if action.released and action_id == hash("undo") then
		game_logic_input.action = "undo"
	end

	return IMMUTABLE(game_logic_input)
end

return M