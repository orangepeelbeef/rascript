// ESWAT: City Under Siege
// #ID = 302

// $D1C8: character sprite animation sheet ec=dead/hurt e8=dead
function character_sprite_animation_sheet_ec_dead_hurt_e8_dead() => byte(0x00D1C8)

// $D1D0: vertical position on stage
function vertical_position_on_stage() => byte(0x00D1D0)
function vertical_position_on_stage() => word(0x00D1D0)

// $D1D4: horizontal position on stage
function horizontal_position_on_stage() => byte(0x00D1D4)
function horizontal_position_on_stage() => word(0x00D1D4)

// $F018: Stage completed flag
function stage_completed_flag() => byte(0x00F018)

// $F560: 03=Boss zone
function boss_zone() => byte(0x00F560)

// $FF0A: Difficulty, 0=easy, 1=medium, 2=hard
function difficulty_0_easy_1_medium_2_hard() => byte(0x00FF0A)
function difficulty() => byte(0x00FF0A)

// $FF10: Starting lives 1-3-5
function starting_lives_1_3_5() => byte(0x00FF10)

// $FF16: 16-bit Score XXX0000
function bit_score_xxx0000() => low4(0x00FF16)
function bit_score_xxx0000() => high4(0x00FF16)
function bit_score_xxx0000() => word(0x00FF16)

// $FF18: 16-bit Score 0000XXXX
function bit_score_0000xxxx() => word(0x00FF18)

// $FF1A: 8-bit Screen State? 00=logos, 02=ingame, 04=attractanimation, 06=missionstart, 0a=credits-endgame, 0c=fadinginout, 0e=drawingplot, 10=mainmenu, 14=continuescreen
function logos_02_ingame_04_attractanimation_06_missionstart_0a_credits_endgame_0c_fadinginout_0e_drawingplot_10_mainmenu_14_continuescreen() => byte(0x00FF1A)

// $FF28: Energy Remaining in fours
function energy_remaining_in_fours() => byte(0x00FF28)

// $FF2C: [8-bit] Level ID
//        
//        0x00=Mission 1 (Guard Silent City!)
//        0x02=Mission 2 (Infiltrate Cyber Prison!)
//        0x10=Mission 2 (Infiltrate Cyber Prison!)
//        0x04=Mission 3 (Defend Neo Three-Mile!)
//        0x06=Mission 4 (Attack Mad Scientist!)
//        0x08=Mission 5 (Destroy Dark Base!)
//        0x0a=Mission 6 (Penetrate Secret Sewer!)
//        0x0c=Mission 7 (Destroy Tactical Complex!)
//        0x0e=Final Mission (Break E.V.E's Plan!)
function level_id() => byte(0x00FF2C)

StageLookup = {
    0x00: "Mission 1 (Guard Silent City!)",
    0x02: "Mission 2 (Infiltrate Cyber Prison!)",
    0x10: "Mission 2 (Infiltrate Cyber Prison!)",
    0x04: "Mission 3 (Defend Neo Three-Mile!)",
    0x06: "Mission 4 (Attack Mad Scientist!) ",
    0x08: "Mission 5 (Destroy Dark Base!)",
    0x0a: "Mission 6 (Penetrate Secret Sewer!)",
    0x0c: "Mission 7 (Destroy Tactical Complex!)",
    0x0e: "Final Mission (Break E.V.E's Plan!)",
}

Mission1 = 0x00
Mission2 = 0x10
Mission3 = 0x04
Mission4 = 0x06
Mission5 = 0x08
Mission6 = 0x0a
Mission7 = 0x0c
Mission8 = 0x0e


// $FF2F: 8-bit - Shot Weapon, 0x01=available, 0xff=Selected
function available_0xff_selected() => byte(0x00FF2F)

// $FF31: 8-bit - Super Weapon, 0x01=available, 0xff=Selected
function available_0xff_selected() => byte(0x00FF31)

// $FF33: 8-bit - R.L. Weapon, 0x01=available, 0xff=Selected
function available_0xff_selected() => byte(0x00FF33)

// $FF35: 8-bit - P.C. Weapon, 0x01=available, 0xff=Selected
function available_0xff_selected() => byte(0x00FF35)

// $FF37: 8-bit - Fire Weapon, 0x01=available, 0xff=Selected
function available_0xff_selected() => byte(0x00FF37)

// $FF38: Lives
function lives() => byte(0x00FF38)

// $FF3D: 8-bit Game is Active=1. Demo=0
function demo_0() => byte(0x00FF3D)

DifficultyLookup = {
    0x0: "Easy",
    0x1: "Normal",
    0x2: "Hard",
}


// recoded cheevos stuff


function pause_if_difficulty_easy() {
    return never(difficulty() == 0)
}

