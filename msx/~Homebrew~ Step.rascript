// ~Homebrew~ Step
// #ID = 34169


function addr_offset() => ~bit0(0x00FC48) * 0x00C000


// $0858: [10-bytes] Current Level Data
//function current_level_data() => byte(0x000858)

// $0864: [16-bit] LocationID1
//        
//        Chapter 1
//        0x97f6=Inside CryoPod
//        0x9803=Cryopod Room
//        0x9810=Hallway
//        0x9847=Mess Hall
//        0x9869=Science Bay
//        0x98a0=Using the Computer
function locationid1() => word(addr_offset() + 0x000864)

// $0866: [16-bit] LocationID2
//function locationid2() => word(0x000866)

// $096C: [8-bit][32-bytes] Progress Flag Array
//        
//        [Chapter 1]
//        0x1=Breakfast meeting
//function bytes_progress_flag_array() => byte(0x00096C)

// $096D: [8-bit] Progress flags
//        
//        [Chapter 1]
//        0x1=Assigned Hull breach task
//        0x2=Fixed Probe Bay
//        0x3=completed the quiz
//        0x4=probes ready for launch
//        0x5=mess hall, hearing the end of chap 1
//function progress_flags() => byte(0x00096D)

// $096F: 0x1=Analysis results from remote scan arrived
//function analysis_results_from_remote_scan_arrived() => byte(0x00096F)

// $0970: 0x3=taking the quiz
//        0x4=wrote the report
//function taking_the_quiz() => byte(0x000970)

// $0971: 0x1=hatch open
//        0x2=wires removed
//        0x3=screws unscrewed
//        0x5=pack inserted
//        0x6=screws screwed
//        0x7=wiring reconnected
//        0x8=close hatch (ready for launch)
//function hatch_open() => byte(0x000971)

// $0972: chapter 1
//        bit0=wearing spacesuit
//function chapter_1() => byte(0x000972)

// $0A82: [8-bit] Current Level/Area
//function current_level_area() => byte(0x000A82)

function chapter()       { return (byte(addr_offset() + 0x00A82)-1) }  
function chapter_is(num) { return chapter() == num  }

function chapter_select_screen_up() { return (byte(addr_offset() + 0x0c18) == 0x1b || byte(addr_offset() + 0x0c18) == 0x2b || byte(addr_offset() + 0x0c18) == 0x3b) }

// $0A83: [50-bytes] Key Game State Data
//function key_game_state_data() => byte(0x000A83)


// probably add the location id's 

function chapter_trigger(chapter,mem,loc,val,pval="None") {
    if pval != "None" {
            return chapter_is(chapter) && locationid1() == loc && mem == val && prev(mem) == pval
    } else {
            return chapter_is(chapter) && locationid1() == loc && mem == val && prev(mem) == val-1
    }
}




cheevs = [
// Chap 1
  // goes 1->2 while in the main hallway (lever)
{"title": "Vacuum Sealed", "description": "In chapter 1, seal the hull breach and repressurize the probe bay", 
  "points": 4, "type": "progression", "trigger": chapter_trigger(1,byte(addr_offset() + 0x096d),0x9810,2)},
  // goes 3->4 while on the last quiz question
{"title": "Planetary Profiler", "description": "In chapter 1, understand the scan results and write the correct report", 
  "points": 5, "type": "progression", "trigger": chapter_trigger(1,byte(addr_offset() + 0x0970),0x98e1,4)},
  // goes from 4->5 while in the mess hall
{"title": "Screwing with Probes", "description": "In chapter 1, install the dispersal probes and complete the chapter", 
  "points": 4, "type": "progression", "trigger": chapter_trigger(1,byte(addr_offset() + 0x096d),0x9847,5)},
  
// Chap 2
{"title": "Nine to Five", "description": "In chapter 2, get ready for work and go to the office", 
  "points": 4, "type": "progression", "trigger": chapter_trigger(2,byte(addr_offset() + 0x0971),0x98b6,0,3)},
{"title": "Rocky Road", "description": "In chapter 2, retrieve and analyze the rock samples", 
  "points": 3, "type": "progression", "trigger": chapter_trigger(2,byte(addr_offset() + 0x096d),0x98f7,2,0)},
{"title": "Antenna Antics", "description": "In chapter 2, activate the antenna and complete the chapter", 
  "points": 3, "type": "progression", "trigger": chapter_trigger(2,byte(addr_offset() + 0x0972),0x993d,1)},
  
// Chap 3
{"title": "Loader Batteries", "description": "In chapter 3, activate the loader and clear the base exit", 
  "points": 3, "type": "progression", "trigger": chapter_trigger(3,byte(addr_offset() + 0x096d),0xa26c,4,2)},
{"title": "Partial Comms", "description": "In chapter 3, partially repair the comms array and make it to the colony", 
  "points": 5, "type": "progression", "trigger": chapter_trigger(3,byte(addr_offset() + 0x0a83),0xa2b5,0x1f,0x15)},  
]

