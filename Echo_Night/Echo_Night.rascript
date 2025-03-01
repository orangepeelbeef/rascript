// #MinimumVersion = 1.3
// Echo Night
// #ID = 6130

// set up a ptr helper function
function ptr(addr) => dword(addr) & 0x1FFFFFFF

// $09F1C2: [16-bit] config slot index
function configSlotIndex() => word(0x09F1C2)

// $09FA8c: [32-bit PTR] CurrentConfigSlotPTR
function currentConfigSlotAddr()    => dword(0x09FA8C)
function currentConfigSlot()        => ptr(0x09FA8c)
function currentInteractionID()     => dword(currentConfigSlot())
function currentInteractionIDByte() => byte(currentConfigSlot())
function currentDataPTR()           => dword(currentConfigSlot() + 4)
function currentDataValue()         => dword(ptr(currentConfigSlot() + 4))
function currentDataValue2()        => dword(ptr(currentConfigSlot() + 8))
function currentFunctionID()        => dword(currentConfigSlot() + 0x10)


// $09F7F0: [32-bit] GameContinuedState
//          
//          0x01=Started a New Game from the menu
//          0x02=Continued a Game from the menu
function GameContinuedState() => dword(0x09F7F0)


function GameRunning() {
    return GameContinuedState() > 0 && saveAndLoadStatus() == 0
}

function GameContinued() {
   return (GameContinuedState == 2 && prev(GameContinuedState()) != 2)
}

// $09F890 [32-bit] GameResetLoop

// Once the gameover screen has come up, the game starts the intro loop again but doesn't re-blank any memory
// 0= Playing regularly no reset 
// 2= Game over has happened
// all other values= Black screen, reset the current location
function gameResetLoop() => dword(0x09F890)


// $09F8D8: [32-bit] Game Over
//          
//          0x1=Game Over screen is up
function gameOver() => dword(0x09F8D8)
function GameOver() {
    return (gameOver() == 1)
}

// $09F8F0: [32-bit] End game Countdown Timer
//          
//          starts at 5f
//          
//          if this is ffffffff  bad ending?
function endGameCountdownTimer() => dword(0x09F8F0)

// $09F8F8: [32-bit] Game State
//          
//          x00=game not ready
//          x02=menu or in a puzzle
//          x03=playing
function gameState() => dword(0x09F8F8)

// $09F908: [32-bit] LocationID
//          
//          0x00=Upr Deck - Pilothouse
//          0x01=Upr Deck - Passageway Outside
//          0x02=Upr Deck - Chart Room
//          0x03=Upr Deck - Captain's Cabin
//          0x04=Upr Deck - Compartment
//          0x05=Floor 1 - Reading Room
//          0x06=Floor 1 - Lounge
//          0x07=Floor 1 - Electrical Room
//          0x08=Floor 1 - Grand Dining Room
//          0x09=Upr Deck - Passageway Inside
//          0x0a=Floor 1 - Engineer Hallway
//          0x0b=Floor 1 - Passenger Hallway
//          0x0c=Floor 1 - Guest Hallway
//          0x0d=Floor 1 - Dining Room Hallway
//          0x0e=Floor 2 - Child Room
//          0x0f=Floor 1 - Guest Room A
//          0x10=Floor 1 - Guest Room B
//          0x11=Floor 1 - Guest Room C
//          0x12=Floor 1 - Guest Room D
//          0x13=Floor 1 - Special Guest Room
//          0x14=The Past - Pier
//          0x15=Floor 2 - Medical Office
//          0x16=The Past - Castle
//          0x17=The Past - Castle Terrace
//          0x18=The Past - Laboratory
//          0x19=Floor 2 - Theater
//          0x1a=Floor 2 - Mess Room
//          0x1b=Floor 1 - Stairway
//          0x1c=Floor 2 - Engineer's Room
//          0x1d=Lwr Deck - Pool
//          0x1e=Floor 1 - Dining Room Galley
//          0x1f=Floor 2 - Casino
//          0x20=Floor 2 - Radio Room
//          0x21=The Past - Steam Locomotive
//          0x22=Floor 2 - Shower Room
//          0x23=Floor 2 - Bathroom
//          0x24=Floor 2 - Port Corridor
//          0x25=Floor 2 - Starboard Corridor
//          0x26=Floor 2 - Engine Corridor
//          0x27=Lwr Deck - Deck Terrace
//          0x28=Floor 1 - Private Quarters
//          0x29=The Past - Cathedral
//          0x2a=Floor 2 - Theater Hallway
//          0x2b=The Past - Cemetery Graveyard
//          0x2c=Lwr Deck - Terrace Lazarette
//          0x2d=Floor 2 - Crew's Corridor
//          0x2e=Lwr Deck - Stern Passageway
//          0x2f=Floor 1 - Water Room
//          0x30=Floor 1 - Forest Room
//          0x31=Floor 1 - Sky Room
//          0x32=Floor 1 - Fire Room
//          0x33=Floor 1 - Owner's Quarters
//          0x34=Floor 2 - Crew's Quarters B
//          0x35=Floor 2 - Crew's Quarters A
//          0x36=The Past - Library
//          0x37=Father's House
//          0x38=Living Room
//          0x39=Basement
//          0x3a=The Past - Abandoned Mine A
//          0x3b=The Past - Abandoned Mine B
//          0x3c=the Past - Abandoned Mine C
//          0x3d=The Past - Observatory A
//          0x3e=The Past - Observatory B
//          0x3f=The Past - Cemetery Crypt A
//          0x40=The Past - Cemetery Crypt B
//          0x41=Floor 3 - Engine Room B
//          0x42=Floor 3 - Engine Room A
//          0x43=Floor 3 - Stern Passageway
//          0x44=Floor 3 - Boiler A
//          0x45=Floor 3 - Boiler B
//          0x46=Floor 3 - Fuel Storage
//          0x47=The Past - Cathedral Basement
//          0x48=Floor 3 - Compartment B
//          0x49=The Past - Cathedral Stairway
//          0x4a=Floor 3 - Compartment A
//          0x4b=The Past - Amusement Park Fountain
//          0x4c=The Past - Amusement Park Carousel
//          0x4d=The Past - King's Quarters
//          0x4e=Lwr Deck - Corridor to Pool
//          0x4f=The Past - House
//          0x50=The Past - Valley
//          0x51=a Cutscene: Flyby The Orpheus
//          0x52=a Cutscene: Flyby The House
//          0x53=a Cutscene: Going into the Cathedral
//          0x54=a Cutscene: Train heading into tunnel
//          0x55=a Cutscene: Boarding the Train
//          0x56=a Cutscene: Driving to the House
//          0x57=a Cutscene: Watching the Good Ending
//          0x58=a Cutscene: Flyby The Library
//          0x59=a Cutscene: Going into the Abandoned Mine
//          0x5a=a Cutscene: Flyby The Castle
//          0x5b=a Cutscene: Flyby The Observatory
//          0x5c=????
//          0x5d=The Past - House(Outside)




function locationid() => dword(0x09F908)

LocationLookup = {
    0x00: "Exploring Upr Deck - Pilothouse",
    0x01: "Exploring Upr Deck - Passageway Outside",
    0x02: "Exploring Upr Deck - Chart Room",
    0x03: "Exploring Upr Deck - Captain's Cabin",
    0x04: "Exploring Upr Deck - Compartment",
    0x05: "Exploring Floor 1 - Reading Room",
    0x06: "Exploring Floor 1 - Lounge",
    0x07: "Exploring Floor 1 - Electrical Room",
    0x08: "Exploring Floor 1 - Grand Dining Room",
    0x09: "Exploring Upr Deck - Passageway Inside",
    0x0a: "Exploring Floor 1 - Engineer Hallway",
    0x0b: "Exploring Floor 1 - Passenger Hallway",
    0x0c: "Exploring Floor 1 - Guest Hallway",
    0x0d: "Exploring Floor 1 - Dining Room Hallway",
    0x0e: "Exploring Floor 2 - Child Room",
    0x0f: "Exploring Floor 1 - Guest Room A",
    0x10: "Exploring Floor 1 - Guest Room B",
    0x11: "Exploring Floor 1 - Guest Room C",
    0x12: "Exploring Floor 1 - Guest Room D",
    0x13: "Exploring Floor 1 - Special Guest Room",
    0x14: "Exploring The Past - Pier",
    0x15: "Exploring Floor 2 - Medical Office",
    0x16: "Exploring The Past - Castle",
    0x17: "Exploring The Past - Castle Terrace",
    0x18: "Exploring The Past - Laboratory",
    0x19: "Exploring Floor 2 - Theater",
    0x1a: "Exploring Floor 2 - Mess Room",
    0x1b: "Exploring Floor 1 - Stairway",
    0x1c: "Exploring Floor 2 - Engineer's Room",
    0x1d: "Exploring Lwr Deck - Pool",
    0x1e: "Exploring Floor 1 - Dining Room Galley",
    0x1f: "Exploring Floor 2 - Casino",
    0x20: "Exploring Floor 2 - Radio Room",
    0x21: "Exploring The Past - Steam Locomotive",
    0x22: "Exploring Floor 2 - Shower Room",
    0x23: "Exploring Floor 2 - Bathroom",
    0x24: "Exploring Floor 2 - Port Corridor",
    0x25: "Exploring Floor 2 - Starboard Corridor",
    0x26: "Exploring Floor 2 - Engine Corridor",
    0x27: "Exploring Lwr Deck - Deck Terrace",
    0x28: "Exploring Floor 1 - Private Quarters",
    0x29: "Exploring The Past - Cathedral",
    0x2a: "Exploring Floor 2 - Theater Hallway",
    0x2b: "Exploring The Past - Cemetery Graveyard",
    0x2c: "Exploring Lwr Deck - Terrace Lazarette",
    0x2d: "Exploring Floor 2 - Crew's Corridor",
    0x2e: "Exploring Lwr Deck - Stern Passageway",
    0x2f: "Exploring Floor 1 - Water Room",
    0x30: "Exploring Floor 1 - Forest Room",
    0x31: "Exploring Floor 1 - Sky Room",
    0x32: "Exploring Floor 1 - Fire Room",
    0x33: "Exploring Floor 1 - Owner's Quarters",
    0x34: "Exploring Floor 2 - Crew's Quarters B",
    0x35: "Exploring Floor 2 - Crew's Quarters A",
    0x36: "Exploring The Past - Library",
    0x37: "Exploring Father's House",
    0x38: "Exploring Living Room",
    0x39: "Exploring Basement",
    0x3a: "Exploring The Past - Abandoned Mine A",
    0x3b: "Exploring The Past - Abandoned Mine B",
    0x3c: "Exploring the Past - Abandoned Mine C",
    0x3d: "Exploring The Past - Observatory A",
    0x3e: "Exploring The Past - Observatory B",
    0x3f: "Exploring The Past - Cemetery Crypt A",
    0x40: "Exploring The Past - Cemetery Crypt B",
    0x41: "Exploring Floor 3 - Engine Room B",
    0x42: "Exploring Floor 3 - Engine Room A",
    0x43: "Exploring Floor 3 - Stern Passageway",
    0x44: "Exploring Floor 3 - Boiler A",
    0x45: "Exploring Floor 3 - Boiler B",
    0x46: "Exploring Floor 3 - Fuel Storage",
    0x47: "Exploring The Past - Cathedral Basement",
    0x48: "Exploring Floor 3 - Compartment B",
    0x49: "Exploring The Past - Cathedral Stairway",
    0x4a: "Exploring Floor 3 - Compartment A",
    0x4b: "Exploring The Past - Amusement Park Fountain",
    0x4c: "Exploring The Past - Amusement Park Carousel",
    0x4d: "Exploring The Past - King's Quarters",
    0x4e: "Exploring Lwr Deck - Corridor to Pool",
    0x4f: "Exploring The Past - House",
    0x50: "📽️: Flyby of The Castle",
    0x51: "📽️: Flyby of The Orpheus",
    0x52: "📽️: Flyby of The House",
    0x53: "📽️: Going into the Cathedral",
    0x54: "📽️: Train heading into tunnel",
    0x55: "📽️: Boarding the train at East Anchor Station",
    0x56: "📽️: Escorted to the House",
    0x57: "📽️: Watching the Good Ending",
    0x58: "📽️: Flyby of The Library",
    0x59: "📽️: Going into the Abandoned Mine",
    0x5a: "📽️: Flyby of The Laboratory",
    0x5b: "📽️: Flyby of The Observatory",
    0x5c: "Unused",
    0x5d: "Exploring The Past - House(Outside)",
}


// Location constants for semantic use
Pilothouse              = 0
UprDeckPassageway       = 1
ChartRoom               = 2
CaptainsCabin           = 3
UprDeckCompartment      = 4
ReadingRoom             = 5
Lounge                  = 6
ElectricalRoom          = 7
GrandDining             = 8
UprDeckPassagewayInside = 9
EngineerHallway         = 0xa
PassengerHallway        = 0xb
GuestHallway            = 0xc
DiningHallway           = 0xd
ChildRoom               = 0xe
GuestRoomA              = 0xf
GuestRoomB              = 0x10
GuestRoomC              = 0x11
GuestRoomD              = 0x12
SpecialGuestRoom        = 0x13
Pier                    = 0x14
MedicalOffice           = 0x15
Castle                  = 0x16
CastleTerrace           = 0x17
Laboratory              = 0x18
Theater                 = 0x19
MessRoom                = 0x1a
Stairway                = 0x1b
EngineersRoom           = 0x1c
Pool                    = 0x1d
DiningRoomGalley        = 0x1e
Casino                  = 0x1f
RadioRoom               = 0x20
SteamLocomotive         = 0x21
ShowerRoom              = 0x22
Bathroom                = 0x23
PortCorridor            = 0x24
StarboardCorridor       = 0x25
EngineCorridor          = 0x26
LwrDeckTerrace          = 0x27
PrivateQuarters         = 0x28
Cathedral               = 0x29
TheaterHallway          = 0x2a
CemeteryGraveyard       = 0x2b
TerraceLazarette        = 0x2c
CrewsCorridor           = 0x2d
LwrDeckSternPassageway  = 0x2e
WaterRoom               = 0x2f
ForestRoom              = 0x30
SkyRoom                 = 0x31
FireRoom                = 0x32
OwnersQuarters          = 0x33
CrewsQuartersB          = 0x34
CrewsQuartersA          = 0x35
Library                 = 0x36
House                   = 0x37
LivingRoom              = 0x38
Basement                = 0x39
AbandonedMineA          = 0x3a
AbandonedMineB          = 0x3b
AbandonedMineC          = 0x3c
ObservatoryA            = 0x3d
ObservatoryB            = 0x3e
CemeteryCryptA          = 0x3f
CemeteryCryptB          = 0x40
EngineRoomB             = 0x41
EngineRoomA             = 0x42
Floor3SternPassageway   = 0x43
BoilerA                 = 0x44
BoilerB                 = 0x45
FuelStorage             = 0x46
CathedralBasement       = 0x47
CompartmentB            = 0x48
CathedralStairway       = 0x49
CompartmentA            = 0x4a
AmusementParkFountain   = 0x4b
AmusementParkCarousel   = 0x4c
KingsQuarters           = 0x4d
CorridorToPool          = 0x4e
PastHouse               = 0x4f
BoardingTrainCutscene   = 0x55
EscortedToHouseCutscene = 0x56
PastHouseOutside        = 0x5d

// $09FB10: [32-bit] Player Puzzle Status
//          
//          0x01=Player is Not in a Puzzle
//          0x00=Player is in a  puzzle   (or the game hasn't been started yet, must rely on
function playerPuzzleStatus() => dword(0x09FB10)

// $09FB24: [32-bit] FileName Pointer for CD Rom Video Playing
//          
//          0x80086224=EDEC000.STR CZ3 Division
//          0x80086250=EDEC001.STR Intro Trailer
//          0x8008627c=EDEC002.STR Menu Background
//          0x800862a8=EDEC003.STR Strange Film
//          0x800862d4=EDEC004.STR Orpheus Rising into the Light
//          0x80086300=EDEC005.STR Best Ending
//          0x8008632c=EDEC006.STR Agetec Logo
function filenamePointerForCdRomVideoPlaying() => dword(0x09FB24)