function pause_if_demo() {
    return never(byte(0x00ff3d) == 0x00)
}



function pause_lock_non_shot(mission) {
    return disable_when((level_id() == mission && bit4(0x00f099) == 1 ) && (byte(0x00ff37) == 255 || byte(0x00ff35) == 255 || byte(0x00ff33) == 255 || byte(0x00ff31) == 255), 
             until=(byte(0x00ff1a) == 0x14 || byte(0x00ff1a) == 0x10)
           )
}

function pause_lock_sewage() {
    return disable_when((level_id() == Mission6 && byte(0x00d1d0) == 0xf0), 
             until=(byte(0x00ff1a) == 0x14 || byte(0x00ff1a) == 0x10)
           )
}

achievement(
    title = "Chief I (Defend Neo Three-Mile!)", points = 10,
    description = "Clear Mission 3 using only Shot weapon",
    id = 41980, badge = "43283", 
    trigger = pause_if_difficulty_easy() && pause_if_demo() && pause_lock_non_shot(Mission3) && level_id() == Mission3 &&
              trigger_when(byte(0x00f018) == 0x01 && prev(byte(0x00f018) == 0x00))
)

achievement(
    title = "Chief II (Attack Mad Scientist!)", points = 10,
    description = "Clear Mission 4 using only Shot weapon",
    id = 41981, badge = "43286", 
    trigger = pause_if_difficulty_easy() && pause_if_demo() && pause_lock_non_shot(Mission4) && level_id() == Mission4 &&
              trigger_when(byte(0x00f018) == 0x01 && prev(byte(0x00f018) == 0x00))
)

achievement(
    title = "Chief III (Destroy Dark Base!)", points = 10,
    description = "Clear Mission 5 using only Shot weapon",
    id = 41982, badge = "43289", 
    trigger = pause_if_difficulty_easy() && pause_if_demo() && pause_lock_non_shot(Mission5) && level_id() == Mission5 &&
              trigger_when(byte(0x00f018) == 0x01 && prev(byte(0x00f018) == 0x00))
)

achievement(
    title = "Chief IV (Penetrate Secret Sewer!)", points = 10,
    description = "Clear Mission 6 using only Shot weapon",
    id = 41983, badge = "43292", 
    trigger = pause_if_difficulty_easy() && pause_if_demo() && pause_lock_non_shot(Mission6) && level_id() == Mission6 &&
              trigger_when(byte(0x00f018) == 0x01 && prev(byte(0x00f018) == 0x00))
)

// Ticket 90002: The chief achievements sometimes doesn't pop even though I'm only using shot. Seems to consistently
//               not pop if you're using a continue for the same mission as the achievement.
achievement(
    title = "Chief V (Destroy Tactical Complex!)", points = 10,
    description = "Clear Mission 7 using only Shot weapon",
    id = 41984, badge = "43295",
    trigger = pause_if_difficulty_easy() && pause_if_demo() && pause_lock_non_shot(Mission7) && level_id() == Mission7 &&
              trigger_when(byte(0x00f018) == 0x01 && prev(byte(0x00f018) == 0x00))
)

achievement(
    title = "Chief VI Break E.V.E's Plan!)", points = 25,
    description = "Clear Final Mision using only Shot weapon",
    id = 41985, badge = "43298",
    trigger = pause_if_difficulty_easy() && pause_if_demo() && pause_lock_non_shot(Mission8) && level_id() == Mission8 &&
              trigger_when(byte(0x00f018) == 0x01 && prev(byte(0x00f018) == 0x00))
)


// Ticket 90023: Dipped into the sewage on my way to the boss and died to it. After respawning at the boss checkpoint,
//               I defeated the boss without dipping during the fight and the achievement popped.
// Ticket 24710: <br>MD5: 264d8c7c7b1f476fe6ea98411e3cde35
achievement(
    title = "Mr Clean Officer", points = 10,
    description = "Clear Mission 6 without dipping in the sewage on hard difficulty",
    id = 41998, badge = "43303",
    trigger = difficulty() == 0x2 && pause_lock_sewage() && 
              level_id() == Mission6 && trigger_when(stage_completed_flag() == 1 && prev(stage_completed_flag() == 0))

)



// Didn't touch anything after this


achievement(
    title = "Captain I (Guard Silent City!)", points = 5, type="progression",
    description = "Clear Mission 1",
    id = 41972, badge = "43278", published = "11/10/2016 10:43:40 PM", modified = "6/27/2020 9:12:02 PM",
    trigger = never(difficulty_0_easy_1_medium_2_hard() == 0) && unless(demo_0() != 1) && never(level_id() != 0) &&
              never(boss_zone() != 3) && stage_completed_flag() == 1
)

