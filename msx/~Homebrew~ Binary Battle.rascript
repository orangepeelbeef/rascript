// #MinimumVersion = 1.3
// ~Homebrew~ Binary Battle
// #ID = 33865

function addr_offset() => ~bit0(0x00FC48) * 0x00C000

function level_minor()    { return byte(addr_offset() + 0x000315)      }
function level_major()    { return byte(addr_offset() + 0x000316)      }
function health()         { return bcd(byte(addr_offset() + 0x000317)) }
function heat()           { return bcd(byte(addr_offset() + 0x000318)) }
function attack()         { return bcd(byte(addr_offset() + 0x000319)) }
function current_coins()  { return bcd(word(addr_offset() + 0x00031A)) }
function keys()           { return bcd(byte(addr_offset() + 0x00031C)) }
function health_max()     { return bcd(byte(addr_offset() + 0x00031E)) }
function heat_max()       { return bcd(byte(addr_offset() + 0x00031F)) }
function enemies_killed() { return bcd(word(addr_offset() + 0x00032d)) }
function damage_dealt()   { return bcd(word(addr_offset() + 0x00032f)) }
function damage_taken()   { return bcd(word(addr_offset() + 0x000331)) }
function total_coins()    { return bcd(word(addr_offset() + 0x000333)) }
function game_state()     { return byte(addr_offset() + 0x000337)      }    

function b_antivirus()    { return byte(addr_offset() + 0x000343)      }
function b_firststrike()  { return byte(addr_offset() + 0x000344)      }
function b_vampiric()     { return byte(addr_offset() + 0x000345)      }
function b_endothermic()  { return byte(addr_offset() + 0x000346)      }
function b_defrag()       { return byte(addr_offset() + 0x000347)      }
function b_deepclean()    { return byte(addr_offset() + 0x000348)      }

function correct_path()   { return dword(addr_offset() + 0x0033b) == dword(addr_offset() + 0x0033f) }

function net_damage() { 
  return damage_dealt() - damage_taken() 
}

function score() {
    return total_coins() + net_damage() + (level_major() * 400)
}

function player_playing() {
  return game_state() == 1
}

function player_lost_rp() {
  return game_state() == 3
}

function player_won_rp() {
  return game_state() == 2
}

function player_lost() {
  return game_state() == 3 && prev(game_state() == 1)
}

function player_won() {
  return game_state() == 2 && prev(game_state() == 1)
}

value_cheevos = [
  {"title": "Maximum Health", "stat": "a health max",           "points": 10,  "mem": byte(addr_offset() + 0x00031E), "value": 0x99, "valuestr": "99"},
  {"title": "Maximum Heat",   "stat": "a heat max",             "points": 10,  "mem": byte(addr_offset() + 0x00031F), "value": 0x99, "valuestr": "99"},
  {"title": "Attack Expert",  "stat": "an attack",              "points": 10,  "mem": byte(addr_offset() + 0x000319), "value": 0x30, "valuestr": "30"},
  {"title": "Keymaster",      "stat": "an encryption keys",     "points": 5,   "mem": byte(addr_offset() + 0x00031c), "value": 0x10, "valuestr": "10"},
]

function value_cheev(item) {
   achievement(
    title = item["title"],
    points = item["points"],
    description = "Have " + item["stat"] + " value of " + item["valuestr"],
    trigger = (item["mem"] == item["value"] && prev(item["mem"]) != item["value"])
   )
}

for c in value_cheevos {
  value_cheev(c)
}


buff_cheevos = [
  {"title": "Antivirus Upgrade", "desc": "Acquire the antivirus upgrade buff",                               "points": 2, "mem": b_antivirus()},
  {"title": "First Strike",      "desc": "Acquire the buff that damages enemies when entering directories",  "points": 2, "mem": b_firststrike()},
  {"title": "Vampiric",          "desc": "Acquire the buff that adds disk health on virus death",            "points": 2, "mem": b_vampiric()},
  {"title": "Endothermic",       "desc": "Acquire the buff that reduces drive heat on virus death",          "points": 2, "mem": b_endothermic()},
  {"title": "Defrag",            "desc": "Acquire the buff that adds disk health when entering directories", "points": 2, "mem": b_defrag()},
  {"title": "Deep Clean",        "desc": "Acquire the buff that provides extra healing from cotton swabs",   "points": 2, "mem": b_deepclean()}
]

function buff_cheev(item) {
    achievement(
    title = item["title"],
    points = item["points"],
    description = item["desc"],
    trigger = player_playing() && (item["mem"] > 0 && prev(item["mem"]) == 0)
   )
}

for c in buff_cheevos {
    buff_cheev(c)
}

achievement(
  title = "Decrypted", 
  points = 2,
  description = "Unlock an encrypted file",
  trigger = player_playing() && (prev(keys()) > keys())
)

achievement(
  title = "Alcohol", 
  points = 2,
  description = "Get an alcohol upgrade",
  trigger = player_playing() && prev(health_max()) < health_max()
)

achievement(
  title = "Cooling Fan", 
  points = 2,
  description = "Get a disk heat upgrade",
  trigger = player_playing() && prev(heat_max()) < heat_max()
)

function all_buffs_num(num) {
    return b_antivirus() == num && b_firststrike() == num && b_vampiric() == num && 
           b_endothermic() == num && b_defrag() == num && b_deepclean() == num
}

// buff rank level for hack of all trades, in case 5 is too hard
buffs_rank = 5

