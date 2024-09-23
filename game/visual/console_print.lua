local M = {}

function M.render(game_state)
	print("Current Player: " .. game_state.current_player)
	for i = 1, 3 do
		local row = i .. " "
		for j = 1, 3 do
			local cell = game_state.board[i][j]
			if cell == "" then cell = "-" end
			row = row .. cell .. " "
		end
		print(row)
	end

	if game_state and game_state.winner then
		print("Winner: " .. game_state.winner)
	end
end

return M