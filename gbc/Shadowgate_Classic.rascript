// #MinimumVersion = 1.3
// Shadowgate Classic
// #ID = 4933

// $013f: [8-bit] EU/US | Japan   Version Differentiator

// Game is called Shadowgate Classic in US/EUR versions, but Shadowgate Return in Japanese Version
// This matters because apparently the torch life values are in different places in the different versions.
// 
// 0x43=ASCII Letter C   US/EUR Version
// 0x52=ASCII Letter R   Japan Version

function us_version() {
    return byte(0x0013f) == 0x43
}

function j_version() {
    return byte(0x0013f) == 0x52
}

// $C0B4: [8-bit] Song Playing
//        0x01=castle entrance
//        0x02=danger
//        0x04=death
//        0x08=win?
//        0x09=low torch
function song_playing() => byte(0x00C0B4)

// $C420: bit5=dugans ring
function dugans_ring() => bit5(0x00C420)

// $C421: bit3-white stone door
function bit3_white_stone_door() => bit3(0x00C421)

// $C427: bit4=slain werewolf
function slain_werewolf() => bit4(0x00C427)

// $C428: 1=sharon
function sharon() => bit1(0x00C428)

// $C429: bt0= orb   bit5=speared troll
function bt0_orb_bit5_speared_troll() => bit0(0x00C429)
function bt0_orb_bit5_speared_troll() => bit1(0x00C429)
function bt0_orb_bit5_speared_troll_speared_troll() => bit5(0x00C429)

// $C42A: 5=wyvern kill
function wyvern_kill() => bit5(0x00C42A)

// $C42B: bit3=skeleton king bit6=mapopen
function skeleton_king_bit6_mapopen() => bit3(0x00C42B)
function mapopen() => bit6(0x00C42B)

// $C42D: bit0= troll appears
//        bit4= 2 gold coin fine
function bit0_troll_appears_troll_appears() => bit0(0x00C42D)
function bit0_troll_appears_2_gold_coin_fine() => bit4(0x00C42D)

// $C42F: 0x2f = Staff No Blade No Orb
//        0x3f = Blade in Staff
//        0xbf Appears to be for the Blade, Staff, and Orb being combined.
//        
//        SOMETIMES it is the below values instead of the top... I'm not 100% sure why.
//        
//        2e = Sword, Staff, Orb all seperate
//        3e = Sword and Staff Combined
//        0xbe = Blade, Staff, Orb combined
function staff_no_blade_no_orb() => byte(0x00C42F)

// $C431: Sphinx Riddle
//        0x08 = Riddle Asked
//        0x10 = Answered Correctly
function sphinx_riddle() => byte(0x00C431)

// $C438: bit0 = first door bit1=second door bit2=vault door
//        bit3=stone rock door
//        bit7=middle door - Mummy Room Shadowgate Challenge 1
function bit0_first_door_bit1_second_door_bit2_vault_door_middle_door_mummy_room_shadowgate_challenge_1() => bit7(0x00C438)

// $C43A: bit4=wraith kill  bit5=wraith door
//        bit7=rope summon
function bit4_wraith_kill_bit5_wraith_door_wraith_kill_bit5_wraith_door() => bit4(0x00C43A)

// $C43B: bit0= sanctum dfoor
//        bit4=mirror door
function bit0_sanctum_dfoor_mirror_door() => bit4(0x00C43B)

// $C43C: bit1=mummy coffin  bit3=fire room door
function mummy_coffin_bit3_fire_room_door() => bit1(0x00C43C)
function fire_room_door() => bit3(0x00C43C)

// $C441: bit4= fall and die from overlook
function fall_and_die_from_overlook() => bit4(0x00C441)

// $C444: mistake zone? bit0=ledge break bit1=fire clear
//        bit6=keycarpet
function mistake_zone_bit0_ledge_break_bit1_fire_clear_ledge_break_bit1_fire_clear() => bit0(0x00C444)
function mistake_zone_bit0_ledge_break_bit1_fire_clear_fire_clear() => bit1(0x00C444)

// $C458: [8-bit] bitflags
//        bit0=torch
//        bit3=specialtorch
//        bit5=sword
//        bit6=key3
function bitflags_specialtorch() => bit3(0x00C458)
function bitflags_sword() => bit5(0x00C458)
function bitflags_key3() => bit6(0x00C458)

// $C459: bit4-trolled
function bit4_trolled() => bit4(0x00C459)

// $C45A: bit4=sphere
function sphere() => bit4(0x00C45A)

