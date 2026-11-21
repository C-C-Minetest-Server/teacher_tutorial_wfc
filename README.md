# Wang Fuk Court monthly memorial

Shows a monthly memorial message in memory of the victims of the [Wang Fuk Court fire](https://en.wikipedia.org/wiki/Wang_Fuk_Court_fire).

Between the 26th and 28th of every month, a memorial message is shown to all players upon their first join in the period. The message will not be repeated in the same month, but will be shown again in the next month.

> On 26 November 2025, a large fire broke out at the Wang Fuk Court apartment complex in Hong Kong and burned for two days. 168 lives were lost in this tragedy. Improper use of combustible safety nets and expanded polystyrene foam boards accelerated the spread of the fire, and multiple opportunities to prevent the fire have been missed due to governmental oversight.
>
> On the day of the fire, many Hongkongers helped assist the affected residents; within a few hours, supplies were sufficient. The government established the "Support Fund for Wang Fuk Court in Tai Po" to assist residents and support all relevant work, receiving contributions from all sectors of the community. However, the government bought back the residential units against the residents' will and threatened to forcibly do so by passing a new law, citing that the apartment complex is no longer suitable to live in without publishing inspection reports. A public petition calling for a thorough investigation and an statutory independent Commission of Inquiry was suppressed under the pretext of national security.
>
> The calamity, as well as all the losses of lives and suffers, shall not be forgotten.
>
> "If human error causes a catastrophe, the lesson is not that it's the person's fault, it's that the system is unsafe and lacks guardrails to prevent the same thing happening again in the future." - [by Mlkj, when talking about a Wikipedia incident](https://w.wiki/KJS4).

This mod uses the [Teacher tutorial API](https://content.luanti.org/packages/Emojiminetest/teacher/) to display the message. Please install it for this mod to function correctly.

If [Player Settings](https://content.luanti.org/packages/Emojiminetest/player_settings/) is installed, players can use the `/settings` interface to opt out of the memorial message entirely.

**WARNING**: This mod contains a horrific depiction of the fire spreading across residential buildings. However, the image does not feature depictions of real injuries in graphic detail. The in-game image is just clear enough to identify the fire, while the cover image of this mod is intentionally blurred.

## Configurations

The server-side configuration `teacher_tutorial_wfc.timezone_mode` can be used to control the behavior when deciding whether to show the message to a player.

* **player** (Default): Guesses the player's timezone based on their locale. Shows the memorial message according to the deduced timezone.
* **server**: Shows the memorial message according to the server's system time.
* **hkt**: Always shows the memorial message according to the Hong Kong Time, which is UTC+8.
