local IMMUTABLE = require "immutable.immutable"

local M = {}

-- Function to create a new game state
function M.new_game_state()
	local state = {
		board = {     -- 3x3 board represented as a 2D array
			{"", "", ""},
			{"", "", ""},
			{"", "", ""}
		},
		current_player = "X",  -- "X" or "O"
		winner = "none",       -- "X", "O", or "Draw", "none" means no winner yet
	}
	return IMMUTABLE(state)
end

-- Function to make a move
function M.make_move(game_state, game_input)
	local row = game_input.row
	local col = game_input.col

	-- Check if the game is over
	if game_state.winner ~= "none" then
		return game_state, "Game is already over."
	end

	-- Check if the move is valid
	if game_state.board[row][col] ~= "" then
		return game_state, "Cell is already occupied."
	end

	-- Create a new board with the move applied
	local new_board = {}
	for i = 1, 3 do
		new_board[i] = {}
		for j = 1, 3 do
			new_board[i][j] = game_state.board[i][j]
		end
	end
	new_board[row][col] = game_state.current_player

	-- Determine the next player
	local next_player = game_state.current_player == "X" and "O" or "X"

	-- Check for a winner
	local winner = M.check_winner(new_board)

	-- Create a new game states
	local new_state = {
		board = new_board,
		current_player = next_player,
		winner = winner,
	}

	return IMMUTABLE(new_state)
end

-- Function to check for a winner
function M.check_winner(board)
	local lines = {}

	-- Rows and columns
	for i = 1, 3 do
		table.insert(lines, {board[i][1], board[i][2], board[i][3]})
		table.insert(lines, {board[1][i], board[2][i], board[3][i]})
	end

	-- Diagonals
	table.insert(lines, {board[1][1], board[2][2], board[3][3]})
	table.insert(lines, {board[1][3], board[2][2], board[3][1]})

	-- Check lines for a winner
	for _, line in ipairs(lines) do
		if line[1] ~= "" and line[1] == line[2] and line[2] == line[3] then
			return line[1]  -- Return "X" or "O"
		end
	end

	-- Check for a draw
	local is_draw = true
	for i = 1, 3 do
		for j = 1, 3 do
			if board[i][j] == "" then
				is_draw = false
				break
			end
		end
		if not is_draw then break end
	end

	if is_draw then
		return "Draw"
	end

	return "none"  -- Game continues, no winner
end

return M