// $C45B: bit1=shield bit2=skull1 bit3=skull2
//        bit5=arrow bit7=torch
//        bit0=hammer?
function bit1_shield_bit2_skull1_bit3_skull2_hammer() => bit0(0x00C45B)
function bit1_shield_bit2_skull1_bit3_skull2_shield_bit2_skull1_bit3_skull2() => bit1(0x00C45B)
function bit1_shield_bit2_skull1_bit3_skull2_skull1_bit3_skull2() => bit2(0x00C45B)
function bit1_shield_bit2_skull1_bit3_skull2_skull2() => bit3(0x00C45B)

// $C45D: bit1=broom bit2=sceptre
function sceptre() => bit2(0x00C45D)

// $C45F: bit4=flute
function flute() => bit4(0x00C45F)

// $C461: bit0=blade
function blade() => bit0(0x00C461)
function bit0_blade() => bit3(0x00C461)

// $C462: 0=staff
function staff() => bit0(0x00C462)

// $C463: bit0= key1  bit1=key2
function key2() => bit1(0x00C463)
function bit0_key1_bit1_key2() => byte(0x00C463)

// $C478: bit0=sling
function sling() => bit0(0x00C478)

// $C4F4: [8-bit] Left Torch Life  (USA/EUR Version)
//        
//        0x10= Weak Light
//        0x64= Fresh Torch
function left_torch_life_usa_eur_version() => byte(0x00C4F4)
function right_torch_life_usa_eur_version() => byte(0x00C4F7)

function left_torch_life_j_version() => byte(0x00C4F8)
function right_torch_life_j_version() => byte(0x00C4FB)

// $C500: Room ID
//        00 - Language Select/Front of Castle Shadowgate
//        01 - Castle Shadowgate Entrance
//        02 - Stone Corridor With Book
//        03 - Vault
//        04 - Four Door Corridor
//        05 - Shark Pool Room
//        06 - Waterfall Room
//        07 - Room Behind The Waterfall
//        08 - Really Cold Room
//        09 - Dragon Room
//        0a - Silver Arrow Passage
//        0b - Chasm Bridges
//        0c - Wraith Room/empty circular room
//        0d - EPOR room
//        0e - Limestone Cavern
//        0f - three mirrors room
//        10 - six coffin room
//        11 - Flaming Inferno Room
//        12 - Troll Bridge
//        13 - Courtyard
//        14 - Drafty Hallway
//        15 - Library
//        16 - Fireplace Room
//        17 - The Laboratory
//        18 - Small Garden
//        1a - Banquet Hall
//        1b - Sphinx Hall
//        1c - Observatory
//        1e - The Tower
//        1f - Circular Room With Torches
//        20 - Night Sky Overlook
//        21 - Arched Corridor Hallway
//        22 - Windy Ledge
//        23 - Outlook
//        24 - Snake Room
//        25 - King's Throne Room
//        26 - Granite Hall
//        27 - Lava Lake Room
//        28 - Orb Puzzle Room
//        29 - Gargoyle Room
//        2a - Well Room
//        2b - River Cavern
//        2c - Skull Gate
//        2d - Summoning Room
function room_id() => byte(0x00C500)

// $C516: [8-bit] Number of torches
//        
//        The number of torches player has available
function number_of_torches() => byte(0x00C516)

// Ticket 89747: I am not sure why it did not unlock the first time, my state were:
//               - low in torch
//               - entered the door to the next area, before coming back to it.
//               
//               IFF it is being low in torch, I am not sure if it affects other achievements or not - worth a check.
achievement(
    title = "Welcome to Castle ShadowGate", points = 5, type="progression",
    description = "Acquire KEY 1.",
    id = 12008, badge = "11874",
    trigger = prev(bit0_key1_bit1_key2()) == 0 && bit0_key1_bit1_key2() == 1 && 
             ((song_playing() == 1) || (song_playing() == 9))
)

achievement(
    title = "The Sword and The Sling", points = 5, type="progression",
    description = "Acquire KEY 2 and raid the vault.",
    id = 12050, badge = "11905", published = "8/28/2014 8:33:37 AM", modified = "7/18/2020 2:40:24 AM",
    trigger = key2() == 1 && bitflags_sword() == 1 && sling() == 1
)

achievement(
    title = "To Cross The Infestation", points = 5, type="progression",
    description = "Acquire KEY 3.",
    id = 12049, badge = "11904", published = "8/28/2014 8:20:39 AM", modified = "5/26/2022 12:30:17 PM",
    trigger = prev(bitflags_key3()) == 0 && bitflags_key3() == 1 && room_id() == 5
)

