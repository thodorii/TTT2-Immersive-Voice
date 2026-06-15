if CLIENT then

	function GetVoicePanel()
		return hudelements.GetStored("pure_skin_voice")
	end

	-- Vanilla HUD Draw code with the inclusion of conditional no-draws depending on voicechat type.
	-- See TTT2/gamemodes/terrortown/gamemode/shared/hud_elements/tttvoice/pure_skin_voice.lua
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
			print("TTT2-Immersive-Voice: pure_skin_voice not found. Either TTT2 is not installed or it has updated and is incompatible.")
			return
		end

		elem.Draw = RestrictiveDraw
	end

	--- PostInitPostEntity is called after all TTT1 HUD elements are initialized and mounted.
	hook.Add("PostInitPostEntity", "TTT2-Immersive-Voice", OverrideVoicePanel)

end 