achievement(
    title = "Captain II (Infiltrate Cyber Prison!)", points = 5, type="progression",
    description = "Clear Mission 2",
    id = 41973, badge = "43280", published = "11/10/2016 10:43:46 PM", modified = "6/27/2020 9:12:04 PM",
    trigger = never(difficulty_0_easy_1_medium_2_hard() == 0) && unless(demo_0() != 1) && never(level_id() != 16) &&
              never(boss_zone() != 3) && stage_completed_flag() == 1
)

achievement(
    title = "Captain III (Defend Neo Three-Mile!)", points = 10, type="progression",
    description = "Clear Mission 3",
    id = 41974, badge = "43282", published = "11/10/2016 10:43:56 PM", modified = "6/27/2020 9:12:06 PM",
    trigger = never(difficulty_0_easy_1_medium_2_hard() == 0) && unless(demo_0() != 1) && never(level_id() != 4) &&
              never(boss_zone() != 3) && stage_completed_flag() == 1
)

achievement(
    title = "Captain IV (Attack Mad Scientist!) ", points = 10, type="progression",
    description = "Clear Mission 4",
    id = 41975, badge = "43285", published = "11/10/2016 10:44:02 PM", modified = "6/27/2020 9:12:08 PM",
    trigger = never(difficulty_0_easy_1_medium_2_hard() == 0) && unless(demo_0() != 1) && never(level_id() != 6) &&
              never(boss_zone() != 3) && stage_completed_flag() == 1
)

achievement(
    title = "Captain V (Destroy Dark Base!)", points = 10, type="progression",
    description = "Clear Mission 5",
    id = 41976, badge = "43288", published = "11/10/2016 10:44:09 PM", modified = "6/27/2020 9:12:09 PM",
    trigger = never(difficulty_0_easy_1_medium_2_hard() == 0) && unless(demo_0() != 1) && never(level_id() != 8) &&
              never(boss_zone() != 3) && stage_completed_flag() == 1
)

achievement(
    title = "Captain VI (Penetrate Secret Sewer!)", points = 10, type="progression",
    description = "Clear Mission 6",
    id = 41977, badge = "43291", published = "11/10/2016 10:44:16 PM", modified = "6/27/2020 9:12:10 PM",
    trigger = never(difficulty_0_easy_1_medium_2_hard() == 0) && unless(demo_0() != 1) && never(level_id() != 10) &&
              never(boss_zone() != 3) && stage_completed_flag() == 1
)

achievement(
    title = "Captain VII (Destroy Tactical Complex!)", points = 10, type="progression",
    description = "Clear Mission 7",
    id = 41978, badge = "43294", published = "11/10/2016 10:44:23 PM", modified = "6/27/2020 9:12:11 PM",
    trigger = never(difficulty_0_easy_1_medium_2_hard() == 0) && unless(demo_0() != 1) && never(level_id() != 12) &&
              never(boss_zone() != 3) && stage_completed_flag() == 1
)

achievement(
    title = "Captain VIII (Break E.V.E's Plan!)", points = 25, type="win_condition",
    description = "Clear Final Mission",
    id = 41979, badge = "43297", published = "11/10/2016 10:44:31 PM", modified = "6/27/2020 9:11:33 PM",
    trigger = never(difficulty_0_easy_1_medium_2_hard() == 0) && unless(demo_0() != 1) && never(level_id() != 14) &&
              logos_02_ingame_04_attractanimation_06_missionstart_0a_credits_endgame_0c_fadinginout_0e_drawingplot_10_mainmenu_14_continuescreen()
              == 10
)

achievement(
    title = "ESWAT I (Guard Silent City!)", points = 10,
    description = "Clear Mission 1 without losing a life on hard difficulty",
    id = 41986, badge = "43279", published = "11/10/2016 10:45:17 PM", modified = "6/27/2020 9:11:26 PM",
    trigger = never(difficulty_0_easy_1_medium_2_hard() != 2) && once(stage_completed_flag() == 1) &&
              never(logos_02_ingame_04_attractanimation_06_missionstart_0a_credits_endgame_0c_fadinginout_0e_drawingplot_10_mainmenu_14_continuescreen()
                  == 20
              ) && never(level_id() != 0) && once(demo_0() == 0) &&
              never(logos_02_ingame_04_attractanimation_06_missionstart_0a_credits_endgame_0c_fadinginout_0e_drawingplot_10_mainmenu_14_continuescreen()
                  == 0
              ) && never(prev(lives()) > lives())
)

