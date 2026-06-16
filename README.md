# TTT2 Immersive Voice
Mod that overrides the custom top-left voice panel from [TTT2](https://github.com/TTT-2/TTT2).

Because the way this works is by overwriting the Draw function of the HUD element, if the TTT2 Voice Panel Element ever changes, this mod will overwrite it and cause it to appear as it looked on July 15th 2026
### Hide Voice Panels
Server variables allow for disabling the UI for specific types of voice chat.
1. Local
2. Traitor/Detective team chat
3. Spectator


### Convars
| Console CMD | Default | Hint |
| --- | --- | --- | 
|ttt2_hide_voice_panel_innocent| 1  | Hides general voice panels voice panels (**in-game green**) |
|ttt2_hide_voice_panel_traitor| 0 | Hides traitor team voice panels (**in-game red**) |
|ttt2_hide_voice_panel_spectator| 0 | Hides spectator voice panels (**in-game yellow**) |