achievement(
  title = "Hack of All Trades",
  points = 10,
  description = "Get all six buff types to rank " + buffs_rank + " in a single run",
  trigger = (player_playing() && all_buffs_num(buffs_rank)) &&
           ((prev(b_antivirus()) < buffs_rank) || (prev(b_firststrike()) < buffs_rank) ||
           (prev(b_vampiric()) < buffs_rank) || (prev(b_endothermic()) < buffs_rank) ||
           (prev(b_defrag()) < buffs_rank) || (prev(b_deepclean()) < buffs_rank))
)

achievement(
  title = "Frag",
  points = 5,
  description = "Eliminate 100 viruses in a single run",
  trigger = player_playing() && enemies_killed() >= 100 && prev(enemies_killed()) < 100
)

roman_numerals = ["I", "II", "III", "IV"]

for i in range(1,4) {
  achievement(
    title = "Folder Fighter " + roman_numerals[i-1],
    type = "progression",
    points = 3,
    description = "Find the correct path, and exit level " + i,
    trigger = player_playing() && correct_path() && prev(level_major()) == i && level_major() == i+1
  )
}

achievement(
  title = "Folders Fought", 
  type="win_condition",
  points = 10,
  description = "Find the source code and beat the game",
  trigger = player_won() && correct_path()
)

achievement(
  title = "Efficiency Expert",
  points = 10,
  description = "Beat the game with a score of 5000 or more",
  trigger = game_state() >= 1 && (score() > 5000) && trigger_when(player_won() && correct_path())
)

achievement(
  title = "Bitcoins Aren't Real Money",
  points = 25,
  description = "Beat the game without picking up any bitcoins",
  trigger = game_state() >= 1 && total_coins() == 0 && trigger_when(player_won() && correct_path())
)


// Rich Presence

rich_presence_conditional_display(game_state() == 0, "Looking at the menu screen")

rich_presence_conditional_display(player_lost_rp(), "Disk Damaged Beyond Repair • Level {0} • Killed: {1} • Dmg Dealt: {2} • Dmg Taken: {3} • Bitcoins {4} • Score {5}",
    rich_presence_value("Number", level_major()),
    rich_presence_value("Number", enemies_killed()),
    rich_presence_value("Number", damage_dealt()),
    rich_presence_value("Number", damage_taken()),
    rich_presence_value("Number", total_coins()), 
    rich_presence_value("Number", score())
)

rich_presence_conditional_display(player_won_rp(), "Source Code Recovered • Level {0} • Killed: {1} • Dmg Dealt: {2} • Dmg Taken: {3} • Bitcoins {4} • Score {5}",
    rich_presence_value("Number", level_major()),
    rich_presence_value("Number", enemies_killed()),
    rich_presence_value("Number", damage_dealt()),
    rich_presence_value("Number", damage_taken()),
    rich_presence_value("Number", total_coins()), 
    rich_presence_value("Number", score())
)

rich_presence_conditional_display(player_playing() && current_coins() < total_coins(), "Level {0}-{1} • Attack: {2} • Health: {3}/{4} • Heat: {5}/{6} • Keys: {7} • Bitcoins: {8} | {9} • Score: {10}",
    rich_presence_value("Number", level_major()),
    rich_presence_value("Number", level_minor()),
    rich_presence_value("Number", attack()),
    rich_presence_value("Number", health()),
    rich_presence_value("Number", health_max()),
    rich_presence_value("Number", heat()),
    rich_presence_value("Number", heat_max()),
    rich_presence_value("Number", keys()),
    rich_presence_value("Number", current_coins()), 
    rich_presence_value("Number", total_coins()), 
    rich_presence_value("Number", score())
)

rich_presence_conditional_display(player_playing(), "Level {0}-{1} • Attack: {2} • Health: {3}/{4} • Heat: {5}/{6} • Keys: {7} • Bitcoins: {8} • Score: {9}",
    rich_presence_value("Number", level_major()),
    rich_presence_value("Number", level_minor()),
    rich_presence_value("Number", attack()),
    rich_presence_value("Number", health()),
    rich_presence_value("Number", health_max()),
    rich_presence_value("Number", heat()),
    rich_presence_value("Number", heat_max()),
    rich_presence_value("Number", keys()),
    rich_presence_value("Number", current_coins()), 
    rich_presence_value("Number", score())
)

rich_presence_display("Oops, this should never be seen")


// leaderboard  virus kills
leaderboard(
    title="Virus Eliminator",
    description="Kill as many viruses as you can in a single run",
    start=game_state() > 1 && prev(game_state() == 1),
    submit=game_state() > 1 && prev(game_state() == 1),
    cancel=always_false(),
    value=measured(enemies_killed()),
    format="Value",
    lower_is_better=false
)

// leaderboard  bitcoins collected
leaderboard(
    title="Bitcoin Billionaire",
    description="Get as many bitcoin as you can in a single run",
    start=game_state() > 1 && prev(game_state() == 1),
    submit=game_state() > 1 && prev(game_state() == 1),
    cancel=always_false(),
    value=measured(total_coins()),
    format="Value",
    lower_is_better=false
)

// leaderboard  score
leaderboard(
    title="High Score",
    description="Get the highest score possible in a single run",
    start=game_state() > 1 && prev(game_state() == 1),
    submit=game_state() > 1 && prev(game_state() == 1),
    cancel=always_false(),
    value=measured(score()),
    format="Value",
    lower_is_better=false
)