VideoFileLookup = {
    0x800862a8: "📽️: Watching a Strange Film",
    0x80086300: "📽️: Watching the Best Ending",
    0x800862d4: "📽️: Watching the Orpheus Rise into the Light",
    0x80086250: "📽️: Watching the Game Trailer",
    0x8008627c: ": Looking at the Menu Screen",
    0x80086224: "📽️: CZ3 Division Logo",
    0x8008632c: "📽️: Agetec & Fromsoft Logo",
}

// $0A0C6E: [8-bit] Astral Pieces Turned In
//
// number of astral pieces turned in to medium
// 0-26
function astralPiecesTurnedIn() => byte(0x0A0C6E)


// $0A0CB0: [32-bit] casino game chips
function casinoGameChips() => dword(0x0A0CB0)

// $1A3DB4: [32-bit] playerStanding
//          
//          0x0=crouched
//          0x1=standing
//          
//          manipulation of this value just resets to the value it was before

function playerstanding() => dword(0x1A3DB4)

// 0x1a4248
// [800 bytes] LocationEntityStatus
// light switches and other location flags

// 200 * 4

// This is an array of structs indexed by location
// [
//  bool, bool, bool, bool, 
//  bool, bool, bool, bool
// ]
// the 4 odd indexes of the array are set true on entering the location

// +0x00=pilothouse
// +0x08=passageway   etc
// +0x1c8=Basement
// - - bool0=ceiling lightswitch
LocationEntityflagsAddr = 0x1A4248
function locationEntityflagBit(location, index) => bit0(LocationEntityflagsAddr + index + (location * 8))

BasementLightSwitchOn          = locationEntityflagBit(Basement,0)
UprDeckPassagewayInsideLightOn = locationEntityflagBit(UprDeckPassagewayInside,0)
UprDeckCompartmentLightOn      = locationEntityflagBit(UprDeckCompartment,0)
PilothouseLightOn              = locationEntityflagBit(Pilothouse,0)

LocationSpawnflagsAddr = 0x1A4A68

function locationSpawnflags(location, index) => LocationSpawnflagsAddr + index + (location * 2)
// index should be either 0 or 1 as this is a 16-bit area
function currentLocationSpawnflags(index) => locationSpawnflags(locationid(), index)

// $1A4A68: [16-bit] LocationSpawnArray[00] upr deck pilothouse spawns
//          
//          static config array
//          
//          0x32 * 4
//          
//          ends at 1a4b30
//          
//          array of 2 bytes of bitflags controlling the spawn of items in a location
//          toggling a bit that is off back to on spawns a new copy of the item
//          
//          bit0=metal handle
//          bit1=?
//          bit2=ship map
//          bit3=cure potion in cabinet
//          bit4=cure potion in cabinet 2
//          bit5=
//          bit6=
//          bit7=

function IsSpawnedUprDeckPilothouseCurePotionInCabinet()  => bit3(locationSpawnflags(Pilothouse,0))
function IsSpawnedUprDeckPilothouseCurePotionInCabinet2() => bit4(locationSpawnflags(Pilothouse,0))

// $1A4A6A: [2bytes] LocationSpawnArray[01] upr deck passageway outside spawns

// bit0=Greg Capstan (captain) astral piece
// bit1=John Cutter astral piece

function IsSpawnedJohnCutterAstral() => bit1(locationSpawnflags(UprDeckPassageway,0))

// [2bytes] LocationSpawnArray[02] Chart Room spawns

// bit0=Billy Bollard Astral Piece 
// bit1=Iron Key

function IsSpawnedBillyBollardAstral() => bit0(locationSpawnflags(ChartRoom,0))

// $1A4A6E: [16-bit] LocationSpawnArray[03] captain's cabin spawns
//          
//          bit0=wire (after its cut off)
//          bit1=cure potion in drawer
//          bit2=leather organizer
//          bit3=comet book
function IsSpawnedCaptainsCabinCurePotionInDrawer() => bit1(locationSpawnflags(CaptainsCabin,0))

// $1A4A70: [2bytes] LocationSpawnArray[04] upr deck compartment

// bit0=wire cutters

function IsSpawnedWireCutter() => bit0(locationSpawnflags(UprDeckCompartment,0))

// $1A4A72: [2bytes] LocationSpawnArray[05] floor 1 reading room

// bit0=Sailor Medal A is in a flag statue
// bit1=Sailor Medal B is in a flag statue
// bit2=Sailor Medal C is in a flag statue
// bit3=Sailor Medal D is in a flag statue
// bit4=Sailor Medal A (duct)
// bit5=Brass Key
// bit6=Ed Mooring Astral piece
// bit7=
function IsSpawnedEdMooringAstral() => bit6(locationSpawnflags(ReadingRoom,0))


// $1A4A74: [16-bit] LocationSpawnArray[06] floor 1 lounge
//          
//          bit0=claim ticket (far left under bar)
function IsSpawnedFloor1LoungeClaimTicketFarLeftUnderBar() => bit0(locationSpawnflags(Lounge,0))

// $1A4A78: [16-bit] LocationSpawnArray[08] floor 1 grand dining
//          
//          bit0=fire bird plate (after talking to ghost couple)
//          bit1=claim ticket (on table opposite the kitchen door)
function IsSpawnedFloor1GrandDiningClaimTicketOnTableOppositeTheKitchenDoor() => bit1(locationSpawnflags(GrandDining,0))

// $1a4a80 [2 bytes] LocationSpawnArray[0c] floor 1 guest hallway

// bit0=glass
// bit1=Sailor medal B
// bit2=Robb Derick astral piece
function IsSpawnedRobbAstral() => bit2(locationSpawnflags(GuestHallway,0))


// $1a4a82 [2 bytes] LocationSpawnArray[0d] dining room hallway
//          bit1=Peter Schooner astral piece
function IsSpawnedStewardAstral() => bit1(locationSpawnflags(DiningHallway,0))

// $1A4A8A: [16-bit] LocationSpawnArray[11] guest room C spawns
//          
//          0| Sailor Medal C
//          1| Cure Potion (drawer)
//          2| Fiana Parcelling astral piece
function IsSpawnedGuestRoomCCuringPotionInDrawer() => bit1(locationSpawnflags(GuestRoomC,0))
function IsSpawnedFianaAstral()                    => bit2(locationSpawnflags(GuestRoomC,0))


// $1A4A8C: [16-bit] LocationSpawnArray[12] guest room D spawns
//          
//          0| Sailor Medal D
//          1| Cure Potion (drawer)
//          2| Diana Parcelling astral piece
function IsSpawnedGuestRoomDCuringPotionInDrawer() => bit1(locationSpawnflags(GuestRoomD,0))
function IsSpawnedDianaAstral()                    => bit2(locationSpawnflags(GuestRoomD,0))

// $1A4A8E: [16-bit] LocationSpawnArray[13] Floor 1 Special Guest Room
//          
//          0| Dress Suit
//          1| Claim Ticket (bathroom floor)
function IsSpawnedSpecialGuestRoomClaimTicketBathroomFloor() => bit1(locationSpawnflags(SpecialGuestRoom,0))
function IsSpawnedClaudiasDoll()                             => bit2(locationSpawnflags(SpecialGuestRoom,0))

// $1A4A92: [16-bit] LocationSpawnArray[15] Floor 2 Medical Office
//          
//          bit0=curing potion (drawer)
//          bit1=curing potion (cabinet)
//          bit2=antidote (locked in cabinet drawer)
function IsSpawnedFloor2MedicalOfficeCuringPotionDrawer()  => bit0(locationSpawnflags(MedicalOffice,0))
function IsSpawnedFloor2MedicalOfficeCuringPotionCabinet() => bit1(locationSpawnflags(MedicalOffice,0))

// $1A4A98: [16-bit] LocationSpawnArray[18] Laboratory
// bit0= prescription in drawer
function IsSpawnedPrescription() => bit0(locationSpawnflags(Laboratory,0))

// $1A4A9A: [16-bit] LocationSpawnArray[19] Floor 2 Theater
//          
//          bit0=Record (film booth)
//          bit1=Scott Garboard astral piece
//          bit2=Thomas Gusset astral piece
//          bit3=
//          bit4=claim ticket (on purple sofa in main theater)
//          bit5=Cabinet Key
function IsSpawnedFloor2TheaterClaimTicketOnSofaInMainTheater() => bit4(locationSpawnflags(Theater,0))
function IsSpawnedThomasGussetAstral()                          => bit2(locationSpawnflags(Theater,0))



// $1A4AA0: [16-bit] LocationSpawnArray[1c] Floor 2 Engineer's Room
//          bit1=curing potion in back room chest

function IsSpawnedFloor2EngineersRoomCuringPotionInBackRoomChest() => bit1(locationSpawnflags(EngineersRoom,0))

// $1A4AA2: [16-bit] LocationSpawnArray[1d] Lwr Deck Pool
//          
//          +0x0 bitflags1
//          - - 1| claim ticket (in locker starboard side lockerroom)
//          - - 2| curing potion (far left locker in the port side lockerroom)
function IsSpawnedLwrDeckPoolClaimTicketInStarboardLocker() => bit1(locationSpawnflags(Pool,0))
function IsSpawnedLwrDeckPoolRoomCuringPotionInPortLocker() => bit2(locationSpawnflags(Pool,0))

// $1A4AA6: [2bytes] LocationSpawnArray[1f] Floor 2 Casino
//          
//          +0x0 bitflags1
//          - - 0| Claim ticket (on the ground by the roulette table)
//          - - 1| Elizabeth Crownest Blackjack Dealer Astral piece
//          - - 2| Poly Owning Casino Manager Astral piece
//          - - 3| Tom Rudder Roulette Dealer Astral piece
function IsSpawnedFloor2CasinoClaimTicketFloorByRouletteTable() => bit0(locationSpawnflags(Casino,0))

// $1A4AAC: [16-bit] LocationSpawnArray[22] Floor 2 - Shower Room
//          
//          +0x0 bitflags1
//          - - 0| Curing potion  (middle locker)
function IsSpawnedFloor2ShowerRoomCuringPotionInLocker() => bit0(locationSpawnflags(ShowerRoom,0))

// $1A4AAE: [16-bit] LocationSpawnArray[23] Floor 2 Bathroom
//          
//          +0x0 bitflags
//          - - 0| Claim ticket (last toilet stall)
function IsSpawnedFloor2BathroomClaimTicketInLastStall() => bit0(locationSpawnflags(Bathroom,0))

// $1A4AC0 [2bytes] LocationSpawnArray[2c] Lwr Deck Terrace Lazarette
//
//bit0=Emllie Scuttle astral piece
//bit1=Pendant being given to ghost
function IsSpawnedEmllieScuttleAstral() => bit0(locationSpawnflags(TerraceLazarette,0))

// $1A4AC6: [16-bit] LocationSpawnArray[2f] Floor 1 Water Room
//          
//          bit0=clock key (on table main room)
//          bit1=curing potion (ground in bedroom)
function IsSpawnedFloor1WaterRoomCuringPotionGroundInBedroom() => bit1(locationSpawnflags(WaterRoom,0))

// 2a Theater Hallway
function PouringAntidote() => bit0(locationSpawnflags(TheaterHallway,0))


// $1A4ACC: [16-bit] LocationSpawnArray[32] Floor 1 Fire Room
//          
//          bit0=Jack Rockwell astral piece
//          bit1=claim ticket (on large bed)
function IsSpawnedFloor1FireRoomClaimTicketOnLargeBed() => bit1(locationSpawnflags(FireRoom,0))


function IsSpawnedSailorsDocument()        => bit0(locationSpawnflags(CrewsQuartersB,0))


function IsSpawnedOscarRockwellAstral()    => bit2(locationSpawnflags(RadioRoom,0))

// $1A4AE0: [16-bit] LocationSpawnArray[3c] The Past Abandoned Mine C
// bit0=Claudia's Doll
function IsSpawnedClaudiasDoll() => bit0(locationSpawnflags(AbandonedMineC,0))

function FlyingFishPlateInLastSlot() => bit0(locationSpawnflags(CemeteryCryptA,0))

// $1A4AF0: [16-bit] LocationSpawnArray[44] Boiler A
//          
//          bit0=piston key
//          bit1=curing potion (floor at bottom of stairs)
function IsSpawnedBoilerACuringPotionFloorAtBottomOfStairs() => bit1(locationSpawnflags(BoilerA,0))

// $1A4B00: [16-bit] LocationSpawnArray[4c] Amusement Park Carousel
//
//          bit0=engagement ring
function IsSpawnedAmusementParkEngagementRing() => bit0(locationSpawnflags(AmusementParkCarousel,0))


// $1A6B30: [32-bit] GameTime
//          
//          This value is number of seconds from the timestamp 11/17/1937 0:00
//          
//          [1024 bytes]
//          The following 1024 bytes are saved and loaded from memory cards
function gametime() => dword(0x1A6B30)

// $1A6B48: [32-bit] Total Time
//          
//          Before the game starts it will count up slightly as the logo videos and demos play, so this is not a predictable way to detect game start
//          
//          Once game has started this ticks up once every second unless the game is paused.
function totalTime() => dword(0x1A6B48)

// $1A6B4C: [32-bit] Pedometer
//          
//          Number of steps taken in the game
function pedometer() => dword(0x1A6B4C)

// $1A6B50: [16-bit] Player Condition
//          
//          0x00=Dead
//          0x01=Danger
//          0x02=Wounded
//          0x03=Normal
//          0x04=Good
//          0x05=Best
function playerCondition() => byte(0x1A6B50)

function TakenDamage() {
    return playerCondition() < prev(playerCondition())
}

PlayerConditionLookup = {
    0x00: "☠️",
    0x01: "⚠️",
    0x02: "🤕",
    0x03: "😑",
    0x04: "🙂",
    0x05: "😊",
}
function playerCondition() => word(0x1A6B50)

// $1A6B55: [8-bit] Weather
//          
//          0x00 = Sunny
//          0x01 = Cloudy
//          0x02 = Raining
//          0x03 = Snowing
function weather() => byte(0x1A6B55)

WeatherLookup = {
    0x00: "☀️",
    0x01: "⛅",
    0x02: "☔",
    0x03: "❄️",
}

// $1A6B56: [8-bit] Ship Map
//          
//          0x0=not obtained
//          0x1=obtained
function shipMap() => byte(0x1A6B56)

// $1A6B57: [8-bit] Leather Organizer
//          
//          0x0=not obtained
//          0x01=Obtained
function leatherOrganizer() => byte(0x1A6B57)


MapCompletionAddr = 0x1A6C78

function mapCompletionArrayByte(index) => MapCompletionAddr + index

function locationMapBit(location)
{
    if location == 0 {
        return visitedUprDeckPilothouse()
    } else {
        MapByteOffset = (location / 8)
        MapRemainder = location & 7
        return bit(MapRemainder,mapCompletionArrayByte(MapByteOffset))
    }
}


// $1A6C78: [bitflags] map completion array[0]
//          
//          0| game started/ upr deck pilothouse
//          1| upr deck passageway outside
//          2| upr deck chart room
//          3| upr deck captain's cabin
//          4| upr deck compartment
//          5| floor 1 reading room
//          6| floor 1 lounge
//          7| floor 1 electrical room

//function mapCompletionArray0Bitcount() => bitcount(mapCompletionArrayByte(0))

//The Pilothouse map bit is set at the beginning of the game
// so instead we check if the entities that get populated are on
// when you walk into the area locationEntityflagBit(Pilothouse,[1,3,5,7]) get flipped on
// turning these bits off doesn't seem to do anything, and when you come back into the room they will be on again
// locationEntityflagBit(Pilothouse,0) is on if the lights are on in the pilothouse

function visitedUprDeckPilothouse()    =>  locationEntityflagBit(Pilothouse,1)


