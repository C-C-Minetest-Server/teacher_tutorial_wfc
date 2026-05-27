# Wang Fuk Court monthly memorial

Shows a monthly memorial message in memory of the victims of the [Wang Fuk Court fire](https://en.wikipedia.org/wiki/Wang_Fuk_Court_fire).

Between the 26th and 28th of every month, a memorial message is shown to all players upon their first join in the period. The message will not be repeated in the same month, but will be shown again in the next month.

This mod uses the [Teacher tutorial API](https://content.luanti.org/packages/Emojiminetest/teacher/) to display the message. Please install it for this mod to function correctly.

If [Player Settings](https://content.luanti.org/packages/Emojiminetest/player_settings/) is installed, players can use the `/settings` interface to opt out of the memorial message entirely.

**WARNING**: This mod contains a horrific depiction of the fire spreading across residential buildings. However, the image does not feature depictions of real injuries in graphic detail. The in-game image is just clear enough to identify the fire, while the cover image of this mod is intentionally blurred.

## Configurations

The server-side configuration `teacher_tutorial_wfc.timezone_mode` can be used to control the behavior when deciding whether to show the message to a player.

* **player** (Default): Guesses the player's timezone based on their locale. Shows the memorial message according to the deduced timezone.
* **server**: Shows the memorial message according to the server's system time.
* **hkt**: Always shows the memorial message according to the Hong Kong Time, which is UTC+8.