achievement(
    title = "ESWAT II (Infiltrate Cyber Prison!)", points = 10,
    description = "Clear Mission 2 without losing a life on hard difficulty",
    id = 41987, badge = "43281", published = "11/10/2016 10:45:25 PM", modified = "6/27/2020 9:11:27 PM",
    trigger = never(difficulty_0_easy_1_medium_2_hard() != 2) && once(level_id() == 0) &&
              never(logos_02_ingame_04_attractanimation_06_missionstart_0a_credits_endgame_0c_fadinginout_0e_drawingplot_10_mainmenu_14_continuescreen()
                  == 20
              ) && never(level_id() == 6) && once(level_id() == 4) &&
              never(logos_02_ingame_04_attractanimation_06_missionstart_0a_credits_endgame_0c_fadinginout_0e_drawingplot_10_mainmenu_14_continuescreen()
                  == 0
              ) && never(prev(lives()) > lives())
)

achievement(
    title = "ESWAT III (Defend Neo Three-Mile!)", points = 10,
    description = "Clear Mission 3 without losing a life on hard difficulty",
    id = 41988, badge = "43284", published = "11/10/2016 10:45:29 PM", modified = "6/27/2020 9:11:29 PM",
    trigger = never(difficulty_0_easy_1_medium_2_hard() != 2) && once(level_id() == 2) &&
              never(logos_02_ingame_04_attractanimation_06_missionstart_0a_credits_endgame_0c_fadinginout_0e_drawingplot_10_mainmenu_14_continuescreen()
                  == 20
              ) && never(level_id() == 8) && once(level_id() == 6) &&
              never(logos_02_ingame_04_attractanimation_06_missionstart_0a_credits_endgame_0c_fadinginout_0e_drawingplot_10_mainmenu_14_continuescreen()
                  == 0
              ) && never(prev(lives()) > lives())
)

achievement(
    title = "ESWAT IV (Attack Mad Scientist!)", points = 25,
    description = "Clear Mission 4 without losing a life on hard difficulty",
    id = 41989, badge = "43287", published = "11/10/2016 10:45:32 PM", modified = "6/27/2020 9:11:31 PM",
    trigger = never(difficulty_0_easy_1_medium_2_hard() != 2) && once(level_id() == 4) &&
              never(logos_02_ingame_04_attractanimation_06_missionstart_0a_credits_endgame_0c_fadinginout_0e_drawingplot_10_mainmenu_14_continuescreen()
                  == 20
              ) && never(level_id() == 10) && once(level_id() == 8) &&
              never(logos_02_ingame_04_attractanimation_06_missionstart_0a_credits_endgame_0c_fadinginout_0e_drawingplot_10_mainmenu_14_continuescreen()
                  == 0
              ) && never(prev(lives()) > lives())
)

achievement(
    title = "ESWAT V (Destroy Dark Base!)", points = 25,
    description = "Clear Mission 5 without losing a life on hard difficulty",
    id = 41990, badge = "43290", published = "11/10/2016 10:45:39 PM", modified = "6/27/2020 9:11:32 PM",
    trigger = never(difficulty_0_easy_1_medium_2_hard() != 2) && once(level_id() == 6) &&
              never(logos_02_ingame_04_attractanimation_06_missionstart_0a_credits_endgame_0c_fadinginout_0e_drawingplot_10_mainmenu_14_continuescreen()
                  == 20
              ) && never(level_id() == 12) && once(level_id() == 10) &&
              never(logos_02_ingame_04_attractanimation_06_missionstart_0a_credits_endgame_0c_fadinginout_0e_drawingplot_10_mainmenu_14_continuescreen()
                  == 0
              ) && never(prev(lives()) > lives())
)

achievement(
    title = "ESWAT VI (Penetrate Secret Sewer!)", points = 25,
    description = "Clear Mission 6 without losing a life on hard difficulty",
    id = 41991, badge = "43293", published = "11/10/2016 10:45:44 PM", modified = "6/27/2020 9:11:19 PM",
    trigger = never(difficulty_0_easy_1_medium_2_hard() != 2) && once(level_id() == 8) &&
              never(logos_02_ingame_04_attractanimation_06_missionstart_0a_credits_endgame_0c_fadinginout_0e_drawingplot_10_mainmenu_14_continuescreen()
                  == 20
              ) && never(level_id() == 14) && once(level_id() == 12) &&
              never(logos_02_ingame_04_attractanimation_06_missionstart_0a_credits_endgame_0c_fadinginout_0e_drawingplot_10_mainmenu_14_continuescreen()
                  == 0
              ) && never(prev(lives()) > lives())
)