// $1A6C79: [bitflags] map completion array[1]
//          
//          0| floor 1 grand dining room
//          1| upr deck passageway inside
//          2| floor 1 engineer hallway
//          3| floor 1 passenger hallway
//          4| floor 1 guest hallway
//          5| floor 1 dining room hallway
//          6| floor 2 child room
//          7| floor 1 guest room A
//function mapCompletionArray1Bitcount() => bitcount(mapCompletionArrayByte(1))

// $1A6C7A: [bitflags] map completion array[2]
//          
//          0| floor 1 guest room B
//          1| floor 1 guest room C
//          2| floor 1 guest room D
//          3| floor 1 special guest room
//          4| the past pier
//          5| floor 2 medical office
//          6| the past castle
//          7| the past castle terrace
//function mapCompletionArray2Bitcount() => bitcount(mapCompletionArrayByte(2))

// $1A6C7B: [bitflags] map completion array[3]
//          
//          0| the past laboratory
//          1| floor 2 theater
//          2| floor 2 mess room
//          3| floor 1 stairway
//          4| floor 2 engineers room
//          5| lwr deck pool
//          6| floor 1 dining room galley
//          7| floor 2 casino
//function mapCompletionArray3Bitcount() => bitcount(mapCompletionArrayByte(3))

// $1A6C7C: [bitflags] map completion array[4]
//          
//          0| floor 2 radio room
//          1| steam locomotive
//          2| floor 2 shower room
//          3| floor 2 bathroom
//          4| floor 2 port corridor
//          5| floor 2 starboard corridor
//          6| floor 2 engine corridor
//          7| lwr deck - deck terrace
//function mapCompletionArray4Bitcount() => bitcount(mapCompletionArrayByte(4))

// $1A6C7D: [bitflags] map completion array[5]
//          
//          0| floor 1 private quarters
//          1| the past cathedral
//          2| floor 2 theater hallway
//          3| the past cemetery a
//          4| lwr deck terrace lazarette
//          5| floor 2 crewman's quarters
//          6| lwr deck stern passageway
//          7| floor 1 water room
//function mapCompletionArray5Bitcount() => bitcount(mapCompletionArrayByte(5))

// $1A6C7E: [bitflags] map completion array[6]
//          
//          0| floor 1 forest room
//          1| floor 1 sky room
//          2| floor 1 fire room
//          3| floor 1 owners quarters
//          4| floor 2 crews quarters B
//          5| floor 2 crews quarters A
//          6| the past library
//          7| father's house
//function mapCompletionArray6Bitcount() => bitcount(mapCompletionArrayByte(6))

// $1A6C7F: [bitflags] map completion array[7]
//          
//          0| living room
//          1| basement
//          2| the past abandoned mine A
//          3| the past abandoned mine B
//          4| the past abandoned mine C
//          5| the past - observatory A
//          6| the past - observatory B
//          7| the past cemetery B
//function mapCompletionArray7Bitcount() => bitcount(mapCompletionArrayByte(7))

// $1A6C80: [bitflags] map completion array[8]
//          
//          0| the past cemetery C
//          1| floor 3 engine room B
//          2| floor 3 engine room A
//          3| floor 3 stern passageway
//          4| floor 3 boiler A
//          5| floor 3 boiler B
//          6| floor 3 fuel storage
//          7| the past cathedral basement
//function mapCompletionArray8Bitcount() => bitcount(mapCompletionArrayByte(8))

// $1A6C81: [bitflags] map completion array[9]
//          
//          0| floor 3 compartment b
//          1| the past cathedral stairway
//          2| floor 3 compartment a  (can't get in until the game ending)
//          3| the past amusement park fountain
//          4| the past amusement park merry go round
//          5| the past kings quarters
//          6| lwr deck corridor to pool
//          7| the past valley
//function mapCompletionArray9Bitcount() => bitcount(mapCompletionArrayByte(9))

// $1A6C8C: [32-bit] Secrets Rating part1
//          RatingArray[0]
//          
//          ((this address + 01a6c9c) * 100 ) / NonZeroCount of elements starting at 80083d10
//          
//          Starts at 0x64
function secretsRatingPart1() => dword(0x1A6C8C)

// $1A6C90: [32-bit] Intelligence Rating
//          RatingArray[1]
//          
//          Inteliigence = this value / 7 on the results screen
//          Starts at 0x02bc
//          Maxes at 0x0578
function intelligenceRating() => dword(0x1A6C90)

// $1A6C94: [32-bit] Physical Rating
//          RatingArray[2]
//          
//          Physical = this value * 200 / NonZeroCount of elements starting at 80083d10
//          Starts at 0x64
function physicalRating() => dword(0x1A6C94)

// $1A6C98: [32-bit] RatingArray[3]
//          
//          Starts at 0x64
function ratingarray3() => dword(0x1A6C98)

// $1A6C9C: [32-bit] Secrets Rating part2
//          RatingArray[4]
//          
//          see 01a6c90
//          
//          Starts at 0x64
function secretsRatingPart2() => dword(0x1A6C9C)

// $1A6CB4: [32-bit] Possessed
//          
//          any value not 0 is a counter that counts down to 0 every tick indicated possession
//          
//          0x0=Not Possessed
//          0xbc=Possessed by ghost in Corridor to Pool, counts down to 0x00  (lasts 188 ticks)
function possessed() => dword(0x1A6CB4)


// $1AC0D0: [2048 bytes][Array] PeopleNotesData

// each entry is 16 bytes long, with the last byte being the Notebook note level
// order is the PersonData
// +0xf PersonNoteData

PersonNotesAddr = 0x1AC0DC
function personNoteByte(index,offset) => byte(PersonNotesAddr + offset + (index * 16))
function personNoteBit(index,offset,notebit) {
    return bit(notebit, PersonNotesAddr + offset + (index * 16))
}

// $1BCBC8: [128 bytes][Array] PeopleMetArray
// static config all initialized to ff, loaded with savegame
// As you meet people and talk to them their 8-bit ID is recorded in the next non-ff containing slot
// See 1ad710 for ID's

PeopleMetAddr = 0x1BCBC8


LocationBitflagsAddr = 0x1BCE58
function locationBitflags(location, index) => LocationBitflagsAddr + index + (location * 0x20)
function currentLocationBitflags(index) => locationBitflags(locationid(), index)

//Semantic names for later use related to locationbitflags
function ClockWound()                => bit3(locationBitflags(House,0))
function FuseBoxWired()              => bit0(locationBitflags(UprDeckCompartment,0))
function playerInTheaterEntrance()   => bit2(locationBitflags(Theater,0))
function playerInTheater()           => bit3(locationBitflags(Theater,0))
function playerInTheaterBackRoom()   => bit4(locationBitflags(Theater,0)) 
function playerInFilmBooth()         => bit5(locationBitflags(Theater,0))
function filmEngineerGone()          => bit6(locationBitflags(Theater,0))
function CasinoClosed()              => bit1(locationBitflags(Casino,0))
function BasementPuzzleSolved()      => bit0(locationBitflags(Basement,0))
function SteamLocomotiveComplete()   => bit0(locationBitflags(SteamLocomotive,1))
function PierComplete()              => bit0(locationBitflags(Pier,0))
function EncounteredClaudia()        => bit3(locationBitflags(UprDeckPassageway,0))
function VisitedMedium()             => bit0(locationBitflags(ObservatoryB,0))
function ReceivedBrokenStone()       => bit4(locationBitflags(ObservatoryB,0))
function ClaudiaDollReturned()       => bit7(locationBitflags(SpecialGuestRoom,0))
function Clubbed()                   => bit1(locationBitflags(SpecialGuestRoom,0))
function SecretLightswitchOn()       => bit0(locationBitflags(TheaterHallway,0))
function FredQuestComplete()         => bit5(locationBitflags(TheaterHallway,0))
function ChildChestOpen()            => bit2(locationBitflags(ChildRoom,0))
function CastleComplete()            => bit0(locationBitflags(CastleTerrace,0))
function StairwayGhostDead()         => bit0(locationBitflags(Stairway,0))
function HeardMidnightClue()         => bit0(locationBitflags(LwrDeckTerrace,0))
function PoolComplete()              => bit2(locationBitflags(Pool,0))
function EscapedCemetery()           => bit2(locationBitflags(CemeteryCryptA,1))
function LadySpiritFreed()           => bit2(locationBitflags(TerraceLazarette,1))
function PoolPumpStarted()           => bit0(locationBitflags(TerraceLazarette,1))
function OpenedLockerFour()          => bit1(locationBitflags(CrewsQuartersA,0))

function CompletedPastHouseOutside() => bit0(locationBitflags(PastHouseOutside,0))
function PrescriptionDelivered()     => bit1(locationBitflags(MedicalOffice,0))
function FlagPuzzleSolved()          => bit3(locationBitflags(ReadingRoom,0))
function UnlockedStairwayDoor()      => bit0(locationBitflags(Stairway,2))
function KingGivenCameo()            => bit0(locationBitflags(PrivateQuarters,0))
function OrganSolved()               => bit0(locationBitflags(Cathedral,1))
function AstralPieceExchanged()      => bit1(locationBitflags(ObservatoryB,0))

/* $1BC660  [20 bytes] Static Config CodeFlow And Position

These 20 bytes are saved and loaded with your game

+0x00 [32-bit] CodeFlow
..normally this value is the same as locationoffset, but sometimes this value is different, those 
..conditions are labeled below
..0xc8=Roulette 
..0xc9=Slots
..0xca=Blackjack
..0xcd=In the Theater
..0xd2=Credits
..0xd3=Good or Evil Ending
..0xdc=Best Ending
..0xd4=Worst Ending Richard Missing (out of time on boat)

+0x4  [16-bit] NextXCoordinate
+0x6  [16-bit] NextYCoordinate
+0x8  [32-bit] NextZCoordinate
+0xc  [16-bit] NextCameraVPos
+0xe  [16-bit] NextCameraHPos

*/

function CodeFlow() => dword(0x1BC660)

// $1BEBC8: [384bytes][Array] PlayerInventory Array (96 slots)
//          
//          PlayerInventory is an array of Inventory Structs of the format
//          
//          - [  Inventory Slot
//          - - [8-bit] ItemID
//          - - [8-bit] ItemIsEquipped
//          - - [16-bit] ItemQty
//          - ]
//          
//          - [8-bit] ItemIsEquipped
//          - - 0x0=not equipped
//          - - 0x1=equipped
//          
//          - [16-bit] ItemQty
//          - - ItemQty is a short that contains the quantity of the item in this slot
//          
//          - [8-bit] ItemId
//          - - 0x01=Metal Handle
//          - - 0x02=Brass Key
//          - - 0x03=Red Book
//          - - 0x04=Holy Water
//          - - 0x05=Small Key
//          - - 0x06=Wire Cutter
//          - - 0x07=Invitation Letter
//          - - 0x08=Iron Key
//          - - 0x09=Sailor Medal A
//          - - 0x0A=Sailor Medal B
//          - - 0x0B=Sailor Medal C
//          - - 0x0C=Sailor Medal D
//          - - 0x0D=Broken Stone
//          - - 0x0E=Blue Stone Piece
//          - - 0x0F=Winding Key
//          - - 0x10=Glass
//          - - 0x11=Curing Potion
//          - - 0x12=Wire
//          - - 0x13=Athlete’s Foot Bot (Not Implemented)
//          - - 0x14=Rubber Gloves
//          - - 0x15=Dress Suit
//          - - 0x16=Astral Piece
//          - - 0x17=Flying Fish Plate
//          - - 0x18=Record
//          - - 0x19=Knife
//          - - 0x1A=Comet Book
//          - - 0x1B=Film
//          - - 0x1C=Crown Piece
//          - - 0x1D=Old Book
//          - - 0x1E=Prescription
//          - - 0x1F=Eye of A Sea Fish
//          - - 0x20=Gear
//          - - 0x21=Water Leaf Plate
//          - - 0x22=Forest Fire Plate
//          - - 0x23=Fire Bird Plate
//          - - 0x24=Claim Ticket
//          - - 0x25=Kitchen Key
//          - - 0x26=Crank
//          - - 0x27=Sailor’s Documents
//          - - 0x28=Engagement Ring
//          - - 0x29=Bullet
//          - - 0x2A=Earring
//          - - 0x2B=Music Box
//          - - 0x2C=Valve
//          - - 0x2D=Piston Key
//          - - 0x2E=Engine Room Key
//          - - 0x2F=Old Picture
//          - - 0x30=Blue Stone
//          - - 0x31=Clock Key
//          - - 0x32=Claudia’s Doll
//          - - 0x33=Antidote
//          - - 0x34=Cabinet Key
//          - - 0x35=Pendant
//          - - 0x36=Cameo
//          
//          - - don't normally show in inventory, but documenting the id's anyway
//          - - 0x5e=Ship Map
//          - - 0x5f=Leather Organizer

PlayerInventoryArrayStartAddr = 0x1bebc8


// $1D8D10 Config slot Array
ConfigSlotAddr = 0x1D8D10
function ConfigSlotInteractionID(index)     => dword(ConfigSlotAddr + (index * 0x718))
function ConfigSlotInteractionIDbyte(index) => byte(ConfigSlotAddr + (index * 0x718))
function ConfigSlotFunctionID(index)        => dword(ConfigSlotAddr + 0x10 + (index * 0x718))
function ConfigSlotDataPTR(index)           => dword(ConfigSlotAddr + 4 + (index * 0x718))

// $1DD6F8: [8-bit] Item Details Screen Open
//          
//          This is the screen that shows the items description and usually shows Use or Read options if they are available
//          Open the select screen, choose Item, then select the item you want to view
//          
//          0x0=Screen Not Open
//          0x1=Screen Open

// When opening the load menu/loading a game
// 0x1=On the load select screen --  before this bit flips 1dd6fa counts up to 4 as the memory card is checked
// 0x2=Load this data file? prompt
// 0x4=Loading save from memory card, waits for 1dd6fa to hit 2 before proceeding

// When opening save menu/saving a game
// 0x1=on the save select screen -- before this goes to 1 1dd6fa counts up to 4
// 0x2=overwrite/save data?  prompt
// 0x3=saving file   1dd6fa  counts up to 2  

function ScreenOpen() => byte(0x1DD6F8)

// $1DD6FA: [16-bit] SaveAndLoadStatus
// These values are set when the game is saving or loading, its also used to display error conditions like if the memory card is corrupted etc.
// Values are temporary, once save or load is complete the value resets to 0
// so any game logic looking for this value to be 0 are meant as save protection
function saveAndLoadStatus() => word(0x1DD6FA)


function GameLoaded() {
    return ScreenOpen() == 4 && saveAndLoadStatus() == 2
}

function GameSaved() {
    return ScreenOpen() == 3 && saveAndLoadStatus() == 2
}



// $1DD6FC: [8-bit] inventory slot highlighted
function inventorySlotHighlighted() => byte(0x1DD6FC)

// $1DD6FE: [8-bit] item is being interacted with
//          
//          0x01 highlighted in the item selection
//          0x32 Read clicked
//          0x33 Reading
function itemIsBeingInteractedWith() => byte(0x1DD6FE)

// $1DD704: [8-bit] Item Note Page
function itemNotePage() => byte(0x1DD704)

// $1FFED0: [32-bit] PTR
//          
//          0x0d playing normally
//          0x10 select screen up
//          0x0b map loading
//          0x40 map on screen floor1?
//          0x80082ed4  notes screen up
//          0x800542c0  inventory screen up
//          0x8005445c  inventory screen up, item selected in slot > 8
//          0x8005429c  inventory item details screen
function SomethingPtr() => dword(0x1FFED0)




GregCapstan     = 1
BillyBollard    = 2
FrankKeelson    = 7
PoleAndPaddle   = 10
FianaParcelling = 12
DianaParcelling = 13
RobbDerick      = 14
PeterSchooner   = 19
FredMoulding    = 24
KarenMoulding   = 25
ThomasGusset    = 29
ScottGarboard   = 30
CarterBatten    = 31
HowardBoss      = 32
BellLoran       = 33
EmllieScuttle   = 34
ArthurRockwell  = 35
HildaRockwell   = 36
OscarRockwell   = 37
CarlosRecess    = 38
PolyOwning      = 39
TomRudder       = 40
CharlieGirder   = 42
MikeTransom     = 43
RobertDanforth  = 44
JohnCutter      = 47
MartinBackstaff = 48
JimmyTender     = 50
EmiliaRockwell  = 52
JackRockwell    = 53
EdMooring       = 56

