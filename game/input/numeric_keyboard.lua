local IMMUTABLE = require "immutable.immutable"

local M = {}

function M.on_input(action_id, action)
	local game_logic_input = { row = 0, col = 0 }

	if action.released then
		if action_id == hash("bot_left") then
			game_logic_input.row = 3
			game_logic_input.col = 1
		elseif action_id == hash("bot_mid") then
			game_logic_input.row = 3
			game_logic_input.col = 2
		elseif action_id == hash("bot_right") then
			game_logic_input.row = 3
			game_logic_input.col = 3
		elseif action_id == hash("mid_left") then
			game_logic_input.row = 2
			game_logic_input.col = 1
		elseif action_id == hash("mid_mid") then
			game_logic_input.row = 2
			game_logic_input.col = 2
		elseif action_id == hash("mid_right") then
			game_logic_input.row = 2
			game_logic_input.col = 3
		elseif action_id == hash("top_left") then
			game_logic_input.row = 1
			game_logic_input.col = 1
		elseif action_id == hash("top_mid") then
			game_logic_input.row = 1
			game_logic_input.col = 2
		elseif action_id == hash("top_right") then
			game_logic_input.row = 1
			game_logic_input.col = 3
		end
	end

	return (game_logic_input)
end

return M