local M = {}

function M.render(game_state)
	local current_player_text = "Now:" .. game_state.current_player
	label.set_text("visual#player", current_player_text)

	local current_board_text = ""
	for i = 1, 3 do
		local row = ""
		for j = 1, 3 do
			local cell = game_state.board[i][j]
			if cell == "" then cell = "-" end
			row = row .. cell .. " "
		end
		current_board_text = current_board_text .. row .. "\n" -- apend new row
	end

	label.set_text("visual#board", current_board_text)

	if game_state and game_state.winner and game_state.winner ~= "none" then
		label.set_text("visual#player", "Game over!")
		label.set_text("visual#board", "Winner:\n" .. game_state.winner)
	end
end

return M