// personeNoteBit(personId,offset,bit)
function EncounteredFred()          => personNoteBit(FredMoulding,0,0)
// karen has a note page entry of 1 after speaking to her
function EncounteredKaren()         => personNoteBit(KarenMoulding,3,0)
// pole and paddle have a note page entry of 1 after encountering them
function EncounteredPoleAndPaddle() => personNoteBit(PoleAndPaddle,3,0)
// hildas given the clue for the stairway
function HeardDiversionClue()       => personNoteBit(HildaRockwell,0,0)
// talked to howard boss in the library
function EncounteredHowardBoss()    => personNoteBit(HowardBoss,0,0)
// talked to mike transom before sending the patrolman out
function EncounteredMikeTransom()   => personNoteBit(MikeTransom,0,0)






/* I like very little of these in practice

PeopleDossier= [
    // 0 unused
    {},
    // 1 captain capstan  freebie after finishing billy bollard
    {"name": "Greg Capstan", "notevalue": 3, "subname": "Captain", "location": UprDeckPassageway, "points": 1, "type": "progression"},
    // 2 billy bollard    get the wire cutters, wire, rubber gloves(2pts casefile), fix the fusebox, flip the light
    {"name": "Billy Bollard", "notevalue": 4, "subname": "Crewman", "location": ChartRoom, "points": 10, "type": "progression"},
    // 3 henry osmand young 1899
    {},
    // 4 william rockwell 1899
    {},
    // 5 crea rockwell child 1899
    {},
    // 6 billy bollard pier 1913
    {},
    // 7 frank keelson  talk to him after he's knocked out
    {"name": "Frank Keelson", "notevalue": 2, "subname": "Train Conductor", "location": SteamLocomotive, "points": 1, "type": "missable"},
    // 8 andrew galleywood castle   skipped as part of medieval murdering mercenary
    {},
    // 9 allen rockwell castle      skipped as part of medieval murdering mercenary
    {},
    // 10 pole & paddle  talk to them before watching the scene on the terrace
    {"name": "Pole & Paddle", "notevalue": 2, "subname": "Soldiers", "location": Castle, "points": 1, "type": "missable", "encounterbit": EncounteredPoleAndPaddle()},
    // 11 marvin foremast house, he's talked to as part of thorough investigation
    {},
    // 12 fiana parcelling  move the register to block the door skipped in favor of Mirrored Manipulation
    {},
    // 13 diana parcelling skipped in favor of Mirrored Manipulation
    {},
    // 14 robb derick
    {"name": "Robb Derick", "notevalue": 3, "subname": "Guest (Drunk)", "location": GuestHallway, "points": 3, "type": "progression"},
    // 15 william rockwell owners quarters
    {},
    // 16 not a notepage, related to peter schooner
    {},
    // 17 not a notepage, related to karen moulding
    {},
    // 18 not a notepage, related to fred moulding
    {},
    // 19 Peter Schooner  steward  skipped in favor of Suited to Sup
    //{"name": "Peter Schooner", "notevalue": 3, "subname": "Steward", "location": DiningHallway, "points": 2, "type": "progression"},
    {},
    // 20 Elizabeth Crownest (blackjack dealer)
    {},
    // 21 not a notepage, related to Poly Owning
    {},
    // 22 not a notepage, related to Tom Rudder
    {},
    // 23 not a notepage, related to Rose Crownest ???
    {},
    // 24 fred moulding
    {"name": "Fred Moulding", "notevalue": 2, "subname": "Guest (Child)", "location": ChildRoom, "points": 2, "type": "missable", "encounterbit": EncounteredFred()},
    // 25 karen moulding
    {"name": "Karen Moulding", "notevalue": 3, "subname": "Guest (Mother)", "location": ChildRoom, "points": 2, "type": "missable", "encounterbit": EncounteredKaren()},
    // 26 not a  notepage, related to Fred Moulding
    {},
    // 27 William Rockwell  crypt
    {},
    // 28 Thomas Gusset laboratory
    {},
    // 29 Thomas Gusset  2pts for the prescription, rescue the kid 3pts, give the film to engineer, watch film
    {"name": "Thomas Gusset",  "notevalue": 10, "subname": "Doctor", "location": Theater, "points": 2, "type": "progression"},
    // 30 scott garboard
    {"name": "Scott Garboard",  "notevalue": 6, "subname": "Theater Engineer", "location": Theater, "points": 2, "type": "progression"},
    // 31 carter batten
    {},
    // 32 howard boss  talk to him, and try and mess with the stack of books nearest him
    {"name": "Howard Boss", "notevalue": 2, "subname": "Librarian", "location": Library, "points": 2, "type": "missable", "encounterbit": EncounteredHowardBoss()},
    // 33 bell loran secretary
    {},
    // 34 Emllie Scuttle   this is putting the gear in the parrot
    {"name": "Emllie Scuttle", "notevalue": 3, "subname": "Servant", "location": TerraceLazarette, "points": 3, "type": "progression"},
    // 35 Arthur Rockwell
    {},
    // 36 Hilda Rockwell
    {},
    // 37 Oscar Rockwell after giving creas earring, this nets the forest plate
    {"name": "Oscar Rockwell", "notevalue": 8, "subname": "Boy", "location": RadioRoom, "points": 10, "type": "progression"},
    // 38 Carlos Recess
    {},
    // 39 Poly Owning
    {},
    // 40 Tom Rudder
    {},
    // 41 Henry Osmand compartment b (end of game)
    {}, 
    // 42 Charlie Girder set off the alarm, turn on the power, flip the light in the corridor
    {"name": "Charlie Girder", "notevalue": 3, "subname": "Probationer", "location": CrewsQuartersB, "points": 10, "type": "missable"},
    // 43 Mike Transom  talk to mike before doing the alarm thing with the probationer
    {"name": "Mike Transom", "notevalue": 2, "subname": "Patrolman", "location": CrewsCorridor, "points": 2, "type": "missable", "encounterbit": EncounteredMikeTransom()},
    // 44 Robert Danforth
    {"name": "Robert Danforth", "notevalue": 2, "subname": "Sailor", "location": EngineerHallway, "points": 5, "type": "progression"},
    // 45 John Cutter Amusement Park
    {},
    // 46 Sistina Ratline Amusement Park
    {}, 
    // 47 john cutter commented out in favor of Casefile Ring around the Sailor
    //{"name": "John Cutter", "notevalue": 2, "subname": "Sailor", "location": UprDeckPassageway, "points": 2, "type": "missable", "encounterbit": EncounteredClaudia()},
    {},
    // 48 martin backstaff  talk to him after solving the radio room
    {"name": "Martin Backstaff", "notevalue": 3, "subname": "Engineer", "location": EngineersRoom, "points": 2, "type": "progression"},
    // 49 Crea Rockwell   skipped for casefile sapphire sacrifice
    {},
    // 50 jimmy tender
    //{"name": "Jimmy Tender", "notevalue": 5, "subname": "Miner", "location": SpecialGuestRoom, "points": 2, "type": "progression"},
    {},
    // 51 not a notepage, related to William Rockwell
    {},
    // 52 Emilia Rockwell
    {"name": "Emilia Rockwell", "notevalue": 2, "subname": "Lady", "location": ForestRoom, "points": 2, "type": "missable"},
    // 53 jack rockwell
    {"name": "Jack Rockwell", "notevalue": 2, "subname": "Brother", "location": FireRoom, "points": 2, "type": "missable"},
    // 54 not a notepage, related to Henry Osmand
    {},
    // 55 unused
    {},
    // 56 ed mooring
    {"name": "Ed Mooring", "notevalue": 1, "subname": "Guest (Trapped)", "location": ReadingRoom, "points": 5, "type": "progression"},
    // 57 Ernest Ullage  finish all the quests for the crewman
    {"name": "Ernest Ullage", "notevalue": 2, "subname": "Sailor (Galley)", "location": DiningRoomGalley, "points": 4, "type": "progression"},
    // 58 A Medium
    {},
    // 59 unused
    {},
    // 60 Harry Gunwale    skipped for casefile sapphire sacrifice
    {},
    // 61 David Berthing   skipped for casefile sapphire sacrifice
    {},
]

NotebookPage = 3

function AchievementDossier(personID) {
    cheev = PeopleDossier[personID]
    Title = "Dossier: " + cheev["name"] + " - " + cheev["subname"]
    Description = "Complete the notebook dossier on " + cheev["name"]

    if cheev["type"] == "missable" {
      achievement(
        title = Title, description = Description, points = cheev["points"], type=cheev["type"],
        trigger = playerPuzzleStatus() == 1 && locationid() == cheev["location"] && saveAndLoadStatus() == 0
                  && trigger_when(personNoteByte(personID, NotebookPage) == cheev["notevalue"] && prev(personNoteByte(personID, NotebookPage) != cheev["notevalue"]))
        )
    } else if cheev["type"] == "progression" {
      achievement(
        title = Title, description = Description, points = cheev["points"], type=cheev["type"],
        trigger = playerPuzzleStatus() == 1 && locationid() == cheev["location"] && saveAndLoadStatus() == 0
                  && personNoteByte(personID, NotebookPage) == cheev["notevalue"] && prev(personNoteByte(personID, NotebookPage) != cheev["notevalue"])
          )            
    }
}

function AchievementSpecialDossier(personID) {
    cheev = PeopleDossier[personID]
    Title = "Dossier: " + cheev["name"] + " - " + cheev["subname"]
    Description = "Encounter " + cheev["name"] + " and then complete their dossier"

    if cheev["type"] == "missable" {
      achievement(
        title = Title, description = Description, points = cheev["points"], type=cheev["type"],
        trigger = playerPuzzleStatus() == 1 && locationid() == cheev["location"] && never(GameLoaded()) && once(cheev["encounterbit"] > prev(cheev["encounterbit"]))
                  && trigger_when(personNoteByte(personID, NotebookPage) == cheev["notevalue"] && prev(personNoteByte(personID, NotebookPage) != cheev["notevalue"]))
        )
    } else if cheev["type"] == "progression" {
      achievement(
        title = Title, description = Description, points = cheev["points"], type=cheev["type"],
        trigger = playerPuzzleStatus() == 1 && locationid() == cheev["location"] && never(GameLoaded()) && once(cheev["encounterbit"] > prev(cheev["encounterbit"]))
                  && personNoteByte(personID, NotebookPage) == cheev["notevalue"] && prev(personNoteByte(personID, NotebookPage) != cheev["notevalue"])
          )            
    }
}


 
// loop through the PeopleDossier's to make cheevs
// set id to peopleid as we loop through the elements since we need it to find the notebytes
id = 0
for d in PeopleDossier {
    // if there is no name skip making a cheev
    if dictionary_contains_key(d,"name") {
        // Fred Moulding has a special one, so skip it in this loop
        if d["name"] != "Fred Moulding" {
          // if there is an encounterbit, use the special dossier
          if dictionary_contains_key(d,"encounterbit") {
              AchievementSpecialDossier(id)
          // otherwise use the normal dossier
          } else {
              AchievementDossier(id)
          }
        }
    }
    // increment the peopleid
    id = id + 1
}



// Fred has complex logic for the right trigger conditions & involves 2 locations
achievement(
    title = "Dossier: " + PeopleDossier[FredMoulding]["name"] + " - " + PeopleDossier[FredMoulding]["subname"], 
    description = "Complete the notebook dossier on " + PeopleDossier[FredMoulding]["name"], 
    points = PeopleDossier[FredMoulding]["points"], type=PeopleDossier[FredMoulding]["type"],
    trigger = playerPuzzleStatus() == 1 && never(GameLoaded()) && once(locationid() == TheaterHallway && EncounteredFred() > prev(EncounteredFred()) && FredQuestComplete() == 0)
    && trigger_when(locationid() == ChildRoom && personNoteByte(FredMoulding, NotebookPage) == PeopleDossier[FredMoulding]["notevalue"] && 
                    prev(personNoteByte(FredMoulding, NotebookPage) != PeopleDossier[FredMoulding]["notevalue"])
       )
)


// This marks the delivery of the diamond ring to John cutter after returning from the amusement park
achievement(
    title = "Casefile: 4/11/1913 Ring Around the Sailor", description = "Help John Cutter's spirit move on", points = 5, type="missable",
    trigger= playerPuzzleStatus() == 1 && locationid() == UprDeckPassageway && saveAndLoadStatus() == 0 &&
      personNoteByte(JohnCutter, NotebookPage) == 2 && prev(personNoteByte(JohnCutter, NotebookPage) < 2)
)
*/





// Points variables to help keep scoring consistent
Trivial             = 1
Minor               = 2
EasyPuzzle          = 3
MediumPuzzle        = 4
HardPuzzle          = 10
MinorEvent          = 3
SmallEvent          = 4
MediumEvent         = 5
LargeEvent          = 10
MinorChallenge      = 3
EasyChallenge       = 5
MediumChallenge     = 10
HardChallenge       = 25



function id_or_zero(cheev) {
    if dictionary_contains_key(cheev,"id") {
        return cheev["id"]
    } else {
        return 0
    }
}



function AchievementFunction(cheev) {
    if cheev["kind"] == "generic" {
      achievement(
        title = cheev["title"], description = cheev["description"], points = cheev["points"], type=cheev["type"], id=id_or_zero(cheev),
        trigger = GameRunning() && locationid() == cheev["location"] && cheev["completionbit"] > prev(cheev["completionbit"])
      )
    } else if cheev["kind"] == "genericrev" {
      achievement(
        title = cheev["title"], description = cheev["description"], points = cheev["points"], type=cheev["type"], id=id_or_zero(cheev),
        trigger = GameRunning() && locationid() == cheev["location"] && cheev["completionbit"] < prev(cheev["completionbit"])
      )
      
    } else if cheev["kind"] == "genericpuzzle" {
      achievement(
        title = cheev["title"], description = cheev["description"], points = cheev["points"], type=cheev["type"], id=id_or_zero(cheev),
        trigger =  playerPuzzleStatus() == 0 && playerstanding() == 1 && locationid() == cheev["location"] &&
        cheev["completionbit"] > prev(cheev["completionbit"])
      )
    /*
    } else if cheev["kind"] == "casefile" {
        Title = "Casefile: " + cheev["casetitle"]
        Description = "Complete " + LocationLookup[cheev["location"]]
        achievement(
          title = Title, description = Description, points = cheev["points"], type=cheev["type"],
          trigger = playerPuzzleStatus() == 1 && locationid() == cheev["location"] && saveAndLoadStatus() == 0 && cheev["completionbit"] > prev(cheev["completionbit"])
        )
    */   
    } else if cheev["kind"] == "extraconditions" {
       achievement(
        title = cheev["title"], description = cheev["description"], points = cheev["points"], type=cheev["type"], id=id_or_zero(cheev),
        trigger = GameRunning() && locationid() == cheev["location"] && cheev["conditions"] 
        && cheev["completionbit"] > prev(cheev["completionbit"])
      )
    } else {
        assert(false,message="No matching cheevo kind found for " + cheev["kind"])
    }
}


