// Blazing Dragons
// #ID = 14430


function catapult_stack_ptr() => tbyte(0xe274)
function catapult_targets_hit() => catapult_stack_ptr() + 0x1ba

// $06338E: (8-bit ? ) Current Area
//          
//          Some Value:
//          0x05 = Thumb wrestling
//          0x09 =- Main hall.(Square Table)
//          0x10 = Kitchen
//          0x16 = Tournament Entrance (Sign)
//          0x17 = Arena
//          0x18 = Catapult Practice Range
//          0x31 = (Lady of the )Lake
function current_area() => word(0x06338E)

// $069694: (24-bit) Memory Card Load detection
//          
//          0x000000 = Loading
//          0x070950 = In Game
//          
//          Have not heavily tested, however if it's not 0x70950 the game freezes.    If this value changes, it !=0 is still a good indicator you're in game and not in Memory card loading state.
function memory_card_load() => tbyte(0x069694)

// $06CE8A: Dancing Mini-game: The button that needs to be pressed. Can be used to determine mini-game success.
// function dancing_minigame_success() => byte(0x06CE8A)

// $06F3A8: (16-bit) Item currently held.
//          
//          This is the item in your slots (switching between walking, looking, talking, touching, and this item with the bumpers)
//          
//          Look at 0x08e7ec for values, buit an example:
//          
//          0xc8 = Empty Jar
//          0x98 = Kiss in Jar.
function item_currently_held() => word(0x06F3A8)

// $070984: Cursor mode. 0=walk, 1=look, 2=?, 3=speak, 4=grab, 5=holding item
function cursor_mode() => byte(0x070984)
Walk=0
Look=1
Talk=3
Grab=4
Hold=5

// $0709D8: Object hovering cursor over
function object_hovering_cursor_over() => word(0x0709D8)

// $072890: Last object used any interaction on (look, grab, combine etc.)
function last_object_used() => word(0x072890)

// $0728B0: Last cursor mode used in interaction
function last_cursor_mode() => word(0x0728B0)

// $0728C0: Last object using held item on
function item_used_on() => word(0x0728C0)

// events enabled:  when true the game is running normally, when false the game is loading    used as save protection
function events_enabled() => bit0(0x8726c)

// $1A3C53: Flicker knighted. Bit 3: 1=knighted
//function flicker_knighted_bit_3() => bit3(0x1A3C53)

// $1A3C59: Found the kidnappers following the Dodo. Bit 6: 1=found
//function found_the_kidnappers_following_the_dodo_bit_6() => bit6(0x1A3C59)

// $1A3C5D: (bitfield) Lady of the Lake indicator
//          
//          bit6 = PLayer has Met the lady of the lake.
//          
//          Note this will soft lock the game if you try to see this scene a second time.
//function bitfield_lady_of_the_lake_indicator_player_has_met_the_lady_of_the_lake() => bit6(0x1A3C5D)

// $1A3C76: Possibly related to winning the thumb wrestling mini-game (?)
function possibly_related_to_winning_the_thumb_wrestling_mini_game() => byte(0x1A3C76)

// $1A52E6: (24-bit) Washing machine created and position
//          
//          0x64ff9c = Not created yet.
//          0x5000ed = Created and placed.
//          
//          0xed = X screen position
//          0x00 = Active (probably if it should be masked out )
//          0x50 = Y screen position
//function bit_washing_machine_created_and_position() => tbyte(0x1A52E6)

// $1A5A08: Librarian state: 00=away, 13=available
//function librarian_state() => byte(0x1A5A08)

// $1A5CFC: Pizza Chef Knocked down laughing. Bit 1: down=1
function pizza_chef_knocked_down_laughing_bit_1_down_1() => bit1(0x1A5CFC)

// $1A637E: Number of jokes heard from Trivet in the Arena
function number_of_jokes_heard_from_trivet_in_the_arena() => byte(0x1A637E)

// $1A6E84: Rabbit Minigame. Bit 0: 1=win
function rabbit_minigame_bit_0() => bit0(0x1A6E84)

// $1A7D18: Cricket Player state: 00=outside, 26=inside bar
function cricket_player_state() => byte(0x1A7D18)