achievement(
    title = "Frozen Artifact", points = 5,
    description = "Obtain the Sphere.",
    id = 12048, badge = "11903", published = "8/28/2014 7:27:37 AM", modified = "1/19/2021 12:09:51 AM",
    trigger = bit3_white_stone_door() == 1 && sphere() == 1
)

achievement(
    title = "Wisdom Defeats Flame", points = 5, type="progression",
    description = "Chose correctly in the dragon's treasure room.",
    id = 12047, badge = "11890", published = "8/28/2014 6:54:43 AM", modified = "5/26/2022 12:30:17 PM",
    trigger = prev(bit1_shield_bit2_skull1_bit3_skull2_shield_bit2_skull1_bit3_skull2()) == 0 &&
              bit1_shield_bit2_skull1_bit3_skull2_shield_bit2_skull1_bit3_skull2() == 1 && room_id() == 9
)

achievement(
    title = "Glass Ordeal", points = 5, type="progression",
    description = "Pass the room of mirrors.",
    id = 16245, badge = "15775", published = "10/26/2014 7:25:57 AM", modified = "7/18/2020 2:40:19 AM",
    trigger = bit0_sanctum_dfoor_mirror_door() == 1 && bit1_shield_bit2_skull1_bit3_skull2_hammer() == 1
)

achievement(
    title = "The Rump", points = 5,
    description = "The ledge wasn't strong enough to hold you.",
    id = 16241, badge = "15770", published = "10/26/2014 6:44:41 AM", modified = "5/26/2022 12:30:18 PM",
    trigger = prev(mistake_zone_bit0_ledge_break_bit1_fire_clear_ledge_break_bit1_fire_clear()) == 0 &&
              mistake_zone_bit0_ledge_break_bit1_fire_clear_ledge_break_bit1_fire_clear() == 1 && room_id() == 10
)

achievement(
    title = "Inferno Room", points = 5, type="progression",
    description = "Pass the \"Flaming Horror.\"",
    id = 16244, badge = "15776", published = "10/26/2014 7:25:46 AM", modified = "7/18/2020 2:40:15 AM",
    trigger = fire_room_door() == 1 && mistake_zone_bit0_ledge_break_bit1_fire_clear_fire_clear() == 1
)

achievement(
    title = "Death Becomes You", points = 1,
    description = "Died... Get used to it.",
    id = 12014, badge = "11875", published = "8/27/2014 6:27:49 AM", modified = "7/18/2020 2:40:14 AM",
    trigger = song_playing() == 4
)

achievement(
    title = "Greed", points = 5,
    description = "Chose wrong at the outlook.",
    id = 16249, badge = "15781", published = "10/26/2014 8:30:18 AM", modified = "5/26/2022 12:30:18 PM",
    trigger = prev(fall_and_die_from_overlook()) == 0 && fall_and_die_from_overlook() == 1 && room_id() == 35
)

achievement(
    title = "Gauntlet", points = 5,
    description = "Get the [Flute].",
    id = 16250, badge = "15782", published = "10/26/2014 8:38:18 AM", modified = "5/26/2022 12:30:18 PM",
    trigger = prev(flute()) == 0 && flute() == 1 && room_id() == 24
)

achievement(
    title = "Star-Gazer", points = 5,
    description = "Found the [Rod].",
    id = 16252, badge = "15785", published = "10/26/2014 8:47:30 AM", modified = "1/19/2021 12:10:35 AM",
    trigger = mapopen() == 1 && bt0_orb_bit5_speared_troll() == 1
)

achievement(
    title = "Slow Burner", points = 10,
    description = "Save up 10 torches.",
    id = 12015, badge = "11876", published = "8/27/2014 6:30:14 AM", modified = "5/26/2022 12:30:19 PM",
    trigger = prev(number_of_torches()) == 9 && number_of_torches() == 10
)

// Ticket 87451: Thank you for making it a fun achievement.
//               Only the achievement ‘Imminent Darkness’ does not appear to be unlocked when Japan version is used.
//               All others could be unlocked.
//               The Japan version may be due to the short life of the torch.
//               I only unlocked this achievement using the European version.
//               
//               Thanks
achievement(
    title = "Imminent Darkness", points = 5,
    description = "Warning - Light another torch.",
    id = 12026, badge = "11888", 
    trigger = song_playing() == 9 && 
             (
             (us_version() && left_torch_life_usa_eur_version() < 17 && right_torch_life_usa_eur_version() < 17) || 
             (j_version() && left_torch_life_j_version() < 17 && right_torch_life_j_version() < 17)
             )
)

