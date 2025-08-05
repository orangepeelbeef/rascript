// Journey Escape
// #ID = 33180

// $0000: [8-bit] Player X Position
function player_x_position() => byte(0x000000)

// $0002: [8-bit] Active Object Index
function active_object_index() => byte(0x000002)

// $0010: [8-bit][BCD] Score XX0000
function bcd_score_xx0000() => byte(0x000010)

// $0011: [8-bit][BCD] Score 00XX00
function bcd_score_00xx00() => byte(0x000011)

// $0012: [8-bit][BCD] Score 0000XX
function bcd_score_0000xx() => byte(0x000012)

// $0013: [8-bit] Band Members Saved / Level
//        
//        0x00= SS  Level 1
//        0x01= JC   Level 2
//        0x02= RV  Level 3
//        0x03= NS  Level 4
//        0x04= SP  Level 5
function level() => byte(0x000013)

// $0014: 0x00=in between a level
//        0x80=lost?
function in_between_a_level() => byte(0x000014)

// $0015: [8-bit] Timer Minutes
function timer_minutes() => bcd(byte(0x000015))

// $0016: [8-bit] Timer Seconds
function timer_seconds() => bcd(byte(0x000016))

// $0017: [8-bit][BCD] Score Backup XX0000
function bcd_score_backup_xx0000() => byte(0x000017)

// $0018: [8-bit][BCD] Score Backup 00XX00
function bcd_score_backup_00xx00() => byte(0x000018)

// $0019: [8-bit][BCD] Score Backup 0000XX
function bcd_score_backup_0000xx() => byte(0x000019)

// $0020: [8-bit] Size Control Byte Object 1
//        
//        // --- NUMBER & SPACING (3-bit value) ---
//        bit2, bit1, bit0: These 3 bits combine to set the number of sprite copies.
//        000 = 1 copy
//        001 = 2 copies (close)
//        010 = 2 copies (medium)
//        011 = 3 copies (close)
//        100 = 2 copies (far)
//        101 = 1 copy (special double-width mode)
//        110 = 3 copies (medium)
//        
//        // --- MISSILE ---
//        bit3: Sets Missile Size (0=Normal, 1=Wide).
//        
//        // --- SPRITE WIDTH (2-bit value) ---
//        bit5, bit4: These 2 bits combine to set the pixel width of each sprite.
//        00 = 1x Width (Normal)
//        01 = 2x Width (Double)
//        10 = 4x Width (Quad)


// $0028: [8-bit] Player Vertical Position
//        
//        0x8d = bottom of screen
//        0x37 = "top" of screen at least as high as you can go
function player_vertical_position() => byte(0x000028)

// $002E: [8-bit] Collided Object Index
//        
//        added to 0x30 to determine the object collided with
function collided_object_index() => byte(0x00002E)

// $0030: [8-bit] Object 1 ID
//        
//        0x00 = Sneaky Photographer
//        0x10 = Groupie
//        0x30 = Stage Gate
//        0x40 = Shady Promoter
//        0x50 = Roadie
//        0x60 = Ship
//        0x70 = Manager

// $0053: [8-bit] movement speed


// $0058: [8-bit] Demo
//        
//        0x0=In Demo
//        0x1=Player has pressed start (could be in between levels)
function demo() => byte(0x000058)

// $005A: [8-bit] Music ID
//        
//        0x00=menu / in between level music
//        0x01=playing level music
//        0x02=invulnerable (manager)
//        0x04=thump (collision with other object)
//        0x05=temp invulnerable (roadie)
//        0x06=silence
function music_id() => byte(0x00005A)

// $005C: [8-bit] Invulnerability Timer
//        
//        0xff= not invulnerable
//function invulnerability_timer() => byte(0x00005C)

// $007B: [8-bit] Contacted a Manager
//        
//        0x20=Contacted a Manager, no more collisions
function contacted_a_manager() => byte(0x00007B)
function invulnerability_timer() => byte(0x000079)


band_members = [
 {"name": "Steve Smith",   "i": "drummer",       "title": "Separate Ways",    "points": 3, "id": 536154, "badge": "608513"},
 {"name": "Jonathan Cain", "i": "keyboardist",   "title": "Faithfully",       "points": 3, "id": 536155, "badge": "608514"},
 {"name": "Ross Valory",   "i": "bassist",       "title": "Wheel in the Sky", "points": 4, "id": 536156, "badge": "608515"},
 {"name": "Neal Schon",    "i": "lead guitar",   "title": "Stone in Love",    "points": 4, "id": 536157, "badge": "608516"},
 {"name": "Steve Perry",   "i": "lead vocalist", "title": "Open Arms",        "points": 4, "id": 536158, "badge": "608517"}, 
]