// $1A9588: Ready to save the knights at the trap. value = 01 when you have all paddles and the knights are not saved. value = 00 when the knights are saved
function ready_to_save_the_knights_at_the_trap_value() => byte(0x1A9588)

// $1A9610: (8-bit) Sword in the Dryer status.
//          
//          0x00 = Lady hasn't thrown the sword, or player has taken the sword.
//          0x31=  Sword in Dryer.
//function bit_sword_in_the_dryer_status() => byte(0x1A9610)

// $1A9836: Counter for number of times talked to King All-Flame inside final boss
function king_all_flame_counter() => byte(0x1A9836)



// Everything after here are stack frames for sure


// $1FE93E: (8-bit) State of the thumb wrestling match.
//          
//          Control Value
//          
//          0x00 = Start.
//          0x01 = One taunt
//          0x02 = Second taunt
//          0x03 = "Fist in the face"
//          
//          Some Actions reset it (probably him pinning you)
function bit_state_of_the_thumb_wrestling_match() => byte(0x1FE93E)

// $1FEAD2: Catapult Range: Number of targets hit
function catapult_range_number_of_targets_hit() => byte(0x1FEAD2)

// $1FED82: Has to do with charging the catapult vs black dragon. goes from 3 to 8 on win
function catapult_vs_black_dragon() => byte(0x1FED82)

// End mem


// load the game flag pointer
function game_flags_addr() { 
    return tbyte(0x69714)
}

// determine the offset and bit for the flag bit index
function flag_bit(index) {
    ByteOffset = (index / 8)
    Remainder = index & 7
    return bit(Remainder,game_flags_addr() + ByteOffset)
}

function dishwasher_bit()         => flag_bit(10)
function kiss_caught_bit()        => flag_bit(15)
function catapult_win_bit()       => flag_bit(19)
function sir_burnevere_bit()      => flag_bit(28)
function sir_blaze_bit()          => flag_bit(30)
function sir_gasflame_bit()       => flag_bit(32)
function librarian_stumped_bit()  => flag_bit(54)
function pizza_guy_tickled_bit()  => flag_bit(61)
function dance_contest_won_bit()  => flag_bit(74)
function prunes_given_bit()       => flag_bit(82)
function stonehenge_rescued_bit() => flag_bit(105)
function thumb_war_win_bit()      => flag_bit(117)
function black_dragon2_win_bit()  => flag_bit(119)
function win_the_game_bit()       => flag_bit(124)
function trivet_hypnosis_bit()    => flag_bit(133)
function become_squire_bit()      => flag_bit(142)
function become_knight_bit()      => flag_bit(187)
function eye_hand_win_bit()       => flag_bit(204)
function sir_loungealot_bit()     => flag_bit(218)
function follow_dodo_bit()        => flag_bit(238)
function infiltrate_castle_bit()  => flag_bit(248)
function rescued_flame_jail_bit() => flag_bit(252)
function stonehenge_trap_bit()    => flag_bit(254)
function freed_lake_lady_bit()    => flag_bit(271)
function sword_from_dryer_bit()   => flag_bit(274)


/* this works to make a measured for game completion, could come in handy.  it was nice for notifying me when a bit flipped
flagaddr = 0x1a3c3c
completion_bitcounts = []
for i in range(0,14) {
    array_push(completion_bitcounts, bitcount(flagaddr + i))
}

completion_100 = length(completion_bitcounts) * 8

achievement(
    title = "test", description = "test",
    points = 0,
    trigger = sum_of(completion_bitcounts, (m) => prev(m)) < completion_100 &&
              measured(sum_of(completion_bitcounts, (m) => m) == completion_100, format="percent")
)
*/

achievement(
    title = "Go Over and Serve Those Guys!", points = 1, type="missable",
    description = "Serve the customers at Sir Juicealot's juice pub.",
    id = 154397, badge = "173394", 
    trigger = events_enabled() == 1 && current_area() == 0x26 && cricket_player_state() == 0x26 &&
              last_cursor_mode() == Grab &&
              (prev(last_object_used()) != 0x1eb && last_object_used() == 0x1eb) ||
              (prev(last_object_used()) != 0x1ef && last_object_used() == 0x1ef)
)