Cheevos = [
    // Generic
    { "kind": "genericpuzzle", "title": "Time Twister", "description": "Solve the clock puzzle", "location": House, "completionbit": ClockWound(), "points": EasyPuzzle, "type": "progression"},
    // turn on the lightbulb, just to show an easily missable light switch to get people used to looking at everything
    { "kind": "generic", "title": "Lightbulb Moment", "description": "Always pay attention to your surroundings and turn on the basement light", "location": Basement, "completionbit":  BasementLightSwitchOn, "points": Trivial, "type": "missable"},
    // ring around the sailor   get the ring and give it to john
    { "kind": "generic", "title": "Ring Around the Sailor", "description": "Help John Cutter find peace", "location": UprDeckPassageway, "completionbit": IsSpawnedJohnCutterAstral(), "points": SmallEvent, "type": "missable"},
    // get the wire cutters, wire, rubber gloves(pair on a pier), fix the fusebox, flip the light in chart room
    { "kind": "generic", "title": "Shedding Some Light on Matters", "description": "Help Billy Bollard find peace", "location": ChartRoom, "completionbit": IsSpawnedBillyBollardAstral(), "points": LargeEvent, "type": "progression"},
    //
    { "kind": "generic", "title": "An Astral Exchange", "description": "Give an astral piece to the medium", "location": ObservatoryB, "completionbit": AstralPieceExchanged(), "points": Minor, "type": "missable", "id": 490706 },
    { "kind": "extraconditions", "title": "Equipped for Exchange", "description": "Give an astral piece to the medium on your first visit", "location": ObservatoryB, "completionbit": AstralPieceExchanged(), "points": EasyChallenge, "type": "missable",
        "conditions": never(locationid() != ObservatoryB) && once(VisitedMedium() > prev(VisitedMedium()))
    },        
    // give robb the proper drink mix
    { "kind": "generic", "title": "Dead Men Don't Drink", "description": "Help Robb Derick remember and find peace", "location": GuestHallway, "completionbit": IsSpawnedRobbAstral(), "points": MediumPuzzle, "type": "progression"},
    // complete the twins rooms
    { "kind": "generic", "title": "Mirrored Manipulation", "description": "Help Diana and Fiana find peace", "location": GuestRoomC, "completionbit": IsSpawnedFianaAstral(), "points": EasyPuzzle, "type": "progression"},
    // complete the medal puzzle and meet Ed
    // deferring this for the hint challenge one
    //{ "kind": "generic", "title": "Flaggage", "description": "Help Ed Mooring find peace", "location": ReadingRoom, "completionbit": IsSpawnedEdMooringAstral(), "points": MediumPuzzle, "type": "progression"},
    // Navigate the mine and return claudia's doll   triggers after the doll disappears on screen for best timing (genericrev)
    { "kind": "genericrev", "title": "Misery Mine", "description": "Help Claudia find peace", "location": SpecialGuestRoom, "completionbit": IsSpawnedClaudiasDoll(), "points": LargeEvent, "type": "progression", "id": 490704 },
    // pick up the dress suit and get clubbed
    { "kind": "generic", "title": "A Suitable Outfit for Clubbing", "description": "Retrieve the dress suit", "location": SpecialGuestRoom, "completionbit": Clubbed(), "points": Trivial, "type": "progression"},
    // Get the prescription
    { "kind": "generic", "title": "A Peculiar Prescription", "description": "Find and show the prescription to the doctor", "location": MedicalOffice, "completionbit": PrescriptionDelivered(), "points": SmallEvent, "type": "progression"},
    // get the record from film booth and play it in the child room and open the chest
    { "kind": "generic", "title": "Witness to Reunion", "description": "Reunite the lost child with his mother and retrieve the key items", "location": ChildRoom, "completionbit": ChildChestOpen(), "points": MediumPuzzle, "type": "progression"},
    // watch the film with the dr and learn it wasn't his fault
    { "kind": "generic", "title": "Anxiety Alleviated", "description": "Help Dr Thomas Gusset see the truth and find peace", "location": Theater, "completionbit": IsSpawnedThomasGussetAstral(), "points": SmallEvent, "type": "progression"},
    // pour the antidote on the acid
    { "kind": "genericrev", "title": "Rug Doctor", "description": "Clean the soiled carpet", "location": TheaterHallway, "completionbit": PouringAntidote(), "points": Minor, "type": "progression"},
    // wear the suit and go to dine
    { "kind": "generic", "title": "Suited to Sup", "description": "Be ushered to the dining hall", "location": DiningHallway, "completionbit": IsSpawnedStewardAstral(), "points": Trivial, "type": "progression"},
    // Get Past the ghost in the stairwell,  insert the gear in crow, turn on the light
    { "kind": "generic", "title": "Raven Ruckus", "description": "Eliminate the ghost with the help of a feathered friend", "location": Stairway, "completionbit": StairwayGhostDead(), "points": MediumPuzzle, "type": "progression"},
    // 
    { "kind": "generic", "title": "A Placating Pendant", "description": "Free the spirit of the ghost lady", "location": TerraceLazarette, "completionbit": LadySpiritFreed(), "points": Minor, "type": "progression"},
    // set off the alarm and get the document off the bed
    { "kind": "genericrev", "title": "An Alarming Situation", "description": "Get the probationers document", "location": CrewsQuartersB, "completionbit": IsSpawnedSailorsDocument(), "points": EasyPuzzle, "type": "progression"},
    // doors 1 and 2 open freely, the rest only open if the math adds up
    { "kind": "generic", "title": "It's All Starting To Add Up", "description": "Open locker number four", "location": CrewsQuartersA, "completionbit": OpenedLockerFour(), "points": MediumPuzzle, "type": "progression"},
    // put the gear in the parrot
    { "kind": "generic", "title": "A Paralyzed Patient", "description": "Fix the parrot and help Emllie Scuttle find peace", "location": TerraceLazarette, "completionbit": IsSpawnedEmllieScuttleAstral(), "points": Minor, "type": "progression"},
    // 
    { "kind": "generic", "title": "Plates Placed", "description": "Unlock the stairway door", "location": Stairway, "completionbit": UnlockedStairwayDoor(), "points": Minor, "type": "progression"},
    //
    { "kind": "generic", "title": "A Kingly Cameo", "description": "Return the cameo to its owner", "location": PrivateQuarters, "completionbit": KingGivenCameo(), "points": Minor, "type": "progression"},
    //
    { "kind": "generic", "title": "A Melody Made", "description": "Play a familiar tune", "location": Cathedral, "completionbit": OrganSolved(), "points": MediumPuzzle, "type": "progression"},   
    // 
    { "kind": "generic", "title": "Oscar's Release", "description": "Help Oscar Rockwell find peace", "location": RadioRoom, "completionbit": IsSpawnedOscarRockwellAstral(), "points": LargeEvent, "type": "progression"},   


    // Watch the events of the steam locomotive take place.  Who are these people?
    { "kind": "generic", "title": "A Bloody Departure", "description": "Complete the events on the steam locomotive", "location": SteamLocomotive, "completionbit": SteamLocomotiveComplete(), "points": MediumEvent, "type": "progression", "id": 489272},
    // Get the rubber gloves from the Pier
    { "kind": "generic", "title": "A Pair on a Pier", "description": "Retrieve the pair from the pier", "location": Pier, "completionbit": PierComplete(), "points": MinorEvent, "type": "progression", "id": 489426},
    // Watch the cutscene at the castle after speaking with arthur & hilda
    { "kind": "generic", "title": "Medieval Murdering Mercenary", "description": "Witness the events in the castle", "location": CastleTerrace, "completionbit": CastleComplete(), "points": MinorEvent, "type": "progression", "id": 497652},
    // retrieve the pendant and escape the cemetery (hopefully with the flying fish plate)
    { "kind": "extraconditions", "title": "Creep in a Crypt", "description": "Retrieve the fish plate and escape the cemetery", "location": CemeteryCryptA, "completionbit": EscapedCemetery(), "points": LargeEvent, "type": "progression", "id": 497950,
        "conditions": FlyingFishPlateInLastSlot() == 0,
    },
    // complete the events of the house
    { "kind": "generic", "title": "A Sapphire Sacrifice", "description": "Save and be saved by Crea", "location": PastHouseOutside, "completionbit": CompletedPastHouseOutside(), "points": MediumEvent, "type": "progression", "id": 497954},

    
]

for c in Cheevos {
    AchievementFunction(c)
}

// Page Turners cheevos

function AchievementBookFunction(Book) {
achievement(
    title = "Page Turners: "  + Book["name"], points = Book["points"], type = "missable",
    description = "Read all the pages of " + Book["name"],
    trigger = unless((GameContinuedState() > 0 && ScreenOpen() != 1) || itemIsBeingInteractedWith() != 51 ||
                  byte(inventorySlotHighlighted() * 8 + PlayerInventoryArrayStartAddr) != Book["itemid"]
              ) &&
              measured(tally_of( 
                 range(0,Book["numpages"]-1), Book["numpages"], (p) => once(itemNotePage() == p)
              )) && never(inventorySlotHighlighted() != prev(inventorySlotHighlighted()))
)
}

BookNames = {
    3:  "Red Book",
    26: "Comet Book",
    29: "Old Book",
    30: "Prescription",
    39: "Sailor's Documents",
}

RedBook          = 3
CometBook        = 26
OldBook          = 29
Prescription     = 30
SailorsDocuments = 39

Books = [
    // red book is not required to be picked up, so i gave it 1 more point
    {"name": BookNames[RedBook],          "numpages": 9, "itemid": RedBook,          "points": Minor},
    {"name": BookNames[CometBook],        "numpages": 3, "itemid": CometBook,        "points": Trivial},
    {"name": BookNames[Prescription],     "numpages": 3, "itemid": Prescription,     "points": Trivial},
    {"name": BookNames[OldBook],          "numpages": 9, "itemid": OldBook,          "points": Trivial},
    {"name": BookNames[SailorsDocuments], "numpages": 3, "itemid": SailorsDocuments, "points": Trivial},
]

for b in Books {
    AchievementBookFunction(b)
}

MapArray = []

// put the 10 mapcompletion bitcounts into the map array

// Pilothouse is always set to 1, so to prevent the indicator from increasing when you just start the game
// look at the 8 bits individually, replacing the pilothousebit with its entity bit
for m in range(0,9) {
    if m == 0 {
        array_push(MapArray, visitedUprDeckPilothouse())
        for b in range(1,7) {
            array_push(MapArray, locationMapBit(b))
        }
    } else {
        array_push(MapArray, bitcount(mapCompletionArrayByte(m)))
    }
}


// Player has been in every location in the game.  Many locations are optional
// measured value is number of map bytes * 8 (for 8 bits)
// 10 map bytes * 8 bits = 80
MapCompleteCount = 80
achievement(
    title = "Fully Mapped", points = MediumChallenge,
    description = "Achieve 100% map completion",
    id = 444146,
    trigger = GameRunning() &&
              sum_of(MapArray, (m) => prev(m)) < MapCompleteCount &&
              measured(sum_of(MapArray, (m) => m) == MapCompleteCount, format="percent")
)

// A Thorough Investigation
//
// Tooltips can be viewed by pressing Triangle on a highlighted object
// 15 steps to completion
// make sure to view the winding key tooltip before picking it up
// All objects/items are on the first floor of the house
// viewing the red book will teleport you away 
// this must be completed prior to teleporting away or it will be missed

// Items with tooltips
HouseFireplace            = 1
HouseBurntBookshelf1      = 2
HouseBurntBookshelf2      = 3
HouseLamp                 = 4
HouseBed                  = 13
HouseUnlockedClockCabinet = 61
HouseWindingKey           = 201
HouseBurntChair           = 255
HouseGrandfatherClock     = 267

// when the opened clock is in slot 0, the clock hands and keyhole are in slot 3
MinuteHand                = 3
HourHand                  = 2
WindingKeyhole            = 1

// Items without tooltips
HouseFirstDoor            = 6
HouseBedroomDoor          = 8
HousePolicemanIntro       = 101
HousePoliceman            = 110
HouseOpenedClock          = 0x100000B

// Function IDs
ReadingTooltip            = 23
None                      = 0
Opening                   = 18
Closing                   = 11

achievement(
    title = "A Thorough Investigation", points = EasyChallenge, type="missable",
    description = "Investigate everything in the house before leaving the area",
    id = 461607,
    trigger = (GameRunning() && never(locationid() != House)) &&  SteamLocomotiveComplete() == 0 &&
              once(ConfigSlotInteractionID(0) == HousePolicemanIntro) &&
              (trigger_when(measured(tally(15, 
                    once(ConfigSlotInteractionID(0) == HousePoliceman        && ConfigSlotFunctionID(0) == None),
                    once(ConfigSlotInteractionID(0) == HouseFirstDoor        && ConfigSlotFunctionID(0) == Opening),
                    once(ConfigSlotInteractionID(0) == HouseBedroomDoor      && ConfigSlotFunctionID(0) == Opening),                 
                    once(ConfigSlotInteractionID(0) == HouseFireplace        && ConfigSlotFunctionID(0) == ReadingTooltip),
                    once(ConfigSlotInteractionID(0) == HouseBurntBookshelf1  && ConfigSlotFunctionID(0) == ReadingTooltip),
                    once(ConfigSlotInteractionID(0) == HouseBurntBookshelf2  && ConfigSlotFunctionID(0) == ReadingTooltip),
                    once(ConfigSlotInteractionID(0) == HouseLamp             && ConfigSlotFunctionID(0) == ReadingTooltip),
                    once(ConfigSlotInteractionID(0) == HouseBurntChair       && ConfigSlotFunctionID(0) == ReadingTooltip),
                    once(ConfigSlotInteractionID(0) == HouseWindingKey       && ConfigSlotFunctionID(0) == ReadingTooltip),
                    once(ConfigSlotInteractionID(0) == HouseBed              && ConfigSlotFunctionID(0) == ReadingTooltip),
                    once(ConfigSlotInteractionID(0) == HouseGrandfatherClock && ConfigSlotFunctionID(0) == ReadingTooltip),
                    once(currentInteractionID() == MinuteHand         && currentFunctionID() == ReadingTooltip),
                    once(currentInteractionID() == HourHand           && currentFunctionID() == ReadingTooltip),
                    once(currentInteractionID() == WindingKeyhole     && currentFunctionID() == ReadingTooltip),
                    once(ClockWound() > prev(ClockWound()))),
                    format="percent"
                )))
)


// Number of configslots to check 
slotsToCheck = 5


// Basement puzzle

// View the painting tooltip, then solve the puzzle by placing the statues correctly
// in testing this only appeared in config slot1, but using the full selection just in case

Painting     = 0x103
PaintingClue = 0x8018deec

achievement(
    title = "Life Imitates Art", points = Minor, type="missable",
    description = "View the clue then solve the puzzle",
    trigger = GameRunning() && never(locationid() != Basement) &&
                once(currentFunctionID() == ReadingTooltip  && currentInteractionID() == Painting && currentDataPTR() == PaintingClue) &&
                trigger_when(BasementPuzzleSolved() > prev(BasementPuzzleSolved()))
)


CasinoBoss       = 0x164
Dialogue         = 0x17
// These are pointers to the start of ascii text block in their custom encoding
LightSwitchClue1 = 0x8018f9b8
LightSwitchClue2 = 0x8018fa8c
LightSwitchClue3 = 0x8018fb5c

achievement(
    title = "Breadcrumbs to Illumination", points = MinorChallenge, type="missable",
    description = "In one session without saving or loading, hear the clue then turn on the secret lightswitch",
    id = 491963,
    trigger = (GameContinuedState() > 0 && locationid() == prev(locationid()) && currentConfigSlotAddr() == prev(currentConfigSlotAddr()) && once(SecretLightswitchOn() == 0) &&
              never(GameLoaded()) && never(GameSaved())) &&
              (  
                once(locationid() == Casino && currentFunctionID() == Dialogue  && currentInteractionID() == CasinoBoss && currentDataPTR() == LightSwitchClue1) &&
                once(locationid() == Casino && currentFunctionID() == Dialogue  && currentInteractionID() == CasinoBoss && currentDataPTR() == LightSwitchClue2) &&
                once(locationid() == Casino && currentFunctionID() == None      && currentInteractionID() == CasinoBoss && currentDataPTR() == LightSwitchClue3) &&
                trigger_when(locationid() == TheaterHallway && SecretLightswitchOn() > prev(SecretLightswitchOn()))
              ) 
)

achievement(
    title = "In the Pale Moonlight", points = EasyChallenge, type="missable",
    description = "In one session without saving or loading, hear the clue and complete the pool",
    trigger = GameContinuedState() > 0 && once(locationid() == LwrDeckTerrace && HeardMidnightClue() > prev(HeardMidnightClue()) && PoolComplete() == 0) && never(GameLoaded()) && never(GameSaved()) &&
              trigger_when((locationid() == Pool && PoolComplete() > prev(PoolComplete())))
)

