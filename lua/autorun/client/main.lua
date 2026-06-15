if CLIENT then

	print("TTT1-Permanent-Hide-Voice-Panel loaded")

	function GetVoicePanel()
		return hudelements.GetStored("pure_skin_voice")
	end

	-- Mostly the draw code copied from pure_skin_voice.lua with hooked in conditional logic for player type
	function RestrictiveDraw()
		local hide_innocent = GetConVar("ttt2_hide_voice_panel_innocent"):GetInt() == 1
		local hide_traitor = GetConVar("ttt2_hide_voice_panel_traitor"):GetInt() == 1
		local hide_spectator = GetConVar("ttt2_hide_voice_panel_spectator"):GetInt() == 1

		local elem = GetVoicePanel()
		local client = LocalPlayer()

		local pos = elem:GetPos()
		local size = elem:GetSize()
		local x, y = pos.x, pos.y
		local w, h = size.w, size.h

		local plys = player.GetAll()
		local plysSorted = {}

		for i = 1, #plys do
			local ply = plys[i]

			if not VOICE.IsSpeaking(ply) then
				continue
			end

			if ply == client then
				table.insert(plysSorted, 1, ply)

				continue
			end

			plysSorted[#plysSorted + 1] = ply
		end

		for i = 1, #plysSorted do
			local ply = plysSorted[i]

			if hide_innocent and ply.voiceMode == VOICE_MODE_GLOBAL then
				continue
			end
			if hide_traitor and ply.voiceMode == VOICE_MODE_TEAM then
				continue
			end
			if hide_spectator and ply.voiceMode == VOICE_MODE_SPEC then
				continue
			end

			elem:DrawVoiceBar(ply, x, y, w, h)

		y = y + h + elem.padding
		end
	end

	function OverrideVoicePanel()
		local elem = GetVoicePanel()

		if not elem then
			print("TTT1-Permanent-Hide-Voice-Panel: pure_skin_voice not found")
			return
		end

		elem.Draw = RestrictiveDraw
	end

	--- PostInitPostEntity is called after all TTT1 HUD elements are initialized and mounted.
	hook.Add("PostInitPostEntity", "TTT1-Permanent-Hide-Voice-Panel", OverrideVoicePanel)

end 