achievement(
    title = "Thanks for the Hospitality", points = 1, type="missable",
    description = "Get kicked out of the Chancellor's chambers.",
    id = 154385, badge = "173184",
    trigger = events_enabled() == 1 && prior(current_area()) == 11 && current_area() == 10 &&
              bit0(0x1A4754) == 1 && prev(last_object_used()) == 0x65 && last_object_used() == 0x52
)

achievement(
    title = "I Have All the Information I Need", points = 1,
    description = "Talk to the Info Lady. (If you're stuck, talk to her again and check your Invention Book!)",
    id = 154382, badge = "173213", 
    trigger = events_enabled() == 1 && current_area() == 0xa && last_cursor_mode() == Talk && prev(last_object_used() != 0x0053) && last_object_used() == 0x0053
)

achievement(
    title = "Master of the Cat-a-Pult Range", points = 25, type="missable",
    description = "Win the cat-a-pult range mini-game without missing a target.",
    id = 154386, badge = "173185", 
    trigger = events_enabled() == 1 && current_area() == 0x18 && prev(catapult_range_number_of_targets_hit()) == 10 &&
              catapult_range_number_of_targets_hit() == 11
)

achievement(
    title = "Haw! Haw! I kill me!", points = 1, type="missable",
    description = "Listen to all of Trivet's \"jokes\" at the tournament grounds.",
    id = 154387, badge = "173322", 
    trigger = events_enabled() == 1 && current_area() == 0x17 && prev(number_of_jokes_heard_from_trivet_in_the_arena()) == 2 &&
              measured(number_of_jokes_heard_from_trivet_in_the_arena() == 3)
)

achievement(
    title = "Okay, That's It!", points = 1, type="missable",
    description = "Make Sir Loungealot lose his patience during the thumb wrestling mini-game.",
    id = 154407, badge = "173373",
    trigger = events_enabled() == 1 && current_area() == 0x5 && prior(current_area()) == 0x17 &&
              prev(bit_state_of_the_thumb_wrestling_match()) < 3 && bit_state_of_the_thumb_wrestling_match() == 3
)

achievement(
    title = "A Bit of a Stupor", points = 1, type="missable",
    description = "Listen to all of King All-Fire's delusions aboard the Mecha Sir George.",
    id = 154410, badge = "173471",
    trigger = measured(tally_of(
                  range(1,4), 4, (n) => once(prev(king_all_flame_counter()) != n && king_all_flame_counter() == n)
              )) && never(current_area() != 0x32)
)