achievement(
    title = "Magic Presence", points = 10,
    description = "Learned the spell of [Humana].",
    id = 16256, badge = "15789", published = "10/26/2014 9:07:49 AM", modified = "10/26/2014 5:48:48 PM",
    trigger = bit7(0x00C488) == 1 &&
              ((byte(0x00C488) == 225) ||
               (byte(0x00C489) == 225) ||
               (byte(0x00C48A) == 225) ||
               (byte(0x00C48B) == 225) ||
               (byte(0x00C48C) == 225) ||
               (byte(0x00C48D) == 225))
)

achievement(
    title = "Magic Unlock", points = 10,
    description = "Learned the spell of [Terra Terrakk].",
    id = 16248, badge = "15779", published = "10/26/2014 8:12:39 AM", modified = "10/26/2014 5:49:23 PM",
    trigger = bit7(0x00C488) == 1 &&
              ((byte(0x00C488) == 226) ||
               (byte(0x00C489) == 226) ||
               (byte(0x00C48A) == 226) ||
               (byte(0x00C48B) == 226) ||
               (byte(0x00C48C) == 226) ||
               (byte(0x00C48D) == 226))
)

achievement(
    title = "Magic Manipulation", points = 10,
    description = "Learned the spell of [Epor].",
    id = 16240, badge = "15772", published = "10/26/2014 6:44:12 AM", modified = "10/26/2014 5:49:46 PM",
    trigger = bit7(0x00C488) == 1 &&
              ((byte(0x00C488) == 224) ||
               (byte(0x00C489) == 224) ||
               (byte(0x00C48A) == 224) ||
               (byte(0x00C48B) == 224) ||
               (byte(0x00C48C) == 224) ||
               (byte(0x00C48D) == 224))
)

achievement(
    title = "Magic Bridge", points = 10,
    description = "Learned the spell of [Motari Riseth].",
    id = 16259, badge = "15792", published = "10/26/2014 9:18:00 AM", modified = "10/26/2014 5:48:29 PM",
    trigger = bit7(0x00C488) == 1 &&
              ((byte(0x00C488) == 228) ||
               (byte(0x00C489) == 228) ||
               (byte(0x00C48A) == 228) ||
               (byte(0x00C48B) == 228) ||
               (byte(0x00C48C) == 228) ||
               (byte(0x00C48D) == 228))
)

achievement(
    title = "Magic Light", points = 10,
    description = "Learned the spell of [Instantum Illumina].",
    id = 16258, badge = "15790", published = "10/26/2014 9:17:58 AM", modified = "10/26/2014 5:48:34 PM",
    trigger = bit7(0x00C488) == 1 &&
              ((byte(0x00C488) == 227) ||
               (byte(0x00C489) == 227) ||
               (byte(0x00C48A) == 227) ||
               (byte(0x00C48B) == 227) ||
               (byte(0x00C48C) == 227) ||
               (byte(0x00C48D) == 227))
)

achievement(
    title = "Barricade of The Wraith", points = 5, type="progression",
    description = "Pass the Wraith beyond the twin bridges.",
    id = 16239, badge = "15771", published = "10/26/2014 6:32:16 AM", modified = "1/19/2021 12:11:29 AM",
    trigger = bit4_wraith_kill_bit5_wraith_door_wraith_kill_bit5_wraith_door() == 1 && bitflags_specialtorch() == 1
)

// Ticket 35335: Didn't trigger for the bellow riddle.
//               MD5: Unknown
// Ticket 35265: The achievement isn't being awarded despite solving the riddle 3+ times
//               MD5: Unknown
achievement(
    title = "Riddle of the Sphinx", points = 5, type="progression",
    description = "Present the correct item to the tower guardian.",
    id = 16251, badge = "15783", published = "10/26/2014 8:42:30 AM", modified = "2/22/2021 6:56:42 PM",
    trigger = prev(sphinx_riddle()) == 8 && sphinx_riddle() == 16
)

achievement(
    title = "Were-Babe", points = 5,
    description = "Get the [Blade].",
    id = 16253, badge = "15786", published = "10/26/2014 8:51:11 AM", modified = "1/19/2021 12:11:31 AM",
    trigger = slain_werewolf() == 1 && blade() == 1
)