function single_player_mode()    { return byte(0x3a) == 0    }
function player_active()         { return byte(0x3b) == 1    }  
function reset_when_not_active() { return never(demo() == 0) }

function game_active()           { return demo() == 1 && single_player_mode()  }
// rescue each band member (done)
// beat a level with 30 seconds left on the clock
// meet the good manager
// meet the good manager on every level?
// meet a roadie
// get x number of roadies
// stay max speed for x seconds without being hit (and not invulnerable)
// get a score of 100,000 (done)


function score() {
  return bcd(byte(0x12)) + (bcd(byte(0x11)) * 100) + (bcd(byte(0x10)) * 10000)
}

function seconds() {
  return timer_seconds() + (timer_minutes() * 60)
}

function game_won() {
    return level() == 0x4 && byte(0x59) == 3 && prev(byte(0x59)) != 3
}

function reset_on_game_win() {
    return never(game_won())
}


// this doesn't work, shows up before game has started
function game_won_rp() {
    return (byte(0x13) == 0x4 && byte(0x59) == 3)
}

function game_cycle() { 
    return level() == 0 && timer_seconds() == 0 && timer_minutes() == 1 
}

function game_reset() {
    return level() == 0 && timer_seconds() == 0 && timer_minutes() == 1 && byte(0x10) == 0x5 && byte(0x11) == 0 && byte(0x12) == 0
}

function reset_on_game_reset()      { return never(game_reset()) }
function reset_if_level_decreases() { return never(level() < prev(level())) }

function roadie_touched()  { return player_active() && invulnerability_timer() == 0xf0 && prev(invulnerability_timer()) != 0xf0 }
function manager_touched() { return player_active() && contacted_a_manager() == 0x20 }

function object_collision() => byte(0x2e)

// this uses the music id, because if i don't use the music id i need to track
// player not invincible roadie
// player not invincible manager
// photographer active (not blinked off)
// music id 4 only happens during collisions, and if its set while the collison object points to photographer it means all these things are true
function paparazzi_touched() { 
    return player_active() && object_collision() != 0xff && byte(object_collision() + 0x000030) == 0 && music_id() == 4
}

achievement(
  title = "I Never Stopped Believin'",
  id = 536212,
  points = 25,
  description = "Get a score of at least 200000",
  trigger = game_active() && byte(0x10) >= 0x20 && prev(byte(0x10)) < 0x20
)

// Stuff for the Keep on Runnin cheevos
names = ["Steve Smith", "Jonathan Cain", "Ross Valory", "Neal Schon", "Steve Perry"]

running_seconds = 6
running_seconds_str = "six"
running_ids = [536204,536205,536206,536207,536208]
running_points = [3,4,4,5,5]
running_words = ["one","two","three","four","five"]

for i in range(0,4) {
  achievement(
    title = "Keep on Runnin', " + names[i],
    points = running_points[i],
    id = running_ids[i],
    description = "On level " + running_words[i] + ", without invulnerability, move forward continuously for " + running_seconds_str + " seconds without hitting anything",
    trigger = never(game_reset()) && reset_if_level_decreases() && never(invulnerability_timer() !=0) && never(manager_touched()) &&
            never(player_vertical_position() != 0x37) && never(level() != i) && game_active() &&
            trigger_when(repeated(running_seconds,once(timer_seconds() < prev(timer_seconds()))))
  )
}

// this function allows the beat 5 levels achievements to work on second cycle
function reset_pause() {
    return (level() == 0 && timer_seconds() == 0 && timer_minutes() == 1)
}

function beat_all_levels() { return repeated(4,level() > prev(level())) }

achievement(
  title = "I'll Be Alright Without You",
  points = 25,
  id = 536230,
  description = "Beat all five levels without engaging the services of a manager or roadie",
  trigger = disable_when(roadie_touched(), until=reset_pause()) &&
          disable_when(manager_touched(), until=reset_pause()) && never(game_reset()) && reset_if_level_decreases() &&
          game_active() && trigger_when(beat_all_levels() && game_won())
)

achievement(
  title = "No Pictures, Please",
  points = 10,
  id = 536231,
  description = "Beat all five levels without touching a photographer",
  trigger = disable_when(paparazzi_touched(), until=reset_pause()) &&  never(game_reset()) && reset_if_level_decreases() && game_active() &&
          trigger_when(beat_all_levels() && game_won())
)

achievement(
  title = "A Good Manager Is Hard to Find",
  points = 2,
  id = 536209,
  description = "Engage the services of the Mighty Manager",
  trigger = game_active() && manager_touched()
)

achievement(
  title = "Get a Grip",
  id = 536210,
  points = 1,
  description = "Engage the services of the Loyal Roadie",
  trigger = game_active() && roadie_touched()
)

