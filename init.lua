-- teacher_tutorial_wfc/init.lua
-- Monthly mourning message of the Wang Fuk Court Fire
-- Copyright (c) 2026  1F616EMO
-- SPDX-License-Identifier: LGPL-3.0-or-later

teacher_tutorial_wfc = {}

local S = core.get_translator("teacher_tutorial_wfc")
local MP = core.get_modpath("teacher_tutorial_wfc")

local get_datetable

do
    local settings_timezone_mode = core.settings:get("teacher_tutorial_wfc.timezone_mode")

    if settings_timezone_mode == "hkt" then
        -- Always Hong Kong Time, UTC+8

        get_datetable = function()
            local utc_time = os.time(os.date("!*t"))
            local hkt_time = utc_time + 8 * 3600

            return os.date("!*t", hkt_time)
        end
    elseif settings_timezone_mode == "server" then
        get_datetable = function()
            return os.date("*t")
        end
    else
        -- player: use player timezone
        local locale_offsets = dofile(MP .. "/data/locale_offsets.lua")

        get_datetable = function(player_name)
            local plinfo = player_name and core.get_player_information(player_name)
            local locale = plinfo and plinfo.locale
            local offset = locale and locale_offsets[locale] or 0

            local utc_time = os.time(os.date("!*t"))
            local local_time = utc_time + offset * 3600

            return os.date("!*t", local_time)
        end
    end
end

-- Determine if we are inside the mourning period for that player
-- Returns current month in format of YYYYMM if yes, nil otherwise
---@param string player_name
---@return number?
function teacher_tutorial_wfc.is_wfc_mourning(player_name)
    local datetable = get_datetable(player_name)
    local this_date = datetable.day

    if this_date < 26 or this_date > 28 then
        return nil
    end

    return datetable.year * 100 + datetable.month
end

-- Should be the w.wiki short link of the language.
local WFC_WIKILINK = S("https://w.wiki/GSeT")

-- Translation guide: BOTH English and Chinese (Traditional) should be seen as the source languages.
teacher.register_tutorial("teacher_tutorial_wfc:wfc", {
    title = S("The Wang Fuk Court fire"),
    {
        texture = "teacher_tutorial_wfc_wfc_1.jpg",
        text = {
            S(
                "On 26 November 2025, a large fire broke out at the " ..
                "Wang Fuk Court apartment complex in Hong Kong and burned " ..
                "for two days. 168 lives were lost in this tragedy. " ..
                "Improper use of combustible safety nets and expanded " ..
                "polystyrene foam boards accelerated the spread of the " ..
                "fire, and multiple opportunities to prevent the fire have " ..
                "been missed due to governmental oversight."
            ),
            S(
                "On the day of the fire, many Hongkongers helped assist the " ..
                "affected residents; within a few hours, supplies were " ..
                "sufficient. The government established the \"Support Fund " ..
                "for Wang Fuk Court in Tai Po\" to assist residents and " ..
                "support all relevant work, receiving contributions from " ..
                "all sectors of the community. However, the government " ..
                "misappropriated part of the relief fund to buy back the " ..
                "residential units against the residents' will and " ..
                "threatened to forcibly do so by passing a new law, citing " ..
                "that the apartment complex is no longer suitable to live " ..
                "in without publishing inspection reports. A public " ..
                "petition calling for a thorough investigation and an " ..
                "statutory independent Commission of Inquiry was suppressed " ..
                "under the pretext of national security."
            ),
            S(
                "The calamity, as well as all the losses of lives and " ..
                "suffers, shall not be forgotten."
            ),
            S(
                "\"If human error causes a catastrophe, the lesson is not " ..
                "that it's the person's fault, it's that the system is " ..
                "unsafe and lacks guardrails to prevent the same thing " ..
                "happening again in the future.\" - by Mlkj, when talking " ..
                "about a Wikipedia incident, @1", "https://w.wiki/KJS4"
            ),
            S("Learn more: @1", WFC_WIKILINK),
        },
    },
})

if core.global_exists("player_settings") then
    local metacategory_name = "ps_default_av"
    if not player_settings.registered_metacategories[metacategory_name] then
        core.log("warning",
            "[teacher_tutorial_wfc] Default category ps_default_av not found, " ..
            "registering our own metacategory. Please update player_settings!")

        metacategory_name = "teacher_tutorial_wfc"
        player_settings.register_metacategory("teacher_tutorial_wfc", {
            title = S("WFC Fire Memorial"),
        })
    end

    player_settings.register_category("teacher_tutorial_wfc_category", {
        title = S("WFC Fire Memorial"),
        metacategory = metacategory_name
    })

    player_settings.register_setting("teacher_tutorial_wfc_noshow", {
        type = "bool",
        description = S("Never show the Wang Fuk Court fire memorial message again"),
        long_description = S("Never show the Wang Fuk Court fire memorial message on 26 to 28 November every year."),
        default = false,
        category = "teacher_tutorial_wfc_category",
    })
end

core.register_on_joinplayer(function(player)
    local player_name = player:get_player_name()
    local this_month = teacher_tutorial_wfc.is_wfc_mourning(player_name)

    if not this_month then
        return
    end

    local _, optout = player_settings.get_setting(player_name, "teacher_tutorial_wfc_noshow")
    if optout then
        core.log("action", "[teacher_tutorial_wfc] Player " .. player_name ..
            " has opted-out the mourning message, skipping.")
        return
    end

    local meta = player:get_meta()
    if meta:get_int("teacher_tutorial_wfc_wfc_message_last") < this_month then
        meta:set_int("teacher_tutorial_wfc_wfc_message_last", this_month)
        core.log("action", "[teacher_tutorial_wfc] Showing mourning message to player " .. player_name)

        -- Show regardless of whether this have been unlocked before
        teacher.unlock_entry_for_player(player, "teacher_tutorial_wfc:wfc")
        teacher.simple_show(player, "teacher_tutorial_wfc:wfc")
    end
end)