achievement(
    title = "ESWAT VII (Destroy Tactical Complex!)", points = 25,
    description = "Clear Mission 7 without losing a life on hard difficulty",
    id = 41992, badge = "43296", published = "11/10/2016 10:45:51 PM", modified = "6/27/2020 9:11:35 PM",
    trigger = never(difficulty_0_easy_1_medium_2_hard() != 2) && once(level_id() == 10) &&
              never(logos_02_ingame_04_attractanimation_06_missionstart_0a_credits_endgame_0c_fadinginout_0e_drawingplot_10_mainmenu_14_continuescreen()
                  == 20
              ) && once(level_id() == 14) &&
              never(logos_02_ingame_04_attractanimation_06_missionstart_0a_credits_endgame_0c_fadinginout_0e_drawingplot_10_mainmenu_14_continuescreen()
                  == 0
              ) && never(prev(lives()) > lives())
)

achievement(
    title = "ESWAT VIII (Destroy Tactical Complex!)", points = 50,
    description = "Clear Mission 8 without losing a life on hard difficulty",
    id = 41993, badge = "43299", published = "11/10/2016 10:46:08 PM", modified = "6/27/2020 9:11:37 PM",
    trigger = never(difficulty_0_easy_1_medium_2_hard() != 2) && once(level_id() == 12) &&
              never(logos_02_ingame_04_attractanimation_06_missionstart_0a_credits_endgame_0c_fadinginout_0e_drawingplot_10_mainmenu_14_continuescreen()
                  == 20
              ) &&
              once(logos_02_ingame_04_attractanimation_06_missionstart_0a_credits_endgame_0c_fadinginout_0e_drawingplot_10_mainmenu_14_continuescreen()
                  == 10
              ) &&
              never(logos_02_ingame_04_attractanimation_06_missionstart_0a_credits_endgame_0c_fadinginout_0e_drawingplot_10_mainmenu_14_continuescreen()
                  == 0
              ) && never(prev(lives()) > lives())
)

achievement(
    title = "Ballistics Expert", points = 5,
    description = "Defeat 50 enemies using Shot weapon",
    id = 41994, badge = "43304", published = "11/10/2016 10:46:26 PM", modified = "10/7/2021 8:24:28 PM",
    trigger = never(difficulty_0_easy_1_medium_2_hard() == 0) && never(demo_0() != 1) &&
              unless(available_0xff_selected() != 255) &&
              measured(repeated(50, prev(bit_score_0000xxxx()) != bit_score_0000xxxx()))
)

achievement(
    title = "Assault Expert", points = 5,
    description = "Defeat 50 enemies using Super weapon",
    id = 41995, badge = "43305", published = "11/10/2016 10:46:30 PM", modified = "10/7/2021 8:24:29 PM",
    trigger = never(difficulty_0_easy_1_medium_2_hard() == 0) && never(demo_0() != 1) &&
              unless(available_0xff_selected() != 255) &&
              measured(repeated(50, prev(bit_score_0000xxxx()) != bit_score_0000xxxx()))
)

achievement(
    title = "Demolition Expert", points = 5,
    description = "Defeat 50 enemies using R. L. weapon",
    id = 41996, badge = "43306", published = "11/10/2016 10:46:34 PM", modified = "10/7/2021 8:24:29 PM",
    trigger = never(difficulty_0_easy_1_medium_2_hard() == 0) && never(demo_0() != 1) &&
              unless(available_0xff_selected() != 255) &&
              measured(repeated(50, prev(bit_score_0000xxxx()) != bit_score_0000xxxx()))
)

achievement(
    title = "Blaster Expert", points = 5,
    description = "Defeat 50 enemies using P. C. weapon",
    id = 41997, badge = "43307", published = "11/10/2016 10:46:38 PM", modified = "10/7/2021 8:24:29 PM",
    trigger = never(difficulty_0_easy_1_medium_2_hard() == 0) && never(demo_0() != 1) &&
              unless(available_0xff_selected() != 255) &&
              measured(repeated(50, prev(bit_score_0000xxxx()) != bit_score_0000xxxx()))
)



achievement(
    title = "Martinet Policeman", points = 25,
    description = "Score 200000 points",
    id = 41999, badge = "43302", published = "11/10/2016 10:46:57 PM", modified = "6/27/2020 9:11:46 PM",
    trigger = never(difficulty_0_easy_1_medium_2_hard() == 0) && never(demo_0() != 1) &&
              never(bit_score_0000xxxx() == 255) && bit_score_xxx0000() >= 32
)

achievement(
    title = "Robo-Copter", points = 10,
    description = "Defeat Robo-Copter without being hit",
    id = 42000, badge = "43242", published = "11/10/2016 10:47:05 PM", modified = "11/10/2016 11:05:10 PM",
    trigger = never(difficulty_0_easy_1_medium_2_hard() == 0) && unless(demo_0() != 1) && never(level_id() != 0) &&
              once(boss_zone() == 0) && once(stage_completed_flag() == 1) &&
              never(character_sprite_animation_sheet_ec_dead_hurt_e8_dead() == 236)
)