achievement(
    title = "Serpent's Lair", points = 5,
    description = "Get the [Staff].",
    id = 16255, badge = "15788", published = "10/26/2014 9:04:32 AM", modified = "5/26/2022 12:30:19 PM",
    trigger = prev(staff()) == 0 && staff() == 1 && room_id() == 36
)

achievement(
    title = "Beyond the HellHound", points = 5,
    description = "Defeat the [Wyvern].",
    id = 16254, badge = "15787", published = "10/26/2014 8:59:04 AM", modified = "1/19/2021 12:11:34 AM",
    trigger = wyvern_kill() == 1 && bit0_blade() == 1
)

achievement(
    title = "Sir Dugan's Seal", points = 5, type="progression",
    description = "Solve the Room of the Skeleton King.",
    id = 16257, badge = "15784", published = "10/26/2014 9:12:38 AM", modified = "1/19/2021 12:11:14 AM",
    trigger = skeleton_king_bit6_mapopen() == 1 && sceptre() == 1 && dugans_ring() == 1
)

achievement(
    title = "Orb Guardian", points = 5, type="progression",
    description = "Solve the switch puzzle for the [Orb].",
    id = 16260, badge = "15793", published = "10/26/2014 9:22:31 AM", modified = "5/26/2022 12:30:19 PM",
    trigger = prev(bt0_orb_bit5_speared_troll()) == 0 && bt0_orb_bit5_speared_troll() == 1 && room_id() == 40
)

achievement(
    title = "Boatman of The River Styx", points = 5,
    description = "Summon Sharon.",
    id = 16261, badge = "15794", published = "10/26/2014 9:29:32 AM", modified = "1/19/2021 12:11:00 AM",
    trigger = sharon() == 1 &&
              ((song_playing() == 7) ||
               (song_playing() == 9))
)

// Ticket 70849: The achievement didn't trigger
// Ticket 39995: Exactly that, it doesn't trigger neither outside or inside the final room
//               MD5: Unknown
// Ticket 39590: Assembled the staff, finished the game, but still didn't trigger. Got the rest of the achievements
//               unlocked.
// Ticket 35253: I received the achievement after defeating the behemoth during the ending scene and not when I
//               combined the required items.
achievement(
    title = "Ultimate Weapon", points = 5,
    description = "Combine the Blade, Staff, and Orb.",
    id = 16262, badge = "15795", published = "10/26/2014 9:39:26 AM", modified = "7/23/2021 4:11:32 AM",
    trigger = ((prev(staff_no_blade_no_orb()) == 63 && staff_no_blade_no_orb() == 191) ||
               (prev(staff_no_blade_no_orb()) == 62 && staff_no_blade_no_orb() == 190))
)

// Ticket 35358: There are two entrances to the room containing the mummy sarcophagus.  The front door (very easy) and
//               a back hallway involving some magic & a rope (harder).
//               
//               The challenge was obviously intended for the user to use the back hallway, but this one can be
//               unlocked by simply opening the front door, entering the room, then closing the door behind you before
//               opening the sarcophagus.
achievement(
    title = "Shadowgate Challenge 1", points = 10,
    description = "Open the Mummy Sarcophagus without opening the door to the room itself.",
    id = 16242, badge = "15773", published = "10/26/2014 6:53:19 AM", modified = "2/22/2021 5:32:28 PM",
    trigger = mummy_coffin_bit3_fire_room_door() == 1 && prev(mummy_coffin_bit3_fire_room_door()) == 0 &&
              bit0_first_door_bit1_second_door_bit2_vault_door_middle_door_mummy_room_shadowgate_challenge_1() == 0 &&
              room_id() == 16 &&
              disable_when(bit0_first_door_bit1_second_door_bit2_vault_door_middle_door_mummy_room_shadowgate_challenge_1()
                  == 1 && room_id() == 16
              ) &&
              (always_false() || (never((room_id() == 2 &&
                    bit0_first_door_bit1_second_door_bit2_vault_door_middle_door_mummy_room_shadowgate_challenge_1() == 0)
                )))
)

achievement(
    title = "Shadowgate Challenge 2", points = 10,
    description = "Walk away unscathed with the 2 skulls from the dragon's room.",
    id = 16243, badge = "15774", published = "10/26/2014 7:04:35 AM", modified = "2/22/2021 6:18:26 PM",
    trigger = bit1_shield_bit2_skull1_bit3_skull2_shield_bit2_skull1_bit3_skull2() == 1 &&
              bit1_shield_bit2_skull1_bit3_skull2_skull1_bit3_skull2() == 1 &&
              bit1_shield_bit2_skull1_bit3_skull2_skull2() == 1 && room_id() == 8 && prev(room_id()) == 9 &&
              song_playing() != 4
)