for c in cheevs {
    achievement(
        title = c["title"],
        description = c["description"],
        points = c["points"],
        type = c["type"],
        trigger = c["trigger"]
    )
}


c1_crew = [
// Alejandro talk
{"location": 0x985c, "params": [1,1,0x1d,0x37]},
// alejandro look
{"location": 0x985c, "params": [1,0,0x24,0x37]},

// Kim Look
{"location": 0x9847, "params": [3,0,0x2f,0x37]},
// Kim talk
{"location": 0x9847, "params": [3,1,0x27,0x37]},

// Sven look
{"location": 0x9847, "params": [4,0,0x2f,0x37]},
// Sven talk
{"location": 0x9847, "params": [4,1,0x2f,0x37]},    
]

c2_crew = [
//Dave Look
{"location": 0x98c3, "params": [0,1,0x20,0x37]},
//Dave talk crew
{"location": 0x98cc, "params": [1,0,0x4a,0x37]},
// Dave talk earth
{"location": 0x98cc, "params": [2,0,0x4a,0x37]},
// Dave talk mood
{"location": 0x98cc, "params": [3,0,0x4a,0x37]},
// Dave talk step
{"location": 0x98cc, "params": [4,0,0x4a,0x37]},

// Lana talk
{"location": 0x98d9, "params": [2,0,0x35,0x37]},
// Lana look
{"location": 0x98d9, "params": [2,1,0x2f,0x37]},
// Lana examine
{"location": 0x98d9, "params": [2,2,0x2f,0x37]},

// abe talk 
{"location": 0x98f7, "params": [1,0,0x4a,0x37]},
// abe look
{"location": 0x98f7, "params": [1,1,0x1d,0x37]},
// abe examine
{"location": 0x98f7, "params": [1,2,0x1d,0x37]},
]


c2_house = [
// dress for work
{"location": 0x987e, "params": [2,0,0x35,0x37]},
// breakfast
{"location": 0x987e, "params": [2,0,0x20,0x37]},
// forget phone

]

function object_trigger(o) {
    return      locationid1() == o["location"] &&
                byte(addr_offset() + 0x0a7f) == o["params"][0] && 
                byte(addr_offset() + 0x0a80) == o["params"][1] && 
                byte(addr_offset() + 0x0a83) == o["params"][2] && 
                prev(byte(addr_offset() + 0x0a83)) == o["params"][3]
}


crew_cheevo_constructor = [
    {"title": "Chapter 1 People Person", "description": "Fully interact with all the people in Chapter 1", "list": c1_crew, "points": 3, "pre": chapter_is(1)},
    {"title": "Chapter 2 People Person", "description": "Fully interact with all the people in Chapter 2", "list": c2_crew, "points": 3, "pre": chapter_is(2)}
]

function crew_cheevos(cheev) {
    achievement(
        title = cheev["title"],
        description = cheev["description"],
        points = cheev["points"],
        trigger = cheev["pre"] && measured(tally_of(
            cheev["list"], length(cheev["list"]),
            (p) => once(
                object_trigger(p)
            ) 
        )) && never(chapter_select_screen_up())
    )
}