// speak to hilda rockwell then clear the stairwell
achievement(
    title = "Diversion Directed", points = EasyChallenge, type="missable",
    description = "In one session without saving or loading, hear the clue and banish the stairway ghost",
    trigger = GameContinuedState() > 0 && once(locationid() == GrandDining && HeardDiversionClue() > prev(HeardDiversionClue()) && StairwayGhostDead() == 0) && never(GameLoaded()) && never(GameSaved()) &&
              trigger_when((locationid() == Stairway && StairwayGhostDead() > prev(StairwayGhostDead())))
)


// collect all four plates ?

BlurrySign = 0x25
SignTooltip = 0x8018f9ec

// view the clue and start the generator
// the sign is very blurry so the cheevo title has dots to simulate missing letters
achievement(
    title = "Pow.r th. Po.l P.mp", points = MediumPuzzle, type="missable",
    description = "View the instruction tooltip and start the pool pump",
    trigger = GameRunning() && never(locationid() != TerraceLazarette) && once(PoolPumpStarted() == 0) &&
                any_of(range(0,slotsToCheck-1), (id) => 
                  (once(ConfigSlotFunctionID(id) == ReadingTooltip && ConfigSlotInteractionID(id) == BlurrySign && ConfigSlotDataPTR(id) == SignTooltip) &&
                   trigger_when(PoolPumpStarted() > prev(PoolPumpStarted()))
                  )
                )
)



achievement(
    title = "An Investigator Needs His Notebook", points = Trivial,
    description = "Retrieve the Leather Organizer", type="missable",
    id = 489435,
    trigger = GameRunning() && locationid() == CaptainsCabin && leatherOrganizer() > prev(leatherOrganizer())
)

achievement(
    title = "Navigating the Nightmare", points = Minor,
    description = "Retrieve the ship map and start charting your journey", type="missable",
    id = 490705,
    trigger = GameRunning() && locationid() == 0 && shipMap() > prev(shipMap())
)

// Fusebox does not flip a bit in the current location, but instead flips a bit in the adjacent room (0x4=Compartment)

achievement(
    title = "O.S.H.A. Approved", points = MinorChallenge,
    description = "Fix the fusebox without getting zapped", type="missable",
    id = 490703,
    trigger = (GameRunning() && never(locationid() != UprDeckPassagewayInside) &&
               once(FuseBoxWired() == 0) && once(FuseBoxWired() > prev(FuseBoxWired())) &&
               disable_when(locationid() == UprDeckPassagewayInside && playerPuzzleStatus() == 0 && playerstanding() == 1 && playerCondition() < prev(playerCondition()), until=GameLoaded())
    )
)

// happens automatically after speaking with the ghost captain and entering the upr deck passageway

achievement(
    title = "A G..G..G..Ghost!", points = Trivial, type="progression",
    description = "Meet a ghostly girl and mysteriously get rescued",
    id = 489270,
    trigger = GameRunning() && locationid() == UprDeckPassageway &&
              EncounteredClaudia() > prev(EncounteredClaudia())
)

// Grabbed With Gusto
// retrieve the wire cutters from the wall without being hit by the ghost
// watch her position, you can duck down/hide/wait her out if she is close to you
// as long as you don't walk into her you should be able to make it to the door

ExitDoor = 3

achievement(
    title = "Grabbed With Gusto", points = MinorChallenge, type="missable",
    description = "Retrieve the wire cutters and exit the room without being hit by the ghost",
    id = 489271,
    trigger = disable_when(locationid() == UprDeckCompartment && TakenDamage(), until=GameLoaded()) && 
              GameRunning() && never(locationid() != 4) && once(IsSpawnedWireCutter() == 1) &&
              trigger_when(
                once(IsSpawnedWireCutter() < prev(IsSpawnedWireCutter())) &&
                (ConfigSlotInteractionID(0) == ExitDoor || ConfigSlotInteractionID(1) == ExitDoor || ConfigSlotInteractionID(2) == ExitDoor)
              )          
)

achievement(
    title = "When You Wish Upon a Star", points = MediumEvent, type="progression",
    description = "Visit the Medium",
    trigger = GameRunning() && never(locationid() != ObservatoryB) &&
              once(VisitedMedium() > prev(VisitedMedium())) &&
              ReceivedBrokenStone() > prev(ReceivedBrokenStone())
)


// Ghost Hunter: Claudia
// chase claudia out of all 3 areas she haunts when she is visible to the player
// the bitflags for claudias haunting change based on conditions whether she has hit you, whether you have successfully dodged her for a cycle, etc
// so we use bitwise AND to make sure that one of the bits in the mask is turned on
// also we are using only the first 8-bits of a 32-bit value on the configslots as they turn the higher bits on and off based on object states/flow
// also worth noting claudia only appears in the pilothouse when it's past 10-11pm 
// missable if claudia's quest is completed before this task.

// need to add 0xb hallway
//             0xf  guest room a
//             0x10 guest room b

// she spawns in guest hallway 0xc after the drunk is cleared, but there is no lightswitch in this area, its in the previous area

function ClaudiaComplete() => bit7(locationBitflags(SpecialGuestRoom,0))
/*
achievement(
    title = "Ghost Hunter: Claudia", points = MediumChallenge, type="missable",
    description = "In one session see Claudia in every room possible without taking damage",
    trigger = playerPuzzleStatus() == 1 && saveAndLoadStatus() == 0 && ClaudiaComplete() == 0 && EncounteredClaudia() == 1 &&
       currentInteractionID() == prev(currentInteractionID()) && 
       never(playerCondition() < prev(playerCondition())) &&
        measured(
            tally(3, 
                once(
                  locationid() == UprDeckPassagewayInside && currentInteractionIDByte() == 0xf9 && prev(currentInteractionIDByte() != 0xf9)
                ),
                once(
                  locationid() == UprDeckCompartment && currentInteractionIDByte() == 0xfd && prev(currentInteractionIDByte() != 0xfd)
                ),
                once(
                  locationid() == Pilothouse && currentInteractionIDByte() == 0xfa && prev(currentInteractionIDByte() != 0xfa)
                )
            )
        )
)
*/       



TICKETS = [
    {"ticket": IsSpawnedFloor1LoungeClaimTicketFarLeftUnderBar(),                    "loc": Lounge},
    {"ticket": IsSpawnedFloor1GrandDiningClaimTicketOnTableOppositeTheKitchenDoor(), "loc": GrandDining},
    {"ticket": IsSpawnedSpecialGuestRoomClaimTicketBathroomFloor(),                  "loc": SpecialGuestRoom},
    {"ticket": IsSpawnedFloor2TheaterClaimTicketOnSofaInMainTheater(),               "loc": Theater},
    {"ticket": IsSpawnedLwrDeckPoolClaimTicketInStarboardLocker(),                   "loc": Pool},
    {"ticket": IsSpawnedFloor2CasinoClaimTicketFloorByRouletteTable(),               "loc": Casino},
    {"ticket": IsSpawnedFloor2BathroomClaimTicketInLastStall(),                      "loc": Bathroom},
    {"ticket": IsSpawnedFloor1FireRoomClaimTicketOnLargeBed(),                       "loc": FireRoom},
]

// disable prevents any measurements from happening until after the player is in the game
// measured displays status towards pickups
// Items are not spawned til the location is visited, which is why we multiply * the "visited x location" bits
// Once an Item has been picked up it goes from 1 ->
// Which is why we are counting the negated values, and looking for the value to decrease in the delta
// only asking for 1 hit, so you can have a save with all but 1 collected and this will fire appropriately.
// never(saveAndLoadStatus() != 0) makes sure we won't count any hits until after a game is saved or loaded
// never((gamecontinuedstate() != prev(gamecontinuedstate()))) catches when a new game starts or is continued from the main menu
achievement(
    title = "Ticket Master", points = MediumChallenge, type="missable",
    description = "Collect every claim ticket before completing the casino",
    trigger = disable_when(GameContinuedState() == 0, until=GameContinuedState() > 0) && unless(CasinoClosed() == 1) && saveAndLoadStatus() == 0 &&
              measured(
                (sum_of(range(0,length(TICKETS)-1), (i) => ~(TICKETS[i]["ticket"]) * locationMapBit(TICKETS[i]["loc"])) == length(TICKETS))
              ) &&
                tally_of(TICKETS, 1, (t) => once(t["ticket"] < prev(t["ticket"]))
              ) && never(GameLoaded()) && never(GameOver())              
)

CURES = [
    {"cure": IsSpawnedGuestRoomDCuringPotionInDrawer(),                            "bit": locationMapBit(GuestRoomD)},
    {"cure": IsSpawnedGuestRoomCCuringPotionInDrawer(),                            "bit": locationMapBit(GuestRoomC)},
    {"cure": IsSpawnedBoilerACuringPotionFloorAtBottomOfStairs(),                  "bit": locationMapBit(BoilerA)},
    {"cure": IsSpawnedFloor1WaterRoomCuringPotionGroundInBedroom(),                "bit": locationMapBit(WaterRoom)},
    {"cure": IsSpawnedFloor2ShowerRoomCuringPotionInLocker(),                      "bit": locationMapBit(ShowerRoom)},
    {"cure": IsSpawnedLwrDeckPoolRoomCuringPotionInPortLocker(),                   "bit": locationMapBit(Pool)},
    {"cure": IsSpawnedFloor2EngineersRoomCuringPotionInBackRoomChest(),            "bit": locationMapBit(EngineersRoom)},
    {"cure": IsSpawnedFloor2MedicalOfficeCuringPotionDrawer(),                     "bit": locationMapBit(MedicalOffice)},
    {"cure": IsSpawnedFloor2MedicalOfficeCuringPotionCabinet(),                    "bit": locationMapBit(MedicalOffice)},
    {"cure": IsSpawnedCaptainsCabinCurePotionInDrawer(),                           "bit": locationMapBit(CaptainsCabin)},
    {"cure": IsSpawnedUprDeckPilothouseCurePotionInCabinet(),                      "bit": locationMapBit(Pilothouse)},
    {"cure": IsSpawnedUprDeckPilothouseCurePotionInCabinet2(),                     "bit": locationMapBit(Pilothouse)},
]


// see above notes on Ticket Master for detailed logic reasons
// this is the same but with cure potions

achievement(
    title = "Master of Cures", points = HardChallenge, type="missable",
    description = "Collect Every cure potion",
    trigger = disable_when(GameContinuedState() == 0, until=GameContinuedState() > 0) && saveAndLoadStatus() == 0 &&
              measured(
                (sum_of(range(0,length(CURES)-1), (i) => ~(CURES[i]["cure"]) * CURES[i]["bit"]) == length(CURES))
              ) &&
                tally_of(CURES, 1, (c) => once(c["cure"] < prev(c["cure"]))
              ) && never(GameLoaded()) && never(GameOver()) 
)



// There are 50 people to meet, check all the slots with hitcounts so we can keep a measured

function PersonMetByte(numPeople) => byte(PeopleMetAddr + numPeople - 1)

TotalNumberOfPeople = 50

achievement(
    title = "People Person", points = MediumChallenge, type="missable",
    description = "Meet every person in the game",
    trigger = disable_when(GameContinuedState() == 0, until=GameContinuedState() > 0) && saveAndLoadStatus() == 0 && 
              measured(tally_of(range(1,TotalNumberOfPeople), TotalNumberOfPeople, (i) => once(PersonMetByte(i) != 0xff))) &&
              prev(PersonMetByte(TotalNumberOfPeople) == 0xff) && never(GameLoaded()) && never(GameOver()) 
)


// Save all 26 souls and give their astral pieces to the medium
achievement(
    title = "Soul Saver", points = HardChallenge, type="missable",
    description = "Save everyone in the game and return their astral pieces to the medium",
    trigger = GameRunning() &&
              measured(astralPiecesTurnedIn() == 26) && prev(astralPiecesTurnedIn() < 26)
)



// desk in guest room A has the clue to check the paintings for the drunk guy




// Cemetery
// grave1 front
//0x10, 8018f11c  "eminent man who sought the beginning"
Grave1Front = 0x10
Grave1FrontData = 0x8018f11c
// grave1 back
Grave1Back = 0x110
Grave1BackData = 0x8018eff8
//0x110, 8018eff8 "emblem has a tower in the center"
// grave2 front
//0xf, 8018eee4 with his last breath of life he cuts open the eternal path
Grave2Front = 0xf
Grave2FrontData = 0x8018eee4

// grave2 back
//0x10f "emblem shape of a fish"
Grave2Back = 0x10f
Grave2BackData = 0x8018ed9c
// grave3 front
Grave3Front = 0xe
Grave3FrontData = 0x8018ec9c
//0xe, 8018ec9c  "infinitely inside the abyss between life and death"
//grave3 back
Grave3Back = 0x10e
Grave3BackData = 0x8018eb64
//0x10e "emblem shape of wing"

function SolvedCryptPuzzle() => bit3(locationBitflags(CemeteryGraveyard,0))

/*
achievement(
    title = "A Grave Opening", points = EasyChallenge, type = "missable",
    description = "Look at the clues and then open the crypt",
    trigger = playerPuzzleStatus() == 1 && never(locationid() != CemeteryGraveyard) &&
              any_of(range(0,slotsToCheck-1), (id) => 
                once(ConfigSlotInteractionID(id) == Grave1Front && ConfigSlotDataPTR(id) == Grave1FrontData) &&
                once(ConfigSlotInteractionID(id) == Grave1Back && ConfigSlotDataPTR(id) == Grave1BackData) &&
                once(ConfigSlotInteractionID(id) == Grave2Front && ConfigSlotDataPTR(id) == Grave2FrontData) &&
                once(ConfigSlotInteractionID(id) == Grave2Back && ConfigSlotDataPTR(id) == Grave2BackData) &&
                once(ConfigSlotInteractionID(id) == Grave3Front && ConfigSlotDataPTR(id) == Grave3FrontData) &&
                once(ConfigSlotInteractionID(id) == Grave3Back && ConfigSlotDataPTR(id) == Grave3BackData) &&
                SolvedCryptPuzzle() > prev(SolvedCryptPuzzle())
              )
)
*/

GraveClues = [
{"location": CemeteryGraveyard, "id": Grave1Front, "fid": ReadingTooltip, "dptr": Grave1FrontData}, 
{"location": CemeteryGraveyard, "id": Grave1Back,  "fid": ReadingTooltip, "dptr": Grave1BackData},
{"location": CemeteryGraveyard, "id": Grave2Front, "fid": ReadingTooltip, "dptr": Grave2FrontData}, 
{"location": CemeteryGraveyard, "id": Grave2Back,  "fid": ReadingTooltip, "dptr": Grave2BackData},
{"location": CemeteryGraveyard, "id": Grave3Front, "fid": ReadingTooltip, "dptr": Grave3FrontData}, 
{"location": CemeteryGraveyard, "id": Grave3Back,  "fid": ReadingTooltip, "dptr": Grave3BackData},   
]


// Find all the paintings/pictures in the game, excludes the one in the basement in the beginning since you can't get back there after you leave.

// TODO: Guest Room A  has a painting
Artwork = [
{"location": Lounge,      "id": 22, "fid": ReadingTooltip, "dptr": 0x8018e63c}, // 3bottles painting
{"location": Lounge,      "id": 23, "fid": ReadingTooltip, "dptr": 0x8018e734}, // E.M. Painting
{"location": Lounge,      "id": 24, "fid": ReadingTooltip, "dptr": 0x8018e828}, // K.S. Painting
{"location": Lounge,      "id": 14, "fid": ReadingTooltip, "dptr": 0x8018de28}, // giant snake 2 blades painting
{"location": GrandDining, "id": 17, "fid": ReadingTooltip, "dptr": 0x8018de5c}, // old castle with sun
{"location": GrandDining, "id": 19, "fid": ReadingTooltip, "dptr": 0x8018e00c}, // strange monster
{"location": GrandDining, "id": 18, "fid": ReadingTooltip, "dptr": 0x8018df30}, // lady with fin
{"location": WaterRoom,   "id": 32, "fid": ReadingTooltip, "dptr": 0x8018e9d0}, // hilda rockwell
{"location": WaterRoom,   "id": 31, "fid": ReadingTooltip, "dptr": 0x8018e944}, // arthur rockwell
{"location": SkyRoom,     "id": 29, "fid": ReadingTooltip, "dptr": 0x8018ea2c}, // pic with baby
{"location": SkyRoom,     "id": 28, "fid": ReadingTooltip, "dptr": 0x8018e970}, // commemorative picture
{"location": SkyRoom,     "id": 31, "fid": ReadingTooltip, "dptr": 0x8018ec38}, // pic parents with daughter
{"location": SkyRoom,     "id": 30, "fid": ReadingTooltip, "dptr": 0x8018eb60}, // pic dad& 4year old crea
{"location": SkyRoom,     "id": 32, "fid": ReadingTooltip, "dptr": 0x8018ed0c}, // painting of a castle
] 

