if CLIENT then

	print("TTT1-Permanent-Hide-Voice-Panel loaded")

	function GetVoicePanel()
		return hudelements.GetStored("pure_skin_voice")
	end

	-- Mostly the draw code copied from pure_skin_voice.lua with hooked in conditional logic for player type
	function RestrictiveDraw()
		if GetConVar("ttt2_hide_voice_panel"):GetInt() == 1 then
			return
		else
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

				elem:DrawVoiceBar(ply, x, y, w, h)

			y = y + h + elem.padding
			end
		end
	end

	function OverrideVoicePanel()
		local elem = GetVoicePanel()

		if not elem then
			print("TTT1-Permanent-Hide-Voice-Panel: pure_skin_voice not found")
			return
		else
			PrintTable(elem) -- prints the table content
		end

		if GetConVar("ttt2_hide_voice_panel"):GetInt() == 1 then
			elem.Draw = RestrictiveDraw
		end
	end

	--- PostInitPostEntity is called after all TTT1 HUD elements are initialized and mounted.
	hook.Add("PostInitPostEntity", "TTT1-Permanent-Hide-Voice-Panel", OverrideVoicePanel)

end 