// Ticket 54600: THIS TRIGGERED FOR ME DESPITE GETTING HIT ONCE BY THE BOSS'S PROJECTILES. I ENTERED THE BOSS ARENA AT
//               4/4 LIFEBAR.
//               NORMAL MODE.
//               00 LIVES.
//               NO CONTINUES USED YET.
achievement(
    title = "Cyber Destroyers", points = 25,
    description = "Defeat Cyber Destroyers without being hit",
    id = 42001, badge = "43243", published = "11/10/2016 10:47:08 PM", modified = "12/22/2022 5:06:00 PM",
    trigger = never(difficulty_0_easy_1_medium_2_hard() == 0) && unless(demo_0() != 1) && never(level_id() != 16) &&
              once(boss_zone() == 0) && once(stage_completed_flag() == 1) &&
              never(character_sprite_animation_sheet_ec_dead_hurt_e8_dead() == 236) &&
              never(energy_remaining_in_fours() < prev(energy_remaining_in_fours()))
)

achievement(
    title = "Name Unknown", points = 25,
    description = "Defeat the  Mission 3 boss without being hit using only Shot weapon",
    id = 42002, badge = "43245", published = "11/10/2016 10:47:12 PM", modified = "6/27/2020 9:12:01 PM",
    trigger = never(difficulty_0_easy_1_medium_2_hard() == 0) && unless(demo_0() != 1) && never(level_id() != 4) &&
              once(boss_zone() == 0) && once(stage_completed_flag() == 1) &&
              never(prev(energy_remaining_in_fours()) > energy_remaining_in_fours()) &&
              never(available_0xff_selected() != 255)
)

achievement(
    title = "Slime Launcher", points = 25,
    description = "Defeat Slime Launcher without being hit using only Shot weapon",
    id = 42003, badge = "43247", published = "11/10/2016 10:47:17 PM", modified = "6/27/2020 9:11:59 PM",
    trigger = never(difficulty_0_easy_1_medium_2_hard() == 0) && unless(demo_0() != 1) && never(level_id() != 6) &&
              once(boss_zone() == 0) && once(stage_completed_flag() == 1) &&
              never(prev(energy_remaining_in_fours()) > energy_remaining_in_fours()) &&
              never(available_0xff_selected() != 255)
)

// Ticket 69677: Triggered upon dying and being sent back to the checkpoint immediately after this fight.
achievement(
    title = "Dark Shadow", points = 25,
    description = "Defeat Dark Shadow during its first strike without being hit and only with Shot",
    id = 42004, badge = "43248", published = "11/10/2016 10:47:20 PM", modified = "6/27/2020 9:11:58 PM",
    trigger = never(difficulty_0_easy_1_medium_2_hard() == 0) && unless(demo_0() != 1) && never(level_id() != 8) &&
              once(byte(0x00D0BF) == 0) && once(byte(0x00D0BF) == 255) &&
              never(prev(energy_remaining_in_fours()) > energy_remaining_in_fours()) &&
              never(available_0xff_selected() != 255)
)

achievement(
    title = "Dark Shadow's Revenge", points = 25,
    description = "Defeat Dark Shadow for good without being hit using only Shot weapon",
    id = 42005, badge = "43249", published = "11/10/2016 10:47:24 PM", modified = "6/27/2020 9:11:55 PM",
    trigger = never(difficulty_0_easy_1_medium_2_hard() == 0) && unless(demo_0() != 1) && never(level_id() != 8) &&
              once(boss_zone() == 0) && once(stage_completed_flag() == 1) &&
              never(prev(energy_remaining_in_fours()) > energy_remaining_in_fours()) &&
              never(available_0xff_selected() != 255)
)

achievement(
    title = "Digging Sewer Snake", points = 10,
    description = "Defeat Digging Sewer Snake without being hit using only Shot weapon",
    id = 42006, badge = "43250", published = "11/10/2016 10:47:28 PM", modified = "6/27/2020 9:11:53 PM",
    trigger = never(difficulty_0_easy_1_medium_2_hard() == 0) && unless(demo_0() != 1) && never(level_id() != 10) &&
              once(boss_zone() == 0) && once(stage_completed_flag() == 1) &&
              never(prev(energy_remaining_in_fours()) > energy_remaining_in_fours()) &&
              never(available_0xff_selected() != 255)
)