Claudia = [  
{"location": UprDeckCompartment,      "id": 0xf0, "dptr": 0x19b0000 }, // for some reason the compartment claudia is a different id
{"location": UprDeckPassagewayInside, "id": 0xf9, "dptr": 0x19b0000 },
{"location": Pilothouse,              "id": 0xf9, "dptr": 0x19b0000 },
{"location": GuestRoomA,              "id": 0xf9, "dptr": 0x19b0000 },
{"location": GuestRoomB,              "id": 0xf9, "dptr": 0x19b0000 },
{"location": GuestHallway,            "id": 0xf9, "dptr": 0x19b0000 },
{"location": PassengerHallway,        "id": 0xf9, "dptr": 0x19b0000 },
]



function InteractionAchievementPreconditions() { 
    return GameRunning() && never(GameLoaded()) && never(GameOver()) && currentConfigSlotAddr() == prev(currentConfigSlotAddr())
}

// pause lock until gameover or game loaded when player takes damage
function pauseLockCondition() {
    return disable_when(once(TakenDamage()), until=(GameLoaded() || GameOver() ))
}


function ClaudiaPauseLock() {
    return disable_when((IsSpawnedClaudiasDoll() == 0 && locationMapBit(AbandonedMineC) == 1) && TakenDamage(), until=(GameLoaded() || GameOver() ))
}

// Make sure that we don't start counting claudia interactions until the doll is picked up. At this point all of claudias locations are available.
// Hopefully this encourages player to make a save after getting the doll and before returning it to do this achievement
// reset if player takes damage, pause lock until gameload
function ClaudiaPreconditions() {
    return InteractionAchievementPreconditions() && never(TakenDamage()) && ClaudiaPauseLock() && (IsSpawnedClaudiasDoll() == 0 && locationMapBit(AbandonedMineC) == 1)
}

function ClaudiaPostconditions() {
    return ClaudiaDollReturned() > prev(ClaudiaDollReturned())
}

function ClaudiaCondition(cheev) {

    return once(repeated(600, locationid() == cheev["location"] && currentInteractionIDByte() == cheev["id"]) && currentDataValue2() == cheev["dptr"])  
/*
    if dictionary_contains_key(cheev,"id2") {
        return once(locationid() == cheev["location"] && ((currentInteractionIDByte() == cheev["id"] || currentInteractionIDByte() == cheev["id2"]) && currentDataValue2() == cheev["dptr"]))
    } else {
        return once(repeated(600, locationid() == cheev["location"] && currentInteractionIDByte() == cheev["id"]) && currentDataValue2() == cheev["dptr"])      
    }
*/
}


// 10000f9  8018e7ec
// 10001f9  8018e758  // creepy laugh



function AchievementInteractionFunction(cheev,conditiontype) {
   if conditiontype == "post" {
        achievement(
        title = cheev["title"], points = cheev["points"], description = cheev["description"], type = cheev["type"],
        trigger = InteractionAchievementPreconditions() &&
                  measured(tally_of(
                           cheev["list"], length(cheev["list"]),
                           (o) => once(
                                  locationid() == o["location"] && currentInteractionID() == o["id"] && currentFunctionID() == o["fid"] && 
                                  currentDataPTR() == o["dptr"] && prev(currentDataPTR() != o["dptr"])
                                  )
                  )) && cheev["postconditions"]
                 
    )
  } else if conditiontype == "pre" {
        achievement(
        title = cheev["title"], points = cheev["points"], description = cheev["description"], type = cheev["type"],
        trigger = InteractionAchievementPreconditions() &&
                  cheev["preconditions"] &&
                  measured(tally_of(
                           cheev["list"], length(cheev["list"]),
                           (o) => once(
                                  locationid() == o["location"] && currentInteractionID() == o["id"] && currentFunctionID() == o["fid"] && 
                                  currentDataPTR() == o["dptr"] && prev(currentDataPTR() != o["dptr"])
                                  )
                  ))
                 
    )      
  } else if conditiontype == "both" {
        achievement(
        title = cheev["title"], points = cheev["points"], description = cheev["description"], type = cheev["type"],
        trigger = InteractionAchievementPreconditions() &&
                  cheev["preconditions"] &&
                  measured(tally_of(
                           cheev["list"], length(cheev["list"]),
                           (o) => once(
                                  locationid() == o["location"] && currentInteractionID() == o["id"] && currentFunctionID() == o["fid"] && 
                                  currentDataPTR() == o["dptr"] && prev(currentDataPTR() != o["dptr"])
                                  )
                  )) && cheev["postconditions"]
    ) 
  } else if conditiontype == "none" {
    achievement(
        title = cheev["title"], points = cheev["points"], description = cheev["description"], type = cheev["type"],
        trigger = InteractionAchievementPreconditions() &&
                  measured(tally_of(
                           cheev["list"], length(cheev["list"]),
                           (o) => once(
                                  locationid() == o["location"] && currentInteractionID() == o["id"] && currentFunctionID() == o["fid"] && 
                                  currentDataPTR() == o["dptr"] && prev(currentDataPTR() != o["dptr"])
                                  )
                  )) 
    )
  } else if conditiontype == "claudia" {
        achievement(
        title = cheev["title"], points = cheev["points"], description = cheev["description"], type = cheev["type"], id = cheev["id"],
        trigger = (ClaudiaPreconditions()) &&
                  measured(tally_of(
                           cheev["list"], length(cheev["list"]), (o) => ClaudiaCondition(o)
                  )) && trigger_when(ClaudiaPostconditions())
    )    
  } else {
      assert(false,message="Condition type error with  " + conditiontype)
  }
}




ClaudiaCheevos = [
    {"title": "I Ain't Afraid of No Ghost", "points": HardChallenge, "description": "In one session, without being hit, spend 10 seconds with Claudia in every room she haunts and then return her doll", "list": Claudia, "type": "missable", "id": 490702 },
]

for c in ClaudiaCheevos {
    AchievementInteractionFunction(c,"claudia")
}



function AchievementInteractionMgr(cheev) {

  if dictionary_contains_key(cheev,"postconditions") {
     if dictionary_contains_key(cheev,"preconditions") {
        AchievementInteractionFunction(cheev,"both")
     } else {
        AchievementInteractionFunction(cheev,"post")
     }
  } else if dictionary_contains_key(cheev,"preconditions") {
      AchievementInteractionFunction(cheev,"pre")
  } else {
      AchievementInteractionFunction(cheev,"none")
  }
}





InteractionCheevos = [
{"title": "Art Aficianado", "points": MediumChallenge, "description": "In one session, inspect every piece of framed art on the Orpheus", "list": Artwork, "type": "missable"},
{"title": "A Grave Opening", "points": EasyChallenge, "description": "Look at the clues and then open the crypt", "list": GraveClues, "type": "missable", 
   "postconditions": SolvedCryptPuzzle() > prev(SolvedCryptPuzzle()) && never(locationid() != CemeteryGraveyard) },

]

for c in InteractionCheevos {
    AchievementInteractionMgr(c)
}


// view all 4 medals up close before placing them properly where they need to go
// these are the item id's from the inventory
SailorMedalA=9
SailorMedalB=10
SailorMedalC=11
SailorMedalD=12
Medals = [SailorMedalA,SailorMedalB,SailorMedalC,SailorMedalD]

achievement(
    title = "A Clear Picture of the Solution", points = EasyChallenge, type="missable",
    description = "While in the reading room, view the clues and then solve the flag puzzle",
    trigger = GameRunning() &&
              measured(tally_of(
                Medals, length(Medals), 
                   (m) => once(ScreenOpen() == 1 && itemIsBeingInteractedWith() == 1 && byte(inventorySlotHighlighted() * 8 + PlayerInventoryArrayStartAddr) == m)
                )
              ) && FlagPuzzleSolved() > prev(FlagPuzzleSolved()) && never(locationid() != ReadingRoom)
)

// Library

achievement(
    title = "This Is a Stealth Game?", points = Minor, type="missable",
    description = "Retrieve the book without getting caught by the receptionist",
    trigger = GameRunning() && locationid() == Library &&
              disable_when(
                  bit2(locationBitflags(Library,1)) == 1, until=locationid() != Library
              ) && trigger_when(bit7(locationBitflags(Library,0)) > prev(bit7(locationBitflags(Library,0))))
)

// Mess hall

function TalkedToFather() => bit1(locationBitflags(MessRoom,0))


achievement(
    title = "Between a King and a Hard Place", points = EasyChallenge,
    description = "Escape the mess room without being hit by the king",
    trigger = GameRunning() &&
              once(locationid() == MessRoom && prev(locationid() == DiningRoomGalley)) &&
              trigger_when(TalkedToFather() > prev(TalkedToFather())) &&
              never(TakenDamage()) && never(locationid() != MessRoom)
)


// use slowest walking speed and escape the cemetery without being hit
// reset on being in terracelazarette (indicates player has left cemetery)
// reset on being in basement (indicates player has died)
WalkingSpeed = byte(0x1a6b5d)
function CryptGateOpen() => bit1(locationBitflags(CemeteryCryptB,0))

achievement(
    title = "Dodged a Dead End", points = MediumChallenge, type = "missable",
    description = "With walking speed setting set to slower, retrieve the fish plate and escape the cemetery without being damaged",
    trigger = GameRunning() &&
              once(locationid() == CemeteryCryptB  && CryptGateOpen() > prev(CryptGateOpen())) &&
              FlyingFishPlateInLastSlot() == 0 &&
              trigger_when(EscapedCemetery() > prev(EscapedCemetery())) &&
              never(TakenDamage()) && never(locationid() == TerraceLazarette) && never(WalkingSpeed != 0) &&
              never(locationid() == Basement) && never(GameLoaded())             
)

// Observatory 
/*
achievement(
    title = "An Astral Exchange", points = Minor,
    description = "Give an astral piece to the medium",
    id = 490706, 
    trigger = locationid() == ObservatoryB && saveAndLoadStatus() == 0 &&
              bit1(locationBitflags(ObservatoryB,0)) > prev(bit1(locationBitflags(ObservatoryB,0)))
)


achievement(
    title = "An Ear for Music", points = MediumChallenge,
    description = "solve the organ without making a mistake ",
    trigger = once((playerPuzzleStatus() == 1 || playerPuzzleStatus() == 0) && playerstanding() == 1 &&
                  locationid() == 41 && locationid() != prev(locationid())
              ) && (locationid() == prev(locationid()) && bit5(locationid() * 32 + 0x1BCE59) == 1) &&
              trigger_when(bit0(locationid() * 32 + 0x1BCE59) > prev(bit0(locationid() * 32 + 0x1BCE59))) &&
              never(locationid() != 41) && never(bit1(locationid() * 32 + 0x1BCE59) == 1)
)
*/

// Casino Achievements

// You Don't have to go home but you can't stay here
// Stay in the casino past 2am

CasinoBoss          = 0xf0
CasinoBossKickOut1  = 0x80190ea4  // "Sir..."
CasinoBossKickOut2  = 0x80190fd4  // "I'm sorry but we are closed for the day"
CasinoBossKickOut3  = 0x80190ff4  // transitioned to black screen
CasinoBossKickedOut = 0x80191020  // transitioning to hallway

achievement(
    title = "You Don’t Have To Go Home but You Can’t Stay Here", points = Minor, type = "missable",
    description = "Overstay your welcome and get kicked out of the casino",
    trigger = GameRunning() && never(locationid() != Casino) &&
              any_of(range(0,slotsToCheck-1), (id) => 
                ConfigSlotInteractionID(id) == CasinoBoss &&
                once(ConfigSlotDataPTR(id) == CasinoBossKickOut1) &&
                once(ConfigSlotDataPTR(id) == CasinoBossKickOut2) &&
                once(ConfigSlotDataPTR(id) == CasinoBossKickOut3) &&
                once(ConfigSlotDataPTR(id) == CasinoBossKickedOut)
              )
)

function JukeBoxUnlocked() => bit2(locationBitflags(Casino,2))

achievement(
    title = "Play That Funky Music", points = EasyChallenge, type="missable",
    description = "After getting all 26 astral pieces, play some music on the jukebox",
    trigger = GameRunning() && locationid() == Casino && JukeBoxUnlocked() > prev(JukeBoxUnlocked())
)

function ptrToCasinoPayout() => tbyte(0x09FA30)

PlayingSlots    = 0xc9
SlotWin         = 0x200
SlotJackpot     = 0x20a

achievement(
    title = "Slot Success", points = EasyChallenge,
    description = "Win at slots",
    trigger = GameRunning() && locationid() == Casino && CodeFlow() == PlayingSlots &&
              ((word(ptrToCasinoPayout()) == SlotWin) || (word(ptrToCasinoPayout()) == SlotJackpot))
)

// $1D2A50: [16-bit] roulette game status
function rouletteStatus() => word(0x1D2A50)

// $1D2A52: [16-bit] roulette chips bet
function rouletteChipsBet() => word(0x1D2A52)

PlayingRoulette     = 0xc8
RouletteOuterSpin   = 0x101
RouletteInnerSpin   = 0x201
RoulettePayout      = 0x202

// This cheevo adds 65535 (to prevent overflow), subtracts chips bet from chips won, and makes sure that value is greater than 2
// This prevents a user from just betting for example 9 odd, 9 even and technically winning even though you win 0 actual chips

achievement(
    title = "Wheel of Fortune", points = MinorChallenge,
    description = "Win at least 3 more chips than you bet while playing a single round of roulette",
    id = 492103,
    trigger = GameRunning() && locationid() == Casino && CodeFlow() == PlayingRoulette && rouletteStatus() == RoulettePayout &&
              prev(rouletteStatus()) == RouletteInnerSpin && (word(tbyte(0x09FA2C) + 0x000048) - rouletteChipsBet()) > 2
)


PlayingBlackjack   = 0xca


// Theater

// triggered by ringing the bell in the theater entrance
// if you turn the film into him before doing this it is missed
// trigger appears when he is still around, and you are in the right area
// the first time you enter the theater the "in the front room" bit is not set
TheaterEngineer = 0x69
MovieTheater1   = 0x8018fca4 // "I'm sorry.. the film is already over"
MovieTheater2   = 0x8018fd64 // "After this.. Well.. It's been reserved"
MovieTheater3   = 0x8018fe40 // "Please come again some other time"
MovieTheater4   = 0x8018ff10 // "I'm sorry.. so terribly sorry"


achievement(
    title = "This Theater Has Terrible Service", points = Trivial, type="missable",
    description = "Attempt to see a film",
    id = 486665, 
    trigger = GameRunning() && never(locationid() != Theater) && filmEngineerGone() == 0 && 
              // the first time you enter the theater the "In theater entrance" bit is not set for some reason
              // so this ornext covers both cases where you are in the front room
              __ornext(playerInTheaterEntrance() == 1 || (playerInTheater() == 0 && playerInTheaterBackRoom() == 0  && playerInFilmBooth() == 0)) &&
              once(currentInteractionID() == TheaterEngineer && currentFunctionID() == None && currentDataPTR() == MovieTheater1) &&
              once(currentInteractionID() == TheaterEngineer && currentFunctionID() == None && currentDataPTR() == MovieTheater2) &&
              once(currentInteractionID() == TheaterEngineer && currentFunctionID() == None && currentDataPTR() == MovieTheater3) &&
              once(currentInteractionID() == TheaterEngineer && currentFunctionID() == None && currentDataPTR() == MovieTheater4 && prev(currentDataPTR() != MovieTheater4))
)