for c in crew_cheevo_constructor {
    crew_cheevos(c)
}

achievement(
    title = "Man in the Mirror",
    description = "Look in the mirror",
    points = 1,
    trigger = chapter_is(2) && object_trigger({"location": 0x9897, "params": [1,0,0x30,0x37]})
)


achievement(
    title = "Silly Spacesuit",
    description = "Try to make some bad choices while wearing the spacesuit",
    points = 2,
    trigger = chapter_is(1) && 
        measured(tally(2,
            // try and wear the spacesuit going into the hallway
            once(object_trigger({"location": 0x9829, "params": [1,0,0x35,0x37]})),
            // try and take the spacesuit off in space
            once(
               (object_trigger({"location": 0x988f, "params": [3,0,0x2e,0x37]})) ||
               (object_trigger({"location": 0x9876, "params": [3,0,0x2e,0x37]}))
            )
        )) && never(chapter_select_screen_up())
    )


/*
achievement(
    title = "Speedy Solve I",
    description = "Complete chapter 1 with less than 25 scene transitions",
    points = 5,

    //trigger = chapter_is(1) && byte(0x0971) == 0x8 && prev(byte(0x971) == 0x7)
    trigger = chapter_trigger(1,byte(0x096d),8)
)
*/




LocationLookup = {
    // Chapter 1
    0x97f6: "inside the cryopod",
    0x9803: "in the cryobay",
    0x9810: "in the hallway",
    0x9847: "in the mess hall",
    0x985c: "in the storage room",
    0x9869: "in the science bay",
    0x98a0: "using the computer",
    0x9829: "in the airlock",
    0x9876: "on a spacewalk near the airlock",
    0x988f: "on a spacewalk near the probe bay",
    0x98c7: "writing a report on planetary conditions 1/4",
    0x98ba: "writing a report on planetary conditions 2/4",    
    0x98d4: "writing a report on planetary conditions 3/4",
    0x98e1: "writing a report on planetary conditions 4/4",
    0x983a: "in the probe bay",
    0x98ee: "installing the dispersal probes",
    
    // Chapter 2
    0x9864: "sitting in their seat in the ship",
    0x9871: "in the bedroom",
    0x987e: "in the living room",
    0x9897: "in the bathroom",
    0x98a4: "on the train to work",
    0x98ad: "sitting at the computer",
    0x98b6: "drafted into space, awaiting launch",
    0x98c3: "on The Halibut, approaching shore",
    0x98cc: "talking to Dave",
    0x98d9: "in the airlock",
    0x98f7: "in the science room",
    0x98ea: "at the barren shore of the ocean",
    0x9904: "looking at a map of the area",
    0x9916: "in the barren flats",
    0x990d: "on the hillside",
    0x991f: "on the hillside near a base ",
    0x9930: "inside the base on the hillside",
    0x993d: "on top of the hill that contains the base",
    
    // Chapter 3
    0xa21a: "in the cryopod",
    0xa227: "in the cryobay", 
    0xa26c: "in the main hall of the base",
    0xa292: "talking to Dave in the base",
    0xa285: "in the reactor room",
    0xa234: "in the computer room",
    0xa241: "using the computer",
    0xa24e: "on top of the hill near the base",
    0xa25b: "outside the base",
    0xa29f: "in the flooded plains",
    0xa2a8: "talking to Dave in the flooded plains",
    0xa2b5: "at the first human colony on Step",     
}


rich_presence_conditional_display(chapter_select_screen_up(), "Menu screen")

rich_presence_conditional_display( locationid1() != 0xffff, "Chapter {0} • The player is {1}",
    rich_presence_value("Number", chapter()),
    rich_presence_lookup("Location", locationid1(), LocationLookup, "exploring parts unknown")
)

rich_presence_display("Oh no, this should never be seen!")