// Ticket 65585: i ve checked in four version(retroarch & RALibRetro) and doesn't works, any idea?
//               or use the japan version to unlock this chevos...
//               -Dry Ice 53 chevos hunter :D
//               pda: is probably errata on that chevos or is my impression
// Ticket 12396: Triggered right before these boss(es).
achievement(
    title = "Cyber Destroyers 2.0", points = 10,
    description = "Defeat Cyber Destroyers 2.0 without being hit using only Shot weapon (Have the Shot weapon selected before entering the room, and don't change it!)",
    id = 42008, badge = "43252", published = "11/10/2016 10:47:35 PM", modified = "6/27/2020 9:11:52 PM",
    trigger = never(difficulty_0_easy_1_medium_2_hard() == 0) && never(demo_0() != 1) && never(level_id() != 12) &&
              never(vertical_position_on_stage() >= 288) && never(vertical_position_on_stage() <= 68) &&
              never(horizontal_position_on_stage() <= 1739) && never(horizontal_position_on_stage() >= 2261) &&
              never(prev(energy_remaining_in_fours()) > energy_remaining_in_fours()) &&
              never(available_0xff_selected() != 255) &&
              once(vertical_position_on_stage() <= 242 && horizontal_position_on_stage() >= 1740 &&
                  horizontal_position_on_stage() <= 1774
              ) &&
              once(horizontal_position_on_stage() >= 1740 && vertical_position_on_stage() >= 243 &&
                  vertical_position_on_stage() <= 287
              )
)

// Ticket 20570: 
achievement(
    title = "Security Maintainer", points = 10,
    description = "Defeat Security Maintainer without being hit using only Shot weapon",
    id = 42009, badge = "43254", published = "11/10/2016 10:47:39 PM", modified = "6/27/2020 9:11:51 PM",
    trigger = never(difficulty_0_easy_1_medium_2_hard() == 0) && unless(demo_0() != 1) && never(level_id() != 12) &&
              never(vertical_position_on_stage() < 241) && once(stage_completed_flag() == 1) &&
              never(prev(energy_remaining_in_fours()) > energy_remaining_in_fours()) &&
              never(available_0xff_selected() != 255) && never(horizontal_position_on_stage() < 1792) &&
              once(vertical_position_on_stage() == 256) && never(vertical_position_on_stage() > 1072)
)

achievement(
    title = "ICE Double", points = 25,
    description = "Defeat ICE Double without being hit using only Shot weapon",
    id = 42010, badge = "43255", published = "11/10/2016 10:47:45 PM", modified = "6/27/2020 9:11:49 PM",
    trigger = never(difficulty_0_easy_1_medium_2_hard() == 0) && unless(demo_0() != 1) && never(level_id() != 14) &&
              never(vertical_position_on_stage() < 241) && once(stage_completed_flag() == 1) &&
              never(prev(energy_remaining_in_fours()) > energy_remaining_in_fours()) &&
              never(available_0xff_selected() != 255) && never(horizontal_position_on_stage() > 640) &&
              once(horizontal_position_on_stage() >= 576) && never(vertical_position_on_stage() < 2384)
)

achievement(
    title = "Fully Loaded", points = 5,
    description = "Collect Every ESWAT Weapon Type at once",
    id = 929, badge = "01151", published = "5/15/2013 11:16:09 PM", modified = "6/27/2020 9:12:13 PM",
    trigger = available_0xff_selected() != 0 && available_0xff_selected() != 0 && available_0xff_selected() != 0 &&
              available_0xff_selected() != 0 && available_0xff_selected() != 0 && demo_0() == 1
)

// Ticket 8589: I used the fire and even then the achievement was unlocked
achievement(
    title = "Fight Fire without Fire", points = 10,
    description = "Finish the game without using Fire weapon",
    id = 42011, badge = "43300", published = "11/10/2016 10:47:52 PM", modified = "10/20/2019 2:56:01 PM",
    trigger = never(difficulty_0_easy_1_medium_2_hard() == 0) && once(demo_0() == 0) && once(level_id() == 0) &&
              once(level_id() == 2) && once(level_id() == 4) && once(level_id() == 6) && once(level_id() == 8) &&
              once(level_id() == 10) && once(level_id() == 12) && once(level_id() == 14) && once(level_id() == 16) &&
              once(logos_02_ingame_04_attractanimation_06_missionstart_0a_credits_endgame_0c_fadinginout_0e_drawingplot_10_mainmenu_14_continuescreen()
                  == 10
              ) && never(character_sprite_animation_sheet_ec_dead_hurt_e8_dead() == 200)
)