// Pier



// Amusement Park

// Shine on you crazy diamond

// During the optional quest via John Cutter on upr deck passageway
// ride the carousel before picking up the engagement ring
// horse values are for when the ride stops for a better cheevo experience
// remove 0x0100 if you want when you are on top of the horse

CarouselLightBrownHorse = 0x1000179
CarouselGrayHorse       = 0x100017a
CarouselBrownHorse      = 0x100017b
CarouselWhiteHorse      = 0x100017c
CarouselChocolateHorse  = 0x100017d

HORSES = [
    CarouselLightBrownHorse,
    CarouselGrayHorse,
    CarouselBrownHorse,
    CarouselWhiteHorse,
    CarouselChocolateHorse,
]

achievement(
    title = "Shine On You Crazy Diamond", points = Trivial, type = "missable",
    description = "Ride the carousel before locating the missing item.",
    trigger = GameRunning() && locationid() == AmusementParkCarousel && IsSpawnedAmusementParkEngagementRing() == 1 &&
              currentConfigSlotAddr() == prev(currentConfigSlotAddr()) &&
              any_of(HORSES, (h) => currentInteractionID() == h && prev(currentInteractionID() != h))
)





// ratings

Esper                    = 0x10a
Genius                   = 0xc1
Superior                 = 0x9d
ptrResultsRating         = 0x8009f797
ptrResultsTotalPlaytime  = 0x80012145

function resultsOnScreen()    => byte(0x1DE614) == 144 && byte(0x1DE615) == 144 && byte(0x1DE616) == 144
function resultsNotOnScreen() => prev(byte(0x1DE614) != 144) && prev(byte(0x1DE615) != 144) && prev(byte(0x1DE616) != 144)
function ptrResultsDisplay()  => dword(0x1ffe8c)
function ResultsRating()      => dword(0x1ffe90)

achievement(
    title = "ESPer", points = HardChallenge,
    description = "Beat the game with an ESPer rating",
    trigger = resultsOnScreen() && ptrResultsDisplay() == ptrResultsRating && 
              ResultsRating() == Esper && prev(ResultsRating()) != Esper
)

achievement(
    title = "Genius", points = MediumChallenge,
    description = "Beat the game with a Genius or higher rating",
    trigger = resultsOnScreen() && ptrResultsDisplay() == ptrResultsRating && 
              (ResultsRating() == Esper && prev(ResultsRating()) != Esper) || 
              (ResultsRating() == Genius && prev(ResultsRating()) != Genius)
)
achievement(
    title = "Superior", points = EasyChallenge,
    description = "Beat the game with a Superior or higher rating",
    trigger = resultsOnScreen() && ptrResultsDisplay() == ptrResultsRating &&  
              (ResultsRating() == Esper && prev(ResultsRating()) != Esper) || 
              (ResultsRating() == Genius && prev(ResultsRating()) != Genius) ||
              (ResultsRating() == Superior && prev(ResultsRating()) != Superior)
)


//ENDINGS

// There is a cutscene attached with the death scene, so worth an acheviement, but 0 points.
achievement(
    title = "Conclusion: A Dank Destination", points = 0,
    description = "Get a game over",
    id = 473928,  
    trigger = GameRunning() && once(playerCondition() == 0) && (CodeFlow() == 57 && gameOver() == 1 && prev(gameOver() != 1)) &&
              never(locationid() != 57)
)

// similar to the game over scene, there is a unique ending for failing to escape, also 0 points
achievement(
    title = "Conclusion: Lost at Sea", points = 0,
    description = "Fail to escape the Orpheus before time runs out",
    id = 473924, 
    trigger = GameRunning() && (CodeFlow() == 0xd4 && resultsOnScreen() && resultsNotOnScreen())
)

// Best ending
achievement(
    title = "Conclusion: Soul Savior", points = MediumChallenge, type="win_condition",
    description = "Acquire all 26 astral pieces and refuse the offer",
    id = 473925,  
    trigger = GameRunning() && once(CodeFlow() == 74) && CodeFlow() == 210 &&
              prev(CodeFlow()) == 220 && never(locationid() == 0)
)

// evil ending
achievement(
    title = "Conclusion: Soulless", points = MediumChallenge, type="win_condition",
    description = "Acquire all 26 astral pieces and accept the offer",
    id = 473926,   
    trigger = GameRunning() && once(CodeFlow() == 211) &&
              (locationid() == 55 && bit2(locationid() * 2 + 0x1A4A68) > prev(bit2(locationid() * 2 + 0x1A4A68))) &&
              never(locationid() == 0)
)

// mysterious ending where the knife shows up in the trunk of the car, uhoh. 
achievement(
    title = "Conclusion: A Sticking Point", points = EasyChallenge, type="win_condition",
    description = "Complete the game imperfectly",
    id = 473927, 
    trigger = GameRunning() && once(prev(CodeFlow()) == 74 && CodeFlow() == 211) &&
              (locationid() == 87 && bit0(locationid() * 2 + 0x1A4A68) > prev(bit0(locationid() * 2 + 0x1A4A68))) &&
              never(locationid() == 0)
)

// rich presence

function numSaves()     => dword(0x1a6ca0)


rich_presence_conditional_display(gameOver() == 1, "☠️-[ Game Over 👣:{1} 🕰️ {0} 💾:{2} ]-☠️", 
    rich_presence_value("Seconds", totalTime(), format="SECS"),
    rich_presence_value("Number", pedometer()),
    rich_presence_value("Number", numSaves())
)

function Intelligence() => word(0x1ffea0)
function Physical()     => word(0x1ffea2)
function Secrets()      => word(0x1ffea4)

RatingLookup = {
    0x2f:  "Donkey",
    0xe6:  "Average",
    0x9d:  "Superior",
    0xc1:  "Genius",
    0x10a: "ESPer",
}

rich_presence_conditional_display(resultsOnScreen() && ptrResultsDisplay() == ptrResultsTotalPlaytime, "Richard's Results I:{0} P:{1} S:{2} R:{3}", 
    rich_presence_value("Number", Intelligence()),
    rich_presence_value("Number", Physical()),
    rich_presence_value("Number", Secrets()),
    rich_presence_lookup("Rating", prior(ResultsRating()), RatingLookup)
)

rich_presence_conditional_display(resultsOnScreen() && ptrResultsDisplay() == ptrResultsRating, "Richard's Results I:{0} P:{1} S:{2} R:{3}", 
    rich_presence_value("Number", Intelligence()),
    rich_presence_value("Number", Physical()),
    rich_presence_value("Number", Secrets()),
    rich_presence_lookup("Rating", ResultsRating(), RatingLookup)
)



SpecialLookup = {
    0xc8: "🔴 or ⚫?: Richard is playing Roulette ",
    0xc9: "🎰: Richard is playing Slots",
    0xca: "🃁: Richard is playing Blackjack",
    0xcd: "Richard is in the Theater",
    0xd2: "Roll Credits",
    0xd3: "Richard achieved an ending",
    0xdc: "Richard achieved the best ending",
    0xd4: "Richard was too slow and failed to escape",
}


rich_presence_conditional_display((CodeFlow() == 0xc8 || CodeFlow() == 0xc9 || CodeFlow() == 0xca), "🤑-[ {0} 🥮:{1} ]-🤑",
    rich_presence_lookup("Special", CodeFlow(), SpecialLookup),
    rich_presence_value("Number", casinoGameChips())
)

rich_presence_conditional_display((CodeFlow() == 0xdc || CodeFlow() == 0xd2 || CodeFlow() == 0xd3 || CodeFlow() == 0xcd ||
        CodeFlow() == 0xd4
    ), "🎬-[ {0} {1} ]-🎬",
    rich_presence_lookup("Special", CodeFlow(), SpecialLookup),
    rich_presence_lookup("VideoFile", filenamePointerForCdRomVideoPlaying(), VideoFileLookup)
)

rich_presence_conditional_display(playerPuzzleStatus() == 1 && possessed() != 0, "👻-[ POSSESSED Exploring 👻👻👻👻👻 🌎:👻👻👻👻 🩹:👻 👣:👻 🕰️ 👻👻👻👻 💾:👻 ]-👻")

PuzzleLookup = {
    0x09: "Trying to Repair the Fusebox",
    0x1b: "Tinkering with a Crow",
    0x1f: "Playing music on the Jukebox",
    0x20: "Messing with the Radio Telegraph",
    0x25: "Trying to Open the Engine Room Door",
    0x2c: "Tinkering with a Parrot",
    0x28: "Working out the proper clock symbol",
    0x29: "Working out the key to the Organ",
    0x34: "Messing with the Crewman's Alarm",
    0x37: "Trying to Wind the Clock",
    0x3d: "Picking a Floor in the Observatory Elevator",
    0x41: "Locking the Pistons in Engine Room B",
    0x42: "Locking the Pistons in Engine Room A",
    0x44: "Looking at the Orpheus security information",
    0x46: "Turning the Engine Valves",
}

rich_presence_conditional_display(playerPuzzleStatus() == 0 && playerstanding() == 1, "🧩-[ Richard is {0} 🌎:{1} 🩹:{2} 🕰️ {3} 👣:{4} ]-🧩",
    rich_presence_lookup("Puzzle", locationid(), PuzzleLookup),
    rich_presence_lookup("Weather", weather(), WeatherLookup),
    rich_presence_lookup("PlayerCondition", playerCondition(), PlayerConditionLookup),
    rich_presence_value("Seconds", totalTime(), format="SECS"),
    rich_presence_value("Number", pedometer())
)


rich_presence_conditional_display((endGameCountdownTimer() > 0 && playerPuzzleStatus() == 1 && locationid() != 74), "🚨-[ Richard is trying to Escape the Orpheus 🕙 {0} ⏱️: {1} ]-🚨",
    rich_presence_value("Minutes", byte(0x1A6B30) + low4(0x1A6B31) * 90.001406271973, format="MINUTES"),
    rich_presence_value("Number", endGameCountdownTimer())
)


TimeLocationLookup = {
    0x14: "📅:4/10/1913",
    0x16: "📅:11/26/1469",
    0x17: "📅:11/26/1469",
    0x18: "📅:3/16/1912",
    0x21: "📅:4/12/1899",
    0x29: "📅:12/10/1912",
    0x2b: "📅:12/29/1910",
    0x36: "📅:10/6/1935",
    0x37: "📅:11/15/1937",
    0x38: "📅:11/15/1937",
    0x39: "📅:11/15/1937",
    0x3a: "📅:7/27/1910",
    0x3b: "📅:7/27/1910",
    0x3c: "📅:7/27/1910",
    0x3d: "📅:11/15/1937",
    0x3e: "📅:11/15/1937",
    0x3f: "📅:12/29/1910",
    0x40: "📅:12/29/1910",
    0x47: "📅:12/10/1912",
    0x49: "📅:12/10/1912",
    0x4b: "📅:4/11/1913",
    0x4c: "📅:4/11/1913",
    0x4d: "📅:11/26/1469",
    0x4f: "📅:2/9/1913",
    0x50: "📅:11/26/1469",
    0x51: "",
    0x52: "📽️: Flyby of The House",
    0x53: "📅:12/10/1912",
    0x54: "📅:4/12/1899",
    0x55: "📅:4/12/1899",
    0x56: "📅:11/15/1937",
    0x57: "",
    0x58: "📅:10/6/1935",
    0x59: "📅:7/27/1910",
    0x5a: "📅:3/16/1912",
    0x5b: "📅:11/15/1937",
    0x5c: "",
    0x5d: "📅:2/9/1913",
}


rich_presence_conditional_display(word(locationid() * 36 + 0x082EC4) >= 10 && dword(0x09FB10) == 1 && dword(0x1A6B30) > word(0x0000FF), "🔎-[ {0} {1} 🌎:{2} 🩹:{3} 👣:{4} 🕰️ {5} 💾:{6} ]-🔎",
    rich_presence_lookup("Location", locationid(), LocationLookup),
    rich_presence_lookup("TimeLocation", locationid(), TimeLocationLookup),
    rich_presence_lookup("Weather", weather(), WeatherLookup),
    rich_presence_lookup("PlayerCondition", playerCondition(), PlayerConditionLookup),
    rich_presence_value("Number", pedometer()),
    rich_presence_value("Seconds", totalTime(), format="SECS"),
    rich_presence_value("Number", numSaves())
)

rich_presence_conditional_display(dword(0x09FB10) == 1 && dword(0x1A6B30) > word(0x0000FF), "🔎-[ {0} 🕙 {1} 🌎:{2} 🩹:{3} 👣:{4} 🕰️ {5} 💾:{6} ]-🔎",
    rich_presence_lookup("Location", locationid(), LocationLookup),
    rich_presence_value("Minutes", byte(0x1A6B30) / 2.84444 + low4(0x1A6B31) * 90.0014, format="MINUTES"),
    rich_presence_lookup("Weather", weather(), WeatherLookup),
    rich_presence_lookup("PlayerCondition", playerCondition(), PlayerConditionLookup),
    rich_presence_value("Number", pedometer()),
    rich_presence_value("Seconds", totalTime(), format="SECS"),
    rich_presence_value("Number", numSaves())
)

rich_presence_conditional_display(word(locationid() * 36 + 0x082EC4) >= 10 && dword(0x09FB10) == 1, "🔎-[ {0} {1} 🌎:{2} 🩹:{3} 👣:{4} 🕰️ {5} 💾:{6} ]-🔎",
    rich_presence_lookup("Location", locationid(), LocationLookup),
    rich_presence_lookup("TimeLocation", locationid(), TimeLocationLookup),
    rich_presence_lookup("Weather", weather(), WeatherLookup),
    rich_presence_lookup("PlayerCondition", playerCondition(), PlayerConditionLookup),
    rich_presence_value("Number", pedometer()),
    rich_presence_value("Seconds", totalTime(), format="SECS"),
    rich_presence_value("Number", numSaves())
)

rich_presence_conditional_display(dword(0x09FB10) == 1, "🔎-[ {0} 🕙 {1} 🌎:{2} 🩹:{3} 👣:{4} 🕰️ {5} 💾:{6} ]-🔎",
    rich_presence_lookup("Location", locationid(), LocationLookup),
    rich_presence_value("Minutes", dword(0x1A6B30) / 2.84444, format="MINUTES"),
    rich_presence_lookup("Weather", weather(), WeatherLookup),
    rich_presence_lookup("PlayerCondition", playerCondition(), PlayerConditionLookup),
    rich_presence_value("Number", pedometer()),
    rich_presence_value("Seconds", totalTime(), format="SECS"),
    rich_presence_value("Number", numSaves())
)

rich_presence_conditional_display(gametime() == 0 && playerPuzzleStatus() == 0, "🤔-[ Richard is Mentally Preparing to Play Echo Night {0} ]-🤔",
    rich_presence_lookup("VideoFile", filenamePointerForCdRomVideoPlaying(), VideoFileLookup)
)

rich_presence_display("This should never be seen")




leaderboard(
    title="Blackjack Win Streak",
    description="Win as many consecutive hands of blackjack that you can.",
    id=124793,
    start=CodeFlow() == PlayingBlackjack && 
              tally(2, (byte(0x0A3A68) == 2 && prev(byte(0x0A3A68)) != 2 && byte(0x0A3BBD) > byte(0x0A3BBE))) &&
              never(prev(byte(0x09FA21)) < byte(0x09FA21)),
    cancel=locationid() != Casino,
    submit=__ornext((byte(0x0A3A68) == 2 && byte(0x09FA21) == 1 && prev(byte(0x09FA21)) == 0) || CodeFlow() != PlayingBlackjack),
    value=measured(tally(0, once(always_true()),
                 (byte(0x0A3A68) == 2 && prev(byte(0x0A3A68)) != 2 && byte(0x0A3BBD) > byte(0x0A3BBE)), always_false())
             ),
    format="VALUE",
    lower_is_better=false
    
)