/*  old versions of the cheevos for posterity



achievement(
    title = "Lo and Behold!", points = 10, type="progression",
    description = "Find an inventive way to wash the dishes.",
    id = 154384, badge = "173187", 
    trigger = events_enabled() == 1 && current_area() == 0x10 && prev(dishwasher_bit()) == 0 && dishwasher_bit() == 1
)

achievement(
    title = "A Kiss for Good Luck", points = 1, type="progression",
    description = "Receive a good luck kiss from Princess Flame. The untamable kiss! (Or is it?)",
    id = 154383, badge = "173186",
    trigger = events_enabled() == 1 && current_area() == 0xf && prev(kiss_caught_bit()) == 0 && kiss_caught_bit() == 1
)

achievement(
    title = "Sir Gasflame", points = 5, type="progression",
    description = "Save Sir Gasflame.",
    id = 154389, badge = "173197", 
    trigger = events_enabled() == 1 && current_area() == 26 && prev(sir_gasflame_bit()) == 0 && sir_gasflame_bit() == 1
)


achievement(
    title = "Sir Blaze", points = 5, type="progression",
    description = "Save Sir Blaze.",
    id = 154390, badge = "173199", 
    trigger = events_enabled() == 1 && current_area() == 27 && prev(sir_blaze_bit()) == 0 && sir_blaze_bit() == 1
)


achievement(
    title = "Sir Burnevere", points = 5, type="progression",
    description = "Save Sir Burnevere.",
    id = 154388, badge = "173188", 
    trigger = events_enabled() == 1 && current_area() == 31 && prev(sir_burnevere_bit()) == 0 && sir_burnevere_bit() == 1
)

achievement(
    title = "Make Him a Princess!", points = 10, type="progression",
    description = "Show King All-Fire a Princess Flame.",
    id = 154393, badge = "173215", 
    trigger = events_enabled() == 1 && current_area() == 0xa && prev(trivet_hypnosis_bit()) == 0 && trivet_hypnosis_bit() == 1
)

achievement(
    title = "Sir Loungealot", points = 5, type="progression",
    description = "Save Sir Loungealot.",
    id = 154391, badge = "173201", 
    trigger = events_enabled() == 1 && current_area() == 33 && item_currently_held() == 50 && item_used_on() == 181 &&
              last_object_used() == 50
)

achievement(
    title = "Flicker the Squire", points = 10, type="progression",
    description = "Save all the knights and become a squire.",
    id = 154392, badge = "173222", 
    trigger = events_enabled() == 1 && current_area() == 32 && item_used_on() == 0 && object_hovering_cursor_over() == 176 &&
              item_currently_held() == 174
)

achievement(
    title = "But Can You Find This Book?", points = 1, type="progression",
    description = "Stump Librarian Pureflame.",
    id = 154574, badge = "173954", 
    trigger = events_enabled() == 1 && current_area() == 19 && prev(librarian_state()) == 19 && librarian_state() == 0
)

achievement(
    title = "Follow the Dodo", points = 10, type="progression",
    description = "Follow the dodo bird to the kidnappers.",
    id = 154394, badge = "173217", 
    trigger = current_area() == 39 && prev(found_the_kidnappers_following_the_dodo_bit_6()) == 0 &&
              found_the_kidnappers_following_the_dodo_bit_6() == 1
)

achievement(
    title = "It's a Trapezium!", points = 1, type="missable",
    description = "Learn about Sir George's sinister plans.",
    id = 154395, badge = "173319", 
    trigger = current_area() == 45 && prev(bit6(0x1A3C5B)) == 0 && bit6(0x1A3C5B) == 1
)

achievement(
    title = "The New Dance King", points = 25, type="progression",
    description = "Defeat the brute in the dance contest mini-game.",
    id = 154396, badge = "173232", 
    trigger = current_area() == 7 &&
              prev(dancing_minigame_success()) == 7 &&
              dancing_minigame_success() == 9
)

achievement(
    title = "Special Delivery", points = 5, type="progression",
    description = "Deliver a special gift to Sir George.",
    id = 154398, badge = "173233", 
    trigger = current_area() == 39 && item_currently_held() == 234 &&
              last_object_used() == 234 &&
              item_used_on() == 4
)

achievement(
    title = "Infiltrate Castle Grim", points = 5, type="progression",
    description = "Find a way inside Sir George's castle.",
    id = 154399, badge = "173278", 
    trigger = current_area() == 42 && prev(bit0(0x1A3C5B)) != 1 && bit0(0x1A3C5B) == 1
)

achievement(
    title = "Running Away is So Overrated", points = 5, type="progression",
    description = "Rescue Princess Flame.",
    id = 154400, badge = "173381",
    trigger = current_area() == 43 && item_currently_held() == 78 &&
              last_object_used() == 78 &&
              item_used_on() == 72
)
achievement(
    title = "Knightus You Becomus", points = 25, type="progression",
    description = "Become knighted by King All-Fire.",
    id = 154406, badge = "173439",
    trigger = current_area() == 23 && prev(flicker_knighted_bit_3()) == 0 && flicker_knighted_bit_3() == 1
)
achievement(
    title = "The Lady of the Lake", points = 5, type="progression",
    description = "Save the Lady of the Lake.",
    id = 154401, badge = "173234", 
    trigger = current_area() == 49 && item_currently_held() == 253 &&
              last_object_used() == 253 &&
              ((item_used_on() == 169) ||
               (item_used_on() == 168) ||
               (item_used_on() == 167))
)

achievement(
    title = "The Sword Insipid", points = 1, type="progression",
    description = "Lift the Sword Insipid and be crowned Master of All! (Or maybe not)",
    id = 154402, badge = "173430", 
    trigger = current_area() == 49 && bit_sword_in_the_dryer_status() == 0 &&
              prev(bit_sword_in_the_dryer_status()) == 49 &&
              bitfield_lady_of_the_lake_indicator_player_has_met_the_lady_of_the_lake() == 1 &&
              memory_card_load() == 461136
)

achievement(
    title = "I'ma Busy Laffin'", points = 1, type="progression",
    description = "Make the Pizza Chef laugh.",
    id = 154403, badge = "173276", 
    trigger = current_area() == 21 && prev(pizza_chef_knocked_down_laughing_bit_1_down_1()) == 0 &&
              pizza_chef_knocked_down_laughing_bit_1_down_1() == 1
)

achievement(
    title = "Centrifugal Force", points = 10, type="progression",
    description = "Find an inventive way to rescue the knights from Sir George's trap.",
    id = 154404, badge = "173330",
    trigger = current_area() == 45 && prev(ready_to_save_the_knights_at_the_trap_value()) == 1 &&
              ready_to_save_the_knights_at_the_trap_value() == 0
)

achievement(
    title = "Eye-Hand Coordination", points = 25, type="progression",
    description = "Win the rabbid rabbits mini-game at the Cave of Dilemma.",
    id = 154405, badge = "173356", 
    trigger = current_area() == 6 && prev(rabbit_minigame_bit_0()) == 0 && rabbit_minigame_bit_0() == 1
)

achievement(
    title = "The Most Cunning Thumbs in All of Camelhot", points = 10, type="progression",
    description = "Win the thumb wrestling mini-game and the tournament.",
    id = 154408, badge = "173443",
    trigger = prior(current_area()) == 5 && current_area() == 23 &&
              prev(possibly_related_to_winning_the_thumb_wrestling_mini_game()) == 0 &&
              possibly_related_to_winning_the_thumb_wrestling_mini_game() == 1
)

achievement(
    title = "Eureka! Die Evil Dragon!", points = 25, type="progression",
    description = "Find an inventive way to defeat the Black Dragon II.",
    id = 154409, badge = "173472", 
    trigger = current_area() == 24 &&
              prev(catapult_vs_black_dragon()) == 3 &&
              catapult_vs_black_dragon() == 8
)

achievement(
    title = "The Inferno Incarnate", points = 25, type="win_condition",
    description = "Destroy the Mecha Sir George and complete the game!",
    id = 154411, badge = "173459",
    trigger = current_area() == 50 && item_currently_held() == 129 &&
              last_object_used() == 129 &&
              item_used_on() == 173
)

achievement(
    title = "A Bit of a Stupor", points = 1, type="missable",
    description = "Listen to all of King All-Fire's delusions aboard the Mecha Sir George.",
    id = 154410, badge = "173471",
    trigger = current_area() == 50 &&
              prev(king_all_flame_counter()) == 3 &&
              king_all_flame_counter() == 4
)


*/
/*
use_obj_cheevos = [
//    { "title": "Sir Gasflame", "description": "Save Sir Gasflame.", "id": 154389, "badge": "173197", "type": "progression", "points": 5, "area": 0x1a, "item": 0x182, "used_on": [0x142,0x145] },
//    { "title": "Sir Blaze", "description": "Save Sir Blaze.", "id": 154390, "badge": "173199", "type": "progression", "points": 5, "area": 0x1b, "item": 0x19c, "used_on": [0x14c,0x14d] }

]

for c in use_obj_cheevos {
    achievement(
        title = c["title"], points = c["points"], type = c["type"],
        description = c["description"], id = c["id"], badge = c["badge"],
        trigger = events_enabled() == 1 && current_area() == c["area"] && item_currently_held() == c["item"] && last_object_used() == c["item"] &&
                  any_of(range(0,length(c["used_on"])-1), (i) => prev(item_used_on() != c["used_on"][i]) && item_used_on() == c["used_on"][i])

    )
}
*/