achievement(
    title = "Solid-Steel Dynamite", points = 25,
    description = "Finish the game without using continues starting with on life",
    id = 42012, badge = "43301", published = "11/10/2016 10:47:55 PM", modified = "6/27/2020 9:12:16 PM",
    trigger = never(difficulty_0_easy_1_medium_2_hard() == 0) && once(demo_0() == 0) && once(level_id() == 0) &&
              once(level_id() == 2) && once(level_id() == 4) && once(level_id() == 6) && once(level_id() == 8) &&
              once(level_id() == 10) && once(level_id() == 12) && once(level_id() == 14) && once(level_id() == 16) &&
              once(logos_02_ingame_04_attractanimation_06_missionstart_0a_credits_endgame_0c_fadinginout_0e_drawingplot_10_mainmenu_14_continuescreen()
                  == 10
              ) && never(starting_lives_1_3_5() != 0) &&
              never(logos_02_ingame_04_attractanimation_06_missionstart_0a_credits_endgame_0c_fadinginout_0e_drawingplot_10_mainmenu_14_continuescreen()
                  == 20
              )
)

achievement(
    title = "Once More, The World Is Safe", points = 25,
    description = "Complete ESWAT on Hard Difficulty",
    id = 931, badge = "01153", published = "5/16/2013 12:37:29 AM", modified = "6/27/2020 9:12:17 PM",
    trigger = logos_02_ingame_04_attractanimation_06_missionstart_0a_credits_endgame_0c_fadinginout_0e_drawingplot_10_mainmenu_14_continuescreen()
              == 10 && difficulty_0_easy_1_medium_2_hard() == 2
)

achievement(
    title = "Thrasher", points = 10,
    description = "Defeat Thrasher without being hit using only Shot weapon",
    id = 42007, badge = "43251", published = "11/10/2016 10:47:32 PM", modified = "11/10/2016 11:06:17 PM",
    trigger = never(difficulty_0_easy_1_medium_2_hard() == 0) && unless(demo_0() != 1) && never(level_id() != 12) &&
              once(vertical_position_on_stage() > 1408) && once(vertical_position_on_stage() < 1280) &&
              never(prev(energy_remaining_in_fours()) > energy_remaining_in_fours()) &&
              never(available_0xff_selected() != 255)
)

achievement(
    title = "Duke Oda", points = 10,
    description = "Clear Mission 1",
    id = 1013, badge = "01241", published = "5/17/2013 11:56:06 AM", modified = "5/17/2013 1:00:52 PM",
    trigger = level_id() == 2
)

achievement(
    title = "Cyber Prison Infiltrated", points = 10,
    description = "Clear Mission 2",
    id = 1012, badge = "01242", published = "5/17/2013 11:56:02 AM", modified = "5/17/2013 1:00:48 PM",
    trigger = level_id() == 4
)

achievement(
    title = "Neo Three-Mile Defended", points = 10,
    description = "Clear Mission 3",
    id = 1014, badge = "01244", published = "5/17/2013 11:59:01 AM", modified = "5/17/2013 1:00:54 PM",
    trigger = level_id() == 6
)

achievement(
    title = "Mad Scientist", points = 10,
    description = "Clear Mission 4",
    id = 1015, badge = "01245", published = "5/17/2013 12:09:13 PM", modified = "5/17/2013 1:00:57 PM",
    trigger = level_id() == 8
)

achievement(
    title = "Dark Base Destroyed", points = 10,
    description = "Clear Mission 5",
    id = 1016, badge = "01246", published = "5/17/2013 12:09:18 PM", modified = "5/17/2013 1:00:59 PM",
    trigger = level_id() == 10
)

achievement(
    title = "Secret Sewer", points = 10,
    description = "Clear Mission 6",
    id = 1017, badge = "01248", published = "5/17/2013 12:09:21 PM", modified = "5/17/2013 1:01:01 PM",
    trigger = level_id() == 12
)

achievement(
    title = "Tactical Complex Destroyed", points = 10,
    description = "Clear Mission 7",
    id = 1018, badge = "01247", published = "5/17/2013 12:09:28 PM", modified = "5/17/2013 1:01:03 PM",
    trigger = level_id() == 14
)

achievement(
    title = "Two Shocking Facts", points = 20,
    description = "Complete ESWAT on any difficulty",
    id = 930, badge = "01152", published = "5/16/2013 12:28:01 AM", modified = "5/16/2013 12:28:12 AM",
    trigger = logos_02_ingame_04_attractanimation_06_missionstart_0a_credits_endgame_0c_fadinginout_0e_drawingplot_10_mainmenu_14_continuescreen()
              == 10
)

rich_presence_display("{0}, Lives: {1}, Score: {2} ({3})",
    rich_presence_lookup("Stage", level_id(), StageLookup),
    rich_presence_value("Lives", lives()),
    rich_presence_value("Score", low4(0x00FF17) * 1000000 + bit_score_xxx0000() * 100000 + bit_score_xxx0000() * 10000 +
                            high4(0x00FF19) * 1000 + low4(0x00FF19) * 100
                        ),
    rich_presence_lookup("Difficulty", low4(0x00FF0A), DifficultyLookup)
)