achievement(
  title = "Chain Reaction",
  id = 536211,
  points = 4,
  description = "Engage the services of ten Loyal Roadies in one game cycle",
  trigger = reset_when_not_active() && never(game_reset()) && reset_if_level_decreases() && reset_on_game_win() && single_player_mode() && measured(repeated(10, roadie_touched()))
)


// as the level changes, the clock is immediately reset but it carrys over any remaining seconds.  
// so if the time is 1:10  you had at least 10 seconds left on the previous level
achievement(
  title = "Escape Artist I",
  id = 536202,
  points = 5,
  description = "Escape any level except the last level with at least ten seconds remaining",
  trigger = game_active() && level() > prev(level()) && timer_seconds() >= 10
)

achievement(
  title = "Escape Artist II",
  id = 536203,
  points = 10,
  description = "Escape any level except the last level with at least thirty seconds remaining",
  trigger = game_active() && level() > prev(level()) && timer_seconds() >= 30
)





function intermission() { return demo() == 1 && !player_active() }
function in_demo()      { return demo() == 0 }

function level_beat(m) {
  if m < 4 {
  achievement(
    title = band_members[m]["title"],
    id = band_members[m]["id"],
    badge = band_members[m]["badge"],
    points = band_members[m]["points"],
    type = "progression",
    description = "Avoid the crowd and escape with " + band_members[m]["name"],
    trigger = game_active() && level() == m+1 && prev(level()) == m
  )
  }
  else if m == 4 {
  achievement(
    title = band_members[m]["title"],
    id = band_members[m]["id"],
    badge = band_members[m]["badge"],
    points = band_members[m]["points"],
    type = "win_condition",
    description = "Avoid the crowd and escape with " + band_members[m]["name"],
    trigger = game_active() && game_won()
  )      
  }
}


for b in range(0,length(band_members)-1) {
    level_beat(b)
}

band_lookup = {
    0: "🥁 Steve Smith",
    1: "🎹 Jonathan Cain",
    2: "🍑🎸 Ross Valory",
    3: "🎸 Neal Schon",
    4: "🎤 Steve Perry"
}

rescued_lookup = {
    0: "None!",
    1: "🥁",
    2: "🥁,🎹",
    3: "🥁,🎹,🍑🎸",
    4: "🥁,🎹,🍑🎸,🎸",
}

function game_over() { return bit7(0x14) == 1 && prev(bit7(0x14)) == 0 }
function game_over_rp() { return bit7(0x14) == 1}

rich_presence_conditional_display(in_demo(), "Watching the demo loop")
rich_presence_conditional_display(level() == 0x5, "Watching the demo loop")

rich_presence_conditional_display(game_over_rp(), "Failed to Escape! • Escaped Bandmembers: {0} • Score: {1}",
  rich_presence_lookup("Rescued", level(), rescued_lookup), 
  rich_presence_macro("Score", score() )
)

rich_presence_conditional_display(game_won_rp(), "All Bandmembers Escaped! • 🥁,🎹,🍑🎸,🎸,🎤 • Score: {0}",
  rich_presence_macro("Score", score() )
)

rich_presence_conditional_display(intermission(), "Intermission • Next Up: {0} • Score: {1} • Extra time earned by {3} {4} • Escaped Bandmembers: {2}",
  rich_presence_lookup("BandMember", level(), band_lookup),
  rich_presence_macro("Score", score() ) ,
  rich_presence_lookup("Rescued", level(), rescued_lookup),
  rich_presence_lookup("BandMember", level()-1, band_lookup),
  rich_presence_value("Time", timer_seconds(), "secs")
)

rich_presence_conditional_display(game_active(), "Now Escaping: {0} • Time Remaining: {1} • Score: {2} • Escaped Bandmembers: {3}",
  rich_presence_lookup("BandMember", level(), band_lookup),
  rich_presence_macro("Seconds", seconds()),  
  rich_presence_macro("Score", score() ),
  rich_presence_lookup("Rescued", level(), rescued_lookup)
)

rich_presence_display("Oops, this should never be seen")

leaderboard(
    title = "Escapist - High Scorer",
    id = 136415,
    description = "Get as many points as you can, submits on game over",
    start  = game_active() && game_over(),
    cancel = game_reset(),
    submit = game_active() && game_over(),
    value  = score(),
    format = "VALUE"
)

leaderboard(
    title = "Certified Groupie - Most Completed Game Cycles",
    id = 136416,
    description = "Win as many times as you can in a row, starts after first win, submits on game over",
    start  = game_active() && game_won(),
    cancel = game_reset(),
    submit = game_active() && game_over(),
    value  = measured(tally(0,
                 (game_won()), 
                 always_false())
             ),
    format = "VALUE"
)