// Ticket 35356: Multiple people in discord said that they received the achievement by paying the goldcoin to the troll
//               at the 2nd encounter.
//               MD5: Unknown
achievement(
    title = "Shadowgate Challenge 3", points = 10,
    description = "Double your toll and then spear the troll.",
    id = 16246, badge = "15777", published = "10/26/2014 7:35:26 AM", modified = "2/22/2021 6:37:54 PM",
    trigger = bit0_troll_appears_2_gold_coin_fine() == 1 && bit0_troll_appears_troll_appears() == 1 &&
              bt0_orb_bit5_speared_troll_speared_troll() == 1 && prev(bt0_orb_bit5_speared_troll_speared_troll()) == 0
)

achievement(
    title = "ShadowGate Challenge 4", points = 10,
    description = "Complete the game with more than 9 torches.",
    id = 16263, badge = "15796", published = "10/26/2014 9:47:08 AM", modified = "2/22/2021 8:23:29 PM",
    trigger = number_of_torches() > 9 && song_playing() == 8 && prev(song_playing()) != 8
)

achievement(
    title = "Castle ShadowGate", points = 25, type="win_condition",
    description = "Complete The Game.",
    id = 16264, badge = "15797", published = "10/26/2014 9:47:09 AM", modified = "2/22/2021 8:23:32 PM",
    trigger = song_playing() == 8 && prev(song_playing()) != 8
)

achievement(
    title = "Trolled", points = 5,
    description = "Defeat the Cyclops.",
    id = 16247, badge = "15778", published = "10/26/2014 7:46:47 AM", modified = "10/26/2014 7:46:47 AM",
    trigger = bit4_trolled() == 1 && sling() == 1
)

RoomLookup = {
    0x00: "Language Select/Front of Castle Shadowgate",
    0x01: "Castle Shadowgate entrance",
    0x02: "Stone Corridor with book",
    0x03: "Vault",
    0x04: "Four door corridor",
    0x05: "Shark pool room",
    0x06: "Waterfall room",
    0x07: "Room behind the waterfall",
    0x08: "Really cold room",
    0x09: "Dragon room",
    0x0a: "Silver arrow passage",
    0x0b: "Chasm bridges",
    0x0c: "Wraith room",
    0x0d: "EPOR room",
    0x0e: "Limestone cavern",
    0x0f: "Three mirrors room",
    0x10: "Six coffin room",
    0x11: "Flaming inferno room",
    0x12: "Troll bridge",
    0x13: "Courtyard",
    0x14: "Drafty hallway",
    0x15: "Library",
    0x16: "Fireplace room",
    0x17: "The laboratory",
    0x18: "Small garden",
    0x1a: "Banquet hall",
    0x1b: "Sphinx hall",
    0x1c: "Observatory",
    0x1e: "The tower",
    0x1f: "Circular room with torches",
    0x20: "Night sky overlook",
    0x21: "Arched corridor hallway",
    0x22: "Windy ledge",
    0x23: "Outlook",
    0x24: "Snake room",
    0x25: "King's throne room",
    0x26: "Granite hall",
    0x27: "Lava lake room",
    0x28: "Orb puzzle room",
    0x29: "Gargoyle room",
    0x2a: "Well room",
    0x2b: "River cavern",
    0x2c: "Skull gate",
    0x2d: "Summoning room",
}


rich_presence_conditional_display(room_id() == 0, "Ready to begin adventure")

rich_presence_conditional_display(byte(0x0013f) == 0x43, "Torch: {0}% • {1} • Torch: {2}%",
    rich_presence_value("LTorch", left_torch_life_usa_eur_version()),
    rich_presence_lookup("Room", room_id(), RoomLookup, "parts unknown"),
    rich_presence_value("RTorch", right_torch_life_usa_eur_version())
)

rich_presence_conditional_display(byte(0x0013f) == 0x52, "Torch: {0}% • {1} • Torch: {2}%",
    rich_presence_value("LTorch", left_torch_life_j_version()),
    rich_presence_lookup("Room", room_id(), RoomLookup, "parts unknown"),
    rich_presence_value("RTorch", right_torch_life_j_version())
)

rich_presence_display("Oh no, this should never be seen!")