function event_trigger(action,bit) {
    if action == "set" {
        return prev(bit) == 0 && bit == 1
    } else if action == "clear" {
        return prev(bit) == 1 && bit == 0
    } else {
        assert(false,message="Unknown Event Trigger " + action)
    }
}

event_cheevos = [
    { "title": "Sir Gasflame", "description": "Save Sir Gasflame.", "id": 154389, "badge": "173197", "type": "progression", "points": 5, 
      "area": 0x1a, "event_trigger": event_trigger("set",sir_gasflame_bit()) },
    { "title": "Sir Blaze",    "description": "Save Sir Blaze.",    "id": 154390, "badge": "173199", "type": "progression", "points": 5, 
      "area": 0x1b, "event_trigger": event_trigger("set",sir_blaze_bit()) },
    { "title": "Sir Burnevere", "description": "Save Sir Burnevere.", "id": 154388, "badge": "173188", "type": "progression", "points": 5, 
      "area": 0x1f, "event_trigger": event_trigger("set", sir_burnevere_bit()) },
    { "title": "Make Him a Princess!", "description": "Show King All-Fire a Princess Flame.", "id": 154393, "badge": "173215", "type": "progression", "points": 10, 
      "area": 0x9, "event_trigger": event_trigger("set", trivet_hypnosis_bit()) },
    { "title": "Lo and Behold!", "description": "Find an inventive way to wash the dishes.", "id": 154384, "badge": "173187", "type": "progression", "points": 10, 
      "area": 0x10, "event_trigger": event_trigger("set", dishwasher_bit()) },
    { "title": "A Kiss for Good Luck", "description": "Receive a good luck kiss from Princess Flame. The untamable kiss! (Or is it?)", "id": 154383, "badge": "173186", "type": "progression", "points": 1, 
      "area": 0xf, "event_trigger": event_trigger("set", kiss_caught_bit()) }, 
    { "title": "Sir Loungealot", "description": "Save Sir Loungealot.", "id": 154391, "badge": "173201", "type": "progression", "points": 5, 
      "area": 0x21, "event_trigger": event_trigger("set", sir_loungealot_bit()) },
    { "title": "Flicker the Squire", "description": "Save all the knights and become a squire.", "id": 154392, "badge": "173222", "type": "progression", "points": 10, 
      "area": 0x20, "event_trigger": event_trigger("set", become_squire_bit()) },
    { "title": "But Can You Find This Book?", "description": "Stump Librarian Pureflame.", "id": 154574, "badge": "173954", "type": "progression", "points": 1,
      "area": 0x13, "event_trigger": event_trigger("set", librarian_stumped_bit()) },
    { "title": "Follow the Dodo", "description": "Follow the dodo bird to the kidnappers.", "id": 154394, "badge": "173217", "type": "progression", "points": 10, 
      "area": 0x27, "event_trigger": event_trigger("set", follow_dodo_bit()) },
    { "title": "It's a Trapezium!", "description": "Learn about Sir George's sinister plans.", "id": 154395, "badge": "173319", "type": "missable", "points": 1, 
      "area": 0x2d, "event_trigger": event_trigger("set", stonehenge_trap_bit()) },
    { "title": "The New Dance King", "description": "Defeat the brute in the dance contest mini-game.", "id": 154396, "badge": "173232", "type": "progression", "points": 25, 
      "area": 0x7, "event_trigger": event_trigger("set", dance_contest_won_bit())},
    { "title": "Special Delivery", "description": "Deliver a special gift to Sir George.", "id": 154398, "badge": "173233", "type": "progression", "points": 5, 
      "area": 0x27, "event_trigger": event_trigger("set", prunes_given_bit()) },
    { "title": "Infiltrate Castle Grim", "description": "Find a way inside Sir George's castle.", "id": 154399, "badge": "173278", "type": "progression", "points": 5, 
      "area": 0x2a, "event_trigger": event_trigger("set", infiltrate_castle_bit()) },
    { "title": "Running Away is So Overrated", "description": "Rescue Princess Flame.", "id": 154400, "badge": "173381", "type": "progression", "points": 5, 
      "area": 0x2b, "event_trigger": event_trigger("set", rescued_flame_jail_bit()) },
    { "title": "The Lady of the Lake", "description": "Save the Lady of the Lake.", "id": 154401, "badge": "173234", "type": "progression", "points": 5, 
      "area": 0x31, "event_trigger": event_trigger("set", freed_lake_lady_bit()) },
    { "title": "The Sword Insipid", "description": "Lift the Sword Insipid and be crowned Master of All! (Or maybe not)", "id": 154402, "badge": "173430", 
      "type": "progression", "points": 1, "area": 0x31, "event_trigger": event_trigger("set", sword_from_dryer_bit()) },
    { "title": "I'ma Busy Laffin'", "description": "Make the Pizza Chef laugh.", "id": 154403, "badge": "173276", "type": "progression", "points": 1, 
      "area": 0x15, "event_trigger": event_trigger("set", pizza_guy_tickled_bit())},
    { "title": "Centrifugal Force", "description": "Find an inventive way to rescue the knights from Sir George's trap.", "id": 154404, "badge": "173330", 
      "type": "progression", "points": 10, "area": 0x2d, "event_trigger": event_trigger("set", stonehenge_rescued_bit()) },
    { "title": "Eye-Hand Coordination", "description": "Win the rabbid rabbits mini-game at the Cave of Dilemma.", "id": 154405, "badge": "173356", 
      "type": "progression", "points": 25, "area": 0x6, "event_trigger": event_trigger("set", eye_hand_win_bit()) },
    { "title": "Knightus You Becomus", "description": "Become knighted by King All-Fire.", "id": 154406, "badge": "173439", "type": "progression", "points": 25, 
      "area": 0x17, "event_trigger": event_trigger("set", become_knight_bit()) },
    { "title": "The Most Cunning Thumbs in All of Camelhot", "description": "Win the thumb wrestling mini-game and the tournament.", "id": 154408, 
      "badge": "173443", "type": "progression", "points": 10, "area": 0x17, "event_trigger": event_trigger("set", thumb_war_win_bit()) },
    { "title": "Eureka! Die Evil Dragon!", "description": "Find an inventive way to defeat the Black Dragon II.", "id": 154409, "badge": "173472", 
      "type": "progression", "points": 25, "area": 0x18, "event_trigger": event_trigger("set", black_dragon2_win_bit()) },
    { "title": "The Inferno Incarnate", "description": "Destroy the Mecha Sir George and complete the game!", "id": 154411, "badge": "173459", 
      "type": "win_condition", "points": 25, "area": 0x35, "event_trigger": event_trigger("set", win_the_game_bit()) }                 
]


for c in event_cheevos {
    achievement(
        title = c["title"], points = c["points"], type = c["type"],
        description = c["description"], id = c["id"], badge = c["badge"],
        trigger = events_enabled() == 1 && current_area() == c["area"] && c["event_trigger"]
    )
}

AreaLookup = {
    0x02: "looking at his invention book",
    0x04: "looking at the map",
    0x05: "thumb-wrestling in a tournament",
    0x06: "doing the test of eye-hand coordination",
    0x07: "in a dance contest",
    0x09: "in the castle main hall",
    0x0a: "in the castle entry",
    0x0b: "in the chancellor's quarters",
    0x0c: "attending a meeting in the main hall",
    0x0d: "in the royal hall",
    0x0e: "in the king's chambers",
    0x0f: "in Flame's room",
    0x10: "in the kitchen",
    0x11: "in the upstairs hallway",
    0x12: "in his room",
    0x13: "in the library",
    0x14: "is looking at an endangered species chart",
    0x15: "in downtown Camelhot",
    0x16: "at the tournament entrance",
    0x17: "at the tournament grounds",
    0x18: "at the Cat-a-Pult",
    0x19: "being knighted by King All-Fire",
    0x1a: "at the back of the castle",
    0x1b: "at the tranquil pool",
    0x1c: "at the waterfall",
    0x1d: "in the Cave of Dilemmas",    
    0x1e: "outside the home for the Grimly Insane",
    0x1f: "inside the home for the Grimly Insane",
    0x20: "at the bottom of the hill",
    0x21: "at the top of the hill",
    0x23: "in the woods",
    0x24: "listening to an ant",
    0x25: "in downtown Grim",
    0x26: "in the juice pub",
    0x27: "at the entrance to Castle Grim",
    0x28: "in the Castle Grim courtyard",
    0x29: "in the Castle Grim bathroom",
    0x2a: "in the Castle Grim courtyard",
    0x2b: "in Mervin's lab",
    0x2d: "at Stonehenge",
    0x2e: "under Stonehenge",
    0x30: "in the mine",
    0x31: "at the lake",
    0x32: "in the bowels of the Black Dragon",
    0x33: "watching Sir Mecha George fly",
    0x34: "looking at the tournament bracket",
    0x35: "watching Sir Mecha George crash",
    0x36: "watching Mervin and George in a tree",
    0x37: "watching the end credits",
    0xff: "at the title screen"
}

rich_presence_display("Flicker is {0}",
    rich_presence_lookup("Area", current_area(), AreaLookup, fallback="ready for adventure")
)