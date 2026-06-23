SMODS.Atlas({
	key = "modicon",
	path = "modicon.png",
	px = 32,
	py = 32
})

logo = "balatro.png"

SMODS.Atlas({
		key = "balatro",
		path = logo,
		px = 333,
		py = 216,
		prefix_config = { key = false }
	})


G.FUNCS.fake_win_button = function()
	-- oh you you actually clicked something? then i'll laugh even harder!
	G.showlaughingcat = 548
	--G.FUNCS.exit_overlay_menu()
end


local origHookWin = create_UIBox_win
function create_UIBox_win()
	local contents = origHookWin()
	print(G.showlaughingcat)
	if G.showlaughingcat and G.showlaughingcat >0 then
		--setup text
		local replacementTable = {
			{
				-- on endless, already fooled
				{"why","why tho","just why"},
				{"warning","warning","incoming HORSE"},
				{"warning","warning","incoming HONSE"},
				{"PETAH","THE HORSE","IS COMING"},
				{"PETAH","THE HONSE","IS COMING"},
				{"FOOL","FOOOOOL","oh wait it's you"},
			},
			{
				-- on endless
				{"why","why tho","just why"},
				{"FOOL","FOOL","you are a FOOL"},
			},
			{
				--already fooled
				{"really","REALLY","anyway here's a HORSE"},
				{"you serious","ru srs","really now"},
				{"PETAH","THE HORSE","IS COMING"},
				{"PETAH","THE HONSE","IS COMING"},
				{"warning","warning","incoming HORSE"},
				{"warning","warning","incoming HONSE"},
				{"FOOL","FOOOOOL","oh wait it's you"}
			}
		} 
		local newGameText = contents.nodes[1].nodes[2].nodes[1].nodes[1].nodes[1].nodes[2].nodes[1].nodes[2].nodes[2].nodes[5].nodes[1].nodes[1].nodes[1].config.text
		local mainMenuText = contents.nodes[1].nodes[2].nodes[1].nodes[1].nodes[1].nodes[2].nodes[1].nodes[2].nodes[2].nodes[7].nodes[1].nodes[1].nodes[1].config.text
		local endlessModeText = contents.nodes[1].nodes[2].nodes[1].nodes[1].nodes[1].nodes[2].nodes[1].nodes[3].nodes[1].nodes[1].nodes[1].nodes[1].config.text
		
		if(G.GAME.round_resets.ante>G.GAME.win_ante) then 
			
			if (G.GAME.fooledbywincard and G.GAME.fooledbywincard>0) then
				
				local tableindex = math.random(1,#replacementTable[1])
				newGameText = replacementTable[1][tableindex][1]
				mainMenuText = replacementTable[1][tableindex][2]
				endlessModeText = replacementTable[1][tableindex][3]
			else
				local tableindex = math.random(1,#replacementTable[2])
				newGameText = replacementTable[2][tableindex][1]
				mainMenuText = replacementTable[2][tableindex][2]
				endlessModeText = replacementTable[2][tableindex][3]
			end
		elseif(G.GAME.fooledbywincard and G.GAME.fooledbywincard>0) then
			
			local tableindex = math.random(1,#replacementTable[3])
				newGameText = replacementTable[3][tableindex][1]
				mainMenuText = replacementTable[3][tableindex][2]
				endlessModeText = replacementTable[3][tableindex][3]
		 end 
		
		--new game button
		contents.nodes[1].nodes[2].nodes[1].nodes[1].nodes[1].nodes[2].nodes[1].nodes[2].nodes[2].nodes[5].nodes[1].config.button = "fake_win_button"
		--main menu button
		contents.nodes[1].nodes[2].nodes[1].nodes[1].nodes[1].nodes[2].nodes[1].nodes[2].nodes[2].nodes[7].nodes[1].config.button = "fake_win_button"
		--endless mode button
		contents.nodes[1].nodes[2].nodes[1].nodes[1].nodes[1].nodes[2].nodes[1].nodes[3].nodes[1].nodes[1].config.button = "fake_win_button"
		--new game button
		contents.nodes[1].nodes[2].nodes[1].nodes[1].nodes[1].nodes[2].nodes[1].nodes[2].nodes[2].nodes[5].nodes[1].nodes[1].nodes[1].config.text = newGameText
		--main menu button

		contents.nodes[1].nodes[2].nodes[1].nodes[1].nodes[1].nodes[2].nodes[1].nodes[2].nodes[2].nodes[7].nodes[1].nodes[1].nodes[1].config.text = mainMenuText
		--endless mode button
		contents.nodes[1].nodes[2].nodes[1].nodes[1].nodes[1].nodes[2].nodes[1].nodes[3].nodes[1].nodes[1].nodes[1].nodes[1].config.text = endlessModeText
	end

	return contents
end


