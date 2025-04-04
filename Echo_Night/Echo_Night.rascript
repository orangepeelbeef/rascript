// #MinimumVersion = 1.3
// Echo Night
// #ID = 6130

// set up a ptr helper function
function ptr(addr) => dword(addr) & 0x1FFFFFFF

// Config Slots
function currentConfigSlotAddr()    => dword(0x09FA8C)
function currentConfigSlot()        => ptr(0x09FA8c)
//function currentInteractionID()     => dword(currentConfigSlot())
//function currentInteractionIDByte() => byte(currentConfigSlot())
//function currentDataPTR()           => dword(currentConfigSlot() + 4)
//function currentDataValue()         => dword(ptr(currentConfigSlot() + 4))
//function currentDataValue2()        => dword(ptr(currentConfigSlot() + 8))
//function currentFunctionID()        => dword(currentConfigSlot() + 0x10)


function curSlot() {
    obj = {
        // normal 32 bit read of the interaction id
        "id": dword(currentConfigSlot()),
        // 8 bit read of the interaction id, ghosts and other objects sometimes use the higher order bits to animate or track states, and in these cases we only look at the first 8 bits
        "id_byte": byte(currentConfigSlot()),
        // pointer to data related to the interacting object, used mainly for tooltip/dialogue id's    maps to beginning of a custom encoding ascii block
        "data_ptr": dword(currentConfigSlot() + 4),
        // the data value inside the pointer
        "data_value": dword(ptr(currentConfigSlot() + 4)),
        // pointer to second data ptr related to interacting object,  used to detect ghost animated state
        "data2_ptr": dword(currentConfigSlot() +8),
        // data value inside of data2 ptr  used to detect ghost animated state
        "data2_value": dword(ptr(currentConfigSlot() + 8)),
        // id of the function currently active (dialogue/tooltip, etc)
        "func_id": dword(currentConfigSlot() + 0x10)
    }
    return obj
}

g_current_config_slot = curSlot()



function GameContinuedState() => dword(0x09F7F0)

// Indicates that a game was continued from save
function GameContinued() {
   return (GameContinuedState == 2 && prev(GameContinuedState()) != 2)
}

// After a gameover, memory is not wiped, but gameResetLoop will be > 0
function gameResetLoop() => dword(0x09F890)

function GameRunning() {
    return GameContinuedState() > 0 && saveAndLoadStatus() == 0 && prev(saveAndLoadStatus() == 0) && gameResetLoop() == 0
}

function gameOver() => dword(0x09F8D8)
function GameOver() {
    return (gameOver() == 1)
}

function endGameCountdownTimer() => dword(0x09F8F0)
function gameState()             => dword(0x09F8F8)
function LocationID()            => dword(0x09F908)

function EnteredRoom(location, via) {
    if via != 0 {
        return once(LocationID() == location && prev(LocationID() == via))
    } else {
        return once(LocationID() == location && prev(LocationID() != location))
    }
}

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
    0x57: "📽️: Watching the Gray Ending",
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
GrayEndingHouse         = 0x57
PastHouseOutside        = 0x5d

function playerPuzzleStatus()                  => dword(0x09FB10)
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

function astralPiecesTurnedIn() => byte(0x0A0C6E)
function casinoGameChips()      => dword(0x0A0CB0)

function playerstanding()       => dword(0x1A3DB4)


LocationEntityflagsAddr = 0x1A4248
function locationEntityflagBit(location, index) => bit0(LocationEntityflagsAddr + index + (location * 8))

BasementLightSwitchOn                           = locationEntityflagBit(Basement,0)
UprDeckPassagewayInsideLightOn                  = locationEntityflagBit(UprDeckPassagewayInside,0)
UprDeckCompartmentLightOn                       = locationEntityflagBit(UprDeckCompartment,0)
PilothouseLightOn                               = locationEntityflagBit(Pilothouse,0)
visitedUprDeckPilothouse                        = locationEntityflagBit(Pilothouse,1)

// index should be either 0 or 1 as this is a 2 byte area
LocationSpawnflagsAddr = 0x1A4A68
function locationSpawnflags(location, index)    => LocationSpawnflagsAddr + index + (location * 2)
// unused function, preferable to use the derived static memory locations
function currentLocationSpawnflags(index)       => locationSpawnflags(LocationID(), index)


function IsSpawnedUprDeckPilothouseCurePotionInCabinet()    => bit3(locationSpawnflags(Pilothouse,0))
function IsSpawnedUprDeckPilothouseCurePotionInCabinet2()   => bit4(locationSpawnflags(Pilothouse,0))
function IsSpawnedJohnCutterAstral()                        => bit1(locationSpawnflags(UprDeckPassageway,0))
function IsSpawnedBillyBollardAstral()                      => bit0(locationSpawnflags(ChartRoom,0))
function IsSpawnedCaptainsCabinCurePotionInDrawer()         => bit1(locationSpawnflags(CaptainsCabin,0))
function IsSpawnedWireCutter()                              => bit0(locationSpawnflags(UprDeckCompartment,0))
function IsSpawnedEdMooringAstral()                         => bit6(locationSpawnflags(ReadingRoom,0))
function IsSpawnedFloor1LoungeClaimTicketFarLeftUnderBar()  => bit0(locationSpawnflags(Lounge,0))
function IsSpawnedFloor1GrandDiningClaimTicket()            => bit1(locationSpawnflags(GrandDining,0))
function IsSpawnedCup()                                     => bit0(locationSpawnflags(GuestHallway,0))
function IsSpawnedRobbAstral()                              => bit2(locationSpawnflags(GuestHallway,0))
function IsSpawnedStewardAstral()                           => bit1(locationSpawnflags(DiningHallway,0))
function IsSpawnedGuestRoomCCuringPotionInDrawer()          => bit1(locationSpawnflags(GuestRoomC,0))
function IsSpawnedFianaAstral()                             => bit2(locationSpawnflags(GuestRoomC,0))
function IsSpawnedGuestRoomDCuringPotionInDrawer()          => bit1(locationSpawnflags(GuestRoomD,0))
function IsSpawnedDianaAstral()                             => bit2(locationSpawnflags(GuestRoomD,0))
function IsSpawnedSpecialGuestRoomClaimTicket()             => bit1(locationSpawnflags(SpecialGuestRoom,0))
function IsSpawnedClaudiasDoll()                            => bit2(locationSpawnflags(SpecialGuestRoom,0))
function IsSpawnedFloor2MedicalOfficeCuringPotionDrawer()   => bit0(locationSpawnflags(MedicalOffice,0))
function IsSpawnedFloor2MedicalOfficeCuringPotionCabinet()  => bit1(locationSpawnflags(MedicalOffice,0))
function IsSpawnedPrescription()                            => bit0(locationSpawnflags(Laboratory,0))
function IsSpawnedFloor2TheaterClaimTicket()                => bit4(locationSpawnflags(Theater,0))
function IsSpawnedThomasGussetAstral()                      => bit2(locationSpawnflags(Theater,0))
function IsGearInCrow()                                     => bit3(locationSpawnflags(Stairway,0))
function IsSpawnedFloor2EngineersRoomCuringPotion()         => bit1(locationSpawnflags(EngineersRoom,0))
function IsSpawnedLwrDeckPoolClaimTicketInStarboardLocker() => bit1(locationSpawnflags(Pool,0))
function IsSpawnedLwrDeckPoolRoomCuringPotionInPortLocker() => bit2(locationSpawnflags(Pool,0))
function IsSpawnedFloor2CasinoClaimTicket()                 => bit0(locationSpawnflags(Casino,0))
function IsSpawnedFloor2ShowerRoomCuringPotionInLocker()    => bit0(locationSpawnflags(ShowerRoom,0))
function IsSpawnedFloor2BathroomClaimTicketInLastStall()    => bit0(locationSpawnflags(Bathroom,0))
function IsSpawnedEmllieScuttleAstral()                     => bit0(locationSpawnflags(TerraceLazarette,0))
function IsSpawnedFloor1WaterRoomCuringPotion()             => bit1(locationSpawnflags(WaterRoom,0))
function IsSpawnedClockKey()                                => bit0(locationSpawnflags(WaterRoom,0))
function PouringAntidote()                                  => bit0(locationSpawnflags(TheaterHallway,0))
function IsSpawnedFloor1FireRoomClaimTicketOnLargeBed()     => bit1(locationSpawnflags(FireRoom,0))
function IsSpawnedSailorsDocument()                         => bit0(locationSpawnflags(CrewsQuartersB,0))
function IsSpawnedOscarRockwellAstral()                     => bit2(locationSpawnflags(RadioRoom,0))
function IsSpawnedBloodyKnife()                             => bit2(locationSpawnflags(House,0))
function IsSpawnedClaudiasDoll()                            => bit0(locationSpawnflags(AbandonedMineC,0))
function FlyingFishPlateInLastSlot()                        => bit0(locationSpawnflags(CemeteryCryptA,0))
function IsSpawnedBoilerACuringPotion()                     => bit1(locationSpawnflags(BoilerA,0))
function IsSpawnedAmusementParkEngagementRing()             => bit0(locationSpawnflags(AmusementParkCarousel,0))
function IsSpawnedKnifeInTrunk()                            => bit0(locationSpawnflags(GrayEndingHouse,0))

function gametime()          => dword(0x1A6B30)
function gametimebyte()      => byte(0x1A6B30)
function totalTime()         => dword(0x1A6B48)
function pedometer()         => dword(0x1A6B4C)
function playerCondition()   => word(0x1A6B50)

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

function weather()           => byte(0x1A6B55)

WeatherLookup = {
    0x00: "☀️",
    0x01: "⛅",
    0x02: "☔",
    0x03: "❄️",
}

function shipMap()           => byte(0x1A6B56)
function leatherOrganizer()  => byte(0x1A6B57)

MapCompletionAddr = 0x1A6C78
function mapCompletionArrayByte(index) => MapCompletionAddr + index
function locationMapBit(location)
{
    if location == 0 {
        return visitedUprDeckPilothouse
    } else {
        MapByteOffset = (location / 8)
        MapRemainder = location & 7
        return bit(MapRemainder,mapCompletionArrayByte(MapByteOffset))
    }
}


function secretsRatingPart1() => dword(0x1A6C8C)
function intelligenceRating() => dword(0x1A6C90)
function physicalRating()     => dword(0x1A6C94)
function ratingarray3()       => dword(0x1A6C98)
function secretsRatingPart2() => dword(0x1A6C9C)

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
function currentLocationBitflags(index) => locationBitflags(LocationID(), index)

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
function SolvedCryptPuzzle()         => bit3(locationBitflags(CemeteryGraveyard,0))
function EscapedCemetery()           => bit2(locationBitflags(CemeteryCryptA,1))
function LadySpiritFreed()           => bit2(locationBitflags(TerraceLazarette,1))
function PoolPumpStarted()           => bit0(locationBitflags(TerraceLazarette,1))
function OpenedLockerFour()          => bit1(locationBitflags(CrewsQuartersA,0))
function KitchenDoorUnlocked()       => bit2(locationBitflags(GrandDining,0))
function TalkedToFatherMessRoom()    => bit1(locationBitflags(MessRoom,0))
function CompletedPastHouseOutside() => bit0(locationBitflags(PastHouseOutside,0))
function PrescriptionDelivered()     => bit1(locationBitflags(MedicalOffice,0))
function FlagPuzzleSolved()          => bit3(locationBitflags(ReadingRoom,0))
function UnlockedStairwayDoor()      => bit0(locationBitflags(Stairway,2))
function KingGivenCameo()            => bit0(locationBitflags(PrivateQuarters,0))
function HaveCameo()                 => bit4(locationBitflags(PrivateQuarters,0))
function OrganSolved()               => bit0(locationBitflags(Cathedral,1))
function AstralPieceExchanged()      => bit1(locationBitflags(ObservatoryB,0))
function EngineRoomUnlocked()        => bit0(locationBitflags(PortCorridor,0))
function OldBookPickedUp()           => bit7(locationBitflags(Library,0))
function SpottedBySecretary()        => bit2(locationBitflags(Library,1))
function JukeBoxUnlocked()           => bit2(locationBitflags(Casino,2))


function CodeFlow() => dword(0x1BC660)

PlayerInventoryArrayStartAddr = 0x1bebc8

// $1D8D10 Config slot Array
ConfigSlotAddr = 0x1D8D10
function ConfigSlotInteractionID(index)     => dword(ConfigSlotAddr + (index * 0x718))
function ConfigSlotInteractionIDbyte(index) => byte(ConfigSlotAddr + (index * 0x718))
function ConfigSlotFunctionID(index)        => dword(ConfigSlotAddr + 0x10 + (index * 0x718))
function ConfigSlotDataPTR(index)           => dword(ConfigSlotAddr + 4 + (index * 0x718))


// Function IDs
None                      = 0
Opening                   = 0x12
Closing                   = 0xb
ReadingText               = 0x17


function ScreenOpen()                 => byte(0x1DD6F8)
function saveAndLoadStatus()          => word(0x1DD6FA)

function GameLoaded() {
    return ScreenOpen() == 4 && saveAndLoadStatus() == 2
}
function GameSaved() {
    return ScreenOpen() == 3 && saveAndLoadStatus() == 2
}

function inventorySlotHighlighted()  => byte(0x1DD6FC)
function itemIsBeingInteractedWith() => byte(0x1DD6FE)
function itemNotePage()              => byte(0x1DD704)





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


Painting     = 0x103
PaintingClue = 0x8018deec


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
        trigger = GameRunning() && LocationID() == cheev["location"] && cheev["completionbit"] > prev(cheev["completionbit"])
      )
    } else if cheev["kind"] == "genericrev" {
      achievement(
        title = cheev["title"], description = cheev["description"], points = cheev["points"], type=cheev["type"], id=id_or_zero(cheev),
        trigger = GameRunning() && LocationID() == cheev["location"] && cheev["completionbit"] < prev(cheev["completionbit"])
      )
      
    } else if cheev["kind"] == "genericpuzzle" {
      achievement(
        title = cheev["title"], description = cheev["description"], points = cheev["points"], type=cheev["type"], id=id_or_zero(cheev),
        trigger =  playerPuzzleStatus() == 0 && playerstanding() == 1 && LocationID() == cheev["location"] &&
        cheev["completionbit"] > prev(cheev["completionbit"])
      )
    } else if cheev["kind"] == "extraconditions" {
       achievement(
        title = cheev["title"], description = cheev["description"], points = cheev["points"], type=cheev["type"], id=id_or_zero(cheev),
        trigger = GameRunning() && LocationID() == cheev["location"] && cheev["conditions"] 
        && cheev["completionbit"] > prev(cheev["completionbit"])
      )
    } else if cheev["kind"] == "extraconditionstrigger" {
       achievement(
        title = cheev["title"], description = cheev["description"], points = cheev["points"], type=cheev["type"], id=id_or_zero(cheev),
        trigger = GameRunning() && LocationID() == cheev["location"] && cheev["conditions"] 
        && trigger_when(cheev["completionbit"] > prev(cheev["completionbit"]))
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
    
    { "kind": "extraconditionstrigger", "title": "Life Imitates Art", "description": "View the clue then solve the basement puzzle", "location": Basement, "completionbit":  BasementPuzzleSolved(), "points": Minor, "type": "missable",
      "conditions": never(LocationID() != Basement) && once(g_current_config_slot["func_id"] == ReadingText  && g_current_config_slot["id"] == Painting && g_current_config_slot["data_ptr"] == PaintingClue)
    },
    
    { "kind": "generic", "title": "A G..G..G..Ghost!", "description": "Meet a ghostly girl and mysteriously get rescued", "location": UprDeckPassageway, "completionbit": EncounteredClaudia(), "points": Trivial, "type": "progression", "id": 489270},    
    { "kind": "extraconditionstrigger", "title": "Secretary Slither", "description": "Retrieve the book without getting caught by the secretary", "location": Library, "completionbit":  OldBookPickedUp(), "points": EasyChallenge, "type": "missable",
      "conditions": disable_when(SpottedBySecretary() == 1, until=(GameLoaded() || GameOver())), "id": 497948
    },
    { "kind": "generic", "title": "An Investigator Needs His Notebook", "description": "Retrieve the leather organizer", "location": CaptainsCabin, "completionbit":  leatherOrganizer(), "points": Trivial, "type": "missable", "id": 489435},   
    { "kind": "generic", "title": "Navigating the Nightmare", "description": "Retrieve the ship map and start charting your journey", "location": Pilothouse, "completionbit": shipMap(), "points": EasyPuzzle, "type": "missable", "id": 490705},       
    // ring around the sailor   get the ring and give it to john
    { "kind": "generic", "title": "Ring Around the Sailor", "description": "Help John Cutter find peace", "location": UprDeckPassageway, "completionbit": IsSpawnedJohnCutterAstral(), "points": SmallEvent, "type": "missable"},
    // get the wire cutters, wire, rubber gloves(pair on a pier), fix the fusebox, flip the light in chart room
    { "kind": "generic", "title": "Shedding Some Light on Matters", "description": "Help Billy Bollard find peace", "location": ChartRoom, "completionbit": IsSpawnedBillyBollardAstral(), "points": MediumEvent, "type": "progression"},
    //
    { "kind": "generic", "title": "An Astral Exchange", "description": "Give an astral piece to the medium", "location": ObservatoryB, "completionbit": AstralPieceExchanged(), "points": Minor, "type": "missable", "id": 490706 },
    { "kind": "extraconditions", "title": "Equipped for Exchange", "description": "Give an astral piece to the medium on your first visit", "location": ObservatoryB, "completionbit": AstralPieceExchanged(), "points": MinorChallenge, "type": "missable",
        "conditions": never(LocationID() != ObservatoryB) && once(VisitedMedium() > prev(VisitedMedium())), "id": 502220
    },        
    // give robb the proper drink mix
    { "kind": "generic", "title": "Dead Men Don't Drink", "description": "Help Robb Derick remember and find peace", "location": GuestHallway, "completionbit": IsSpawnedRobbAstral(), "points": MediumPuzzle, "type": "progression"},
      // complete the twins rooms
    { "kind": "generic", "title": "Mirrored Manipulation", "description": "Help Diana and Fiana find peace", "location": GuestRoomC, "completionbit": IsSpawnedFianaAstral(), "points": EasyPuzzle, "type": "progression"},
    // complete the medal puzzle and meet Ed
    // deferring this for the hint challenge one
    //{ "kind": "generic", "title": "Flaggage", "description": "Help Ed Mooring find peace", "location": ReadingRoom, "completionbit": IsSpawnedEdMooringAstral(), "points": MediumPuzzle, "type": "progression"},
    // Navigate the mine and return claudia's doll   triggers after the doll disappears on screen for best timing (genericrev)
    { "kind": "generic", "title": "Misery Mine", "description": "Navigate the mine and help Claudia find peace", "location": SpecialGuestRoom, "completionbit": ClaudiaDollReturned(), "points": LargeEvent, "type": "progression", "id": 490704 },
    // pick up the dress suit and get clubbed
    { "kind": "generic", "title": "A Suitable Outfit for Clubbing", "description": "Retrieve the dress suit", "location": SpecialGuestRoom, "completionbit": Clubbed(), "points": Trivial, "type": "progression"},
    // Get the prescription
    { "kind": "generic", "title": "A Peculiar Prescription", "description": "Find and show the prescription to the doctor", "location": MedicalOffice, "completionbit": PrescriptionDelivered(), "points": SmallEvent, "type": "progression"},
    // get the record from film booth and play it in the child room and open the chest
    { "kind": "generic", "title": "Witness to Reunion", "description": "Reunite the lost child with his mother and retrieve the key items", "location": ChildRoom, "completionbit": ChildChestOpen(), "points": MediumPuzzle, "type": "progression"},
    // watch the film with the dr and learn it wasn't his fault
    { "kind": "generic", "title": "Anxiety Alleviated", "description": "Help Dr Thomas Gusset see the truth and find peace", "location": Theater, "completionbit": IsSpawnedThomasGussetAstral(), "points": SmallEvent, "type": "progression"},
    // pour the antidote on the acid
    { "kind": "genericrev", "title": "Rug Doctor", "description": "Clean the soiled carpet", "location": TheaterHallway, "completionbit": PouringAntidote(), "points": EasyPuzzle, "type": "progression"},
    // wear the suit and go to dine
    { "kind": "generic", "title": "Suited to Sup", "description": "Be ushered to the dining hall", "location": DiningHallway, "completionbit": IsSpawnedStewardAstral(), "points": Minor, "type": "progression"},
    // Get Past the ghost in the stairwell,  insert the gear in crow, turn on the light
    { "kind": "generic", "title": "Raven Ruckus", "description": "Eliminate the ghost with the help of a feathered friend", "location": Stairway, "completionbit": StairwayGhostDead(), "points": MediumPuzzle, "type": "progression"},
    // reminder to save here as there is an upcoming challenge
    { "kind": "generic", "title": "Tea Time", "description": "Unlock the kitchen door, head into the kitchen, and save now", "location": GrandDining, "completionbit": KitchenDoorUnlocked(), "points": Minor, "type": "progression"},
    //
    { "kind": "generic", "title": "A Placating Pendant", "description": "Find the pendant and help Eleanor Galleywood find peace", "location": TerraceLazarette, "completionbit": LadySpiritFreed(), "points": Minor, "type": "progression"},
    // set off the alarm and get the document off the bed
    { "kind": "genericrev", "title": "An Alarming Situation", "description": "Get the probationers document", "location": CrewsQuartersB, "completionbit": IsSpawnedSailorsDocument(), "points": EasyPuzzle, "type": "progression"},
    // doors 1 and 2 open freely, the rest only open if the math adds up
    { "kind": "generic", "title": "It's All Starting To Add Up", "description": "Open locker number four", "location": CrewsQuartersA, "completionbit": OpenedLockerFour(), "points": MediumPuzzle, "type": "progression"},
    
    // put the gear in the parrot
    { "kind": "generic", "title": "A Paralyzed Patient", "description": "Fix the parrot and help Emllie Scuttle find peace", "location": TerraceLazarette, "completionbit": IsSpawnedEmllieScuttleAstral(), "points": Minor, "type": "progression"},
    // 
    { "kind": "generic", "title": "Plates Placed", "description": "Properly place the plates and unlock the stairway door", "location": Stairway, "completionbit": UnlockedStairwayDoor(), "points": EasyPuzzle, "type": "progression", "id": 505858},
    //
    { "kind": "generic", "title": "A Kingly Cameo", "description": "Return the cameo to its owner", "location": PrivateQuarters, "completionbit": KingGivenCameo(), "points": EasyPuzzle, "type": "progression", "id": 505878},
    //
    { "kind": "generic", "title": "A Melody Made", "description": "Play a familiar tune", "location": Cathedral, "completionbit": OrganSolved(), "points": MediumPuzzle, "type": "progression"},   
    // 
    { "kind": "generic", "title": "A Benevolent Brother, A Sacrificing Sister", "description": "At long last, help Oscar Rockwell find peace", "location": RadioRoom, "completionbit": IsSpawnedOscarRockwellAstral(), "points": LargeEvent, "type": "progression"},   


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
    // as the engine room door unlocks, strongly suggest saving to the player before the point of no return
    { "kind": "generic", "title": "Point of No Return", "description": "Unlock the engine room door.  Save now, the point of no return is ahead", "location": PortCorridor, "completionbit": EngineRoomUnlocked(), "points": Minor, "type": "progression", },
    //{ "kind": "generic", "title": "Play That Funky Music", "description": "After getting all 26 astral pieces, play some music on the jukebox", "location": Casino, "completionbit": JukeBoxUnlocked(), "points": MinorChallenge, "type": "missable", },

]

for c in Cheevos {
    AchievementFunction(c)
}

// Page Turners cheevos


function bookreturn(page) {
    if page == 0 {
        return once(itemNotePage() == page)
    } else {
        return once(itemNotePage() == page && prev(itemNotePage()) != page)
    }
}




function AchievementBookFunction(Book) {
achievement(
    title = "Page Turners: "  + Book["name"], points = Book["points"], type = "missable",
    description = "Read all the pages of " + Book["name"],
    trigger = unless((GameContinuedState() > 0 && ScreenOpen() != 1) || itemIsBeingInteractedWith() != 51 ||
                  byte(inventorySlotHighlighted() * 8 + PlayerInventoryArrayStartAddr) != Book["itemid"]
              ) &&
              measured(tally_of( 
                 range(0,Book["numpages"]-1), Book["numpages"], (p) => bookreturn(p)
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
        array_push(MapArray, locationMapBit(Pilothouse))
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
HouseFireplace            = 0x1
HouseBurntBookshelf1      = 0x2
HouseBurntBookshelf2      = 0x3
HouseLamp                 = 0x4
HouseBed                  = 0xd
HouseUnlockedClockCabinet = 0x3d
HouseWindingKey           = 0xc9
HouseBurntChair           = 0xff
HouseGrandfatherClock     = 0x10b

// when the opened clock is in slot 0, the clock hands and keyhole are in slot 3
MinuteHand                = 0x3
HourHand                  = 0x2
WindingKeyhole            = 0x1

// Items without tooltips
HouseFirstDoor            = 0x6
HouseBedroomDoor          = 0x8
HousePolicemanIntro       = 0x65
HousePoliceman            = 0x6e
HouseOpenedClock          = 0x100000B



achievement(
    title = "A Thorough Investigation", points = EasyChallenge, type="missable",
    description = "Investigate everything in the house before leaving the area",
    id = 461607,
    trigger = (GameRunning() && never(LocationID() != House)) &&  SteamLocomotiveComplete() == 0 &&
              once(ConfigSlotInteractionID(0) == HousePolicemanIntro) &&
              (trigger_when(measured(tally(15, 
                    once(ConfigSlotInteractionID(0) == HousePoliceman        && ConfigSlotFunctionID(0) == None),
                    once(ConfigSlotInteractionID(0) == HouseFirstDoor        && ConfigSlotFunctionID(0) == Opening),
                    once(ConfigSlotInteractionID(0) == HouseBedroomDoor      && ConfigSlotFunctionID(0) == Opening),                 
                    once(ConfigSlotInteractionID(0) == HouseFireplace        && ConfigSlotFunctionID(0) == ReadingText),
                    once(ConfigSlotInteractionID(0) == HouseBurntBookshelf1  && ConfigSlotFunctionID(0) == ReadingText),
                    once(ConfigSlotInteractionID(0) == HouseBurntBookshelf2  && ConfigSlotFunctionID(0) == ReadingText),
                    once(ConfigSlotInteractionID(0) == HouseLamp             && ConfigSlotFunctionID(0) == ReadingText),
                    once(ConfigSlotInteractionID(0) == HouseBurntChair       && ConfigSlotFunctionID(0) == ReadingText),
                    once(ConfigSlotInteractionID(0) == HouseWindingKey       && ConfigSlotFunctionID(0) == ReadingText),
                    once(ConfigSlotInteractionID(0) == HouseBed              && ConfigSlotFunctionID(0) == ReadingText),
                    once(ConfigSlotInteractionID(0) == HouseGrandfatherClock && ConfigSlotFunctionID(0) == ReadingText),
                    once(g_current_config_slot["id"] == MinuteHand        && g_current_config_slot["func_id"] == ReadingText),
                    once(g_current_config_slot["id"] == HourHand          && g_current_config_slot["func_id"] == ReadingText),
                    once(g_current_config_slot["id"] == WindingKeyhole    && g_current_config_slot["func_id"] == ReadingText),
                    once(ClockWound() > prev(ClockWound()))),
                    format="percent"
                )))
)


CasinoBoss       = 0x164

// These are pointers to the start of ascii text block in their custom encoding
LightSwitchClue1 = 0x8018f9b8
LightSwitchClue2 = 0x8018fa8c
LightSwitchClue3 = 0x8018fb5c

achievement(
    title = "Breadcrumbs to Illumination", points = MinorChallenge, type="missable",
    description = "In one session without saving or loading, hear the clue then turn on the secret lightswitch",
    id = 491963,
    trigger = (GameContinuedState() > 0 && LocationID() == prev(LocationID()) && currentConfigSlotAddr() == prev(currentConfigSlotAddr()) && once(SecretLightswitchOn() == 0) &&
              never(GameLoaded()) && never(GameSaved())) &&
              (  
                once(LocationID() == Casino && g_current_config_slot["func_id"] == ReadingText  && g_current_config_slot["id"] == CasinoBoss && g_current_config_slot["data_ptr"] == LightSwitchClue1) &&
                once(LocationID() == Casino && g_current_config_slot["func_id"] == ReadingText  && g_current_config_slot["id"] == CasinoBoss && g_current_config_slot["data_ptr"] == LightSwitchClue2) &&
                once(LocationID() == Casino && g_current_config_slot["func_id"] == None         && g_current_config_slot["id"] == CasinoBoss && g_current_config_slot["data_ptr"] == LightSwitchClue3) &&
                trigger_when(LocationID() == TheaterHallway && SecretLightswitchOn() > prev(SecretLightswitchOn()))
              ) 
)


achievement(
    title = "Geared Up", points = MinorEvent, type ="missable", id = 505898,
    description = "Have the gear on you the first time you enter Terrace Lazarrette",
    trigger = GameRunning() && LocationID() == TerraceLazarette && IsGearInCrow() != 1 && locationMapBit(TerraceLazarette) > prev(locationMapBit(TerraceLazarette))
)


// Fusebox does not flip a bit in the current location, but instead flips a bit in the adjacent room (0x4=Compartment)

achievement(
    title = "O.S.H.A. Approved", points = EasyChallenge,
    description = "Fix the fusebox without getting zapped", type="missable",
    id = 490703,
    trigger = (GameRunning() && never(LocationID() != UprDeckPassagewayInside) &&
               once(FuseBoxWired() == 0) && once(FuseBoxWired() > prev(FuseBoxWired())) &&
               disable_when(LocationID() == UprDeckPassagewayInside && playerPuzzleStatus() == 0 && playerstanding() == 1 && playerCondition() < prev(playerCondition()), until=GameLoaded())
    )
)

// Grabbed With Gusto
// retrieve the wire cutters from the wall without being hit by the ghost
// watch her position, you can duck down/hide/wait her out if she is close to you
// as long as you don't walk into her you should be able to make it to the door

ExitDoor = 3

achievement(
    title = "Grabbed With Gusto", points = EasyChallenge, type="missable",
    description = "Retrieve the wire cutters and exit the room without being hit by the ghost",
    id = 489271,
    trigger = disable_when(LocationID() == UprDeckCompartment && TakenDamage(), until=GameLoaded()) && 
              GameRunning() && never(LocationID() != UprDeckCompartment) && once(IsSpawnedWireCutter() == 1) &&
              trigger_when(
                once(IsSpawnedWireCutter() < prev(IsSpawnedWireCutter())) &&
                (ConfigSlotInteractionID(0) == ExitDoor || ConfigSlotInteractionID(1) == ExitDoor || ConfigSlotInteractionID(2) == ExitDoor)
              )          
)

achievement(
    title = "When You Wish Upon a Star", points = MinorEvent, type="progression",
    description = "Visit the medium and receive the broken stone",
    trigger = GameRunning() && never(LocationID() != ObservatoryB) &&
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




TICKETS = [
    {"ticket": IsSpawnedFloor1LoungeClaimTicketFarLeftUnderBar(),                    "loc": Lounge},
    {"ticket": IsSpawnedFloor1GrandDiningClaimTicket(),                              "loc": GrandDining},
    {"ticket": IsSpawnedSpecialGuestRoomClaimTicket(),                               "loc": SpecialGuestRoom},
    {"ticket": IsSpawnedFloor2TheaterClaimTicket(),                                  "loc": Theater},
    {"ticket": IsSpawnedLwrDeckPoolClaimTicketInStarboardLocker(),                   "loc": Pool},
    {"ticket": IsSpawnedFloor2CasinoClaimTicket(),                                   "loc": Casino},
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
    {"cure": IsSpawnedBoilerACuringPotion(),                                       "bit": locationMapBit(BoilerA)},
    {"cure": IsSpawnedFloor1WaterRoomCuringPotion(),                               "bit": locationMapBit(WaterRoom)},
    {"cure": IsSpawnedFloor2ShowerRoomCuringPotionInLocker(),                      "bit": locationMapBit(ShowerRoom)},
    {"cure": IsSpawnedLwrDeckPoolRoomCuringPotionInPortLocker(),                   "bit": locationMapBit(Pool)},
    {"cure": IsSpawnedFloor2EngineersRoomCuringPotion(),                           "bit": locationMapBit(EngineersRoom)},
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
    title = "Sole Conduit", points = HardChallenge, type="missable", id = 499031,
    description = "Reclaim all the astral pieces and transfer them to the medium",
    trigger = GameRunning() && measured(astralPiecesTurnedIn() == 26) && prev(astralPiecesTurnedIn() < 26)
)

// visit the medium while possessed
achievement(
    title = "It's Not Easy Being Green, Medium", points = MediumChallenge, type="missable", id=505857,
    description = "Get possessed in the dining room hallway, visit the lounge, and then make your way to the medium through the pilothouse portal, without losing possession status",
    trigger = GameRunning() && once(LocationID() == DiningHallway && possessed() >0 && prev(possessed() == 0))
    && (trigger_when(measured(tally(3,
           EnteredRoom(Lounge,0),
           EnteredRoom(Pilothouse,0),
           EnteredRoom(ObservatoryB,Pilothouse)
        ))))
    && never(possessed() == 0) && never(GameLoaded()) && never(GameOver())
)



CasinoBossKick      = 0xf0        // casino boss while being kicked out
CasinoBossKickOut1  = 0x80190ea4  // "Sir..."
CasinoBossKickOut2  = 0x80190fd4  // "I'm sorry but we are closed for the day"


CasinoKickOut = [
  {"location": Casino,     "id": CasinoBossKick, "fid": ReadingText, "dptr": CasinoBossKickOut1}, // "Sir..."
  {"location": Casino,     "id": CasinoBossKick, "fid": ReadingText, "dptr": CasinoBossKickOut2}, // "I'm sorry but we are closed for the day"
]


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

GraveClues = [
{"location": CemeteryGraveyard, "id": Grave1Front, "fid": ReadingText, "dptr": Grave1FrontData}, 
{"location": CemeteryGraveyard, "id": Grave1Back,  "fid": ReadingText, "dptr": Grave1BackData},
{"location": CemeteryGraveyard, "id": Grave2Front, "fid": ReadingText, "dptr": Grave2FrontData}, 
{"location": CemeteryGraveyard, "id": Grave2Back,  "fid": ReadingText, "dptr": Grave2BackData},
{"location": CemeteryGraveyard, "id": Grave3Front, "fid": ReadingText, "dptr": Grave3FrontData}, 
{"location": CemeteryGraveyard, "id": Grave3Back,  "fid": ReadingText, "dptr": Grave3BackData},   
]

CupClues = [
{"location": GuestRoomA, "id": 0x02, "fid": ReadingText, "dptr": 0x8018dd74},  //i can't fulfill robb my painting
{"location": GuestRoomA, "id": 0x02, "fid": ReadingText, "dptr": 0x8018ddfc},  //over there to make the drink      - Ed Mooring
{"location": Lounge,     "id": 0x17, "fid": ReadingText, "dptr": 0x8018e734},  // E.M. Painting
]

PQClock = [
{"location": ForestRoom, "id": 0x64, "fid": ReadingText, "dptr": 0x8018eef0},
{"location": ForestRoom, "id": 0x64, "fid": ReadingText, "dptr": 0x8018ef74},
{"location": FireRoom,   "id": 0x6e, "fid": ReadingText, "dptr": 0x8018f200},  //adjust the hallway clock to the bird
]

// Find all the paintings/pictures in the game, excludes the one in the basement in the beginning since you can't get back there after you leave.
Artwork = [
{"location": Lounge,      "id": 0x16, "fid": ReadingText, "dptr": 0x8018e63c}, // 3bottles painting
{"location": Lounge,      "id": 0x17, "fid": ReadingText, "dptr": 0x8018e734}, // E.M. Painting
{"location": Lounge,      "id": 0x18, "fid": ReadingText, "dptr": 0x8018e828}, // K.S. Painting
{"location": Lounge,      "id": 0x0e, "fid": ReadingText, "dptr": 0x8018de28}, // giant snake 2 blades painting
{"location": GuestRoomA,  "id": 0x1a, "fid": ReadingText, "dptr": 0x8018ecf4}, // E.M. Canvas
{"location": GrandDining, "id": 0x11, "fid": ReadingText, "dptr": 0x8018de5c}, // old castle with sun
{"location": GrandDining, "id": 0x13, "fid": ReadingText, "dptr": 0x8018e00c}, // strange monster
{"location": GrandDining, "id": 0x12, "fid": ReadingText, "dptr": 0x8018df30}, // lady with fin
{"location": WaterRoom,   "id": 0x20, "fid": ReadingText, "dptr": 0x8018e9d0}, // hilda rockwell
{"location": WaterRoom,   "id": 0x1f, "fid": ReadingText, "dptr": 0x8018e944}, // arthur rockwell
{"location": SkyRoom,     "id": 0x1d, "fid": ReadingText, "dptr": 0x8018ea2c}, // pic with baby
{"location": SkyRoom,     "id": 0x1c, "fid": ReadingText, "dptr": 0x8018e970}, // commemorative picture
{"location": SkyRoom,     "id": 0x1f, "fid": ReadingText, "dptr": 0x8018ec38}, // pic parents with daughter
{"location": SkyRoom,     "id": 0x1e, "fid": ReadingText, "dptr": 0x8018eb60}, // pic dad& 4year old crea
{"location": SkyRoom,     "id": 0x20, "fid": ReadingText, "dptr": 0x8018ed0c}, // painting of a castle
] 

PoolPump = [
{"location": TerraceLazarette, "id": 0x25, "fid": ReadingText, "dptr": 0x8018f9ec },  // blurry sign in pool pump room  
]

// TODO: Continue from here to keep adding id's and dptr values to code note
// do we need to use 19b at all?
Claudia = [  
{"location": UprDeckCompartment,      "id": 0xf0, "dptr": 0x19b0000 }, // for some reason the compartment claudia is a different id
{"location": UprDeckPassagewayInside, "id": 0xf9, "dptr": 0x19b0000 },
{"location": Pilothouse,              "id": 0xf9, "dptr": 0x19b0000 },
{"location": GuestRoomA,              "id": 0xf9, "dptr": 0x19b0000 },
{"location": GuestRoomB,              "id": 0xf9, "dptr": 0x19b0000 },
{"location": GuestHallway,            "id": 0xf9, "dptr": 0x19b0000 },
{"location": PassengerHallway,        "id": 0xf9, "dptr": 0x19b0000 },
]

King = [
{"location": PrivateQuarters,         "id": 0x7f },
]



function InteractionAchievementPreconditions() { 
    return GameRunning() && never(GameLoaded()) && never(GameOver()) && currentConfigSlotAddr() == prev(currentConfigSlotAddr())
}

// pause lock until gameover or game loaded when player takes damage
function pauseLockCondition() {
    return disable_when(once(TakenDamage()), until=(GameLoaded() || GameOver() ))
}


function ClaudiaTooEarlyPause() {
    return disable_when(locationMapBit(AbandonedMineC) == 0, until=(locationMapBit(AbandonedMineC) == 1 || GameLoaded() || GameOver()))
}

function KingTooEarlyPause() {
    return disable_when(HaveCameo() == 0, until=(HaveCameo() == 1 || GameLoaded() || GameOver()))
}

function statePTR() => dword(0x9f920)
PausedOrMenu    = 0x801849c0  // seems to be set when a menu is up or the game is paused
ResultsScreen   = 0x801789c0  // results screen up


function pauseWhenGamePaused() {
    return disable_when(statePTR() == PausedOrMenu, until=statePTR() != PausedOrMenu)
}


function ClaudiaPauseLock() {
    return disable_when((locationMapBit(AbandonedMineC) == 1 && IsSpawnedClaudiasDoll() == 0 && TakenDamage()), until=(GameLoaded() || GameOver() ))
}

// Make sure that we don't start counting claudia interactions until the doll is picked up. At this point all of claudias locations are available.
// Hopefully this encourages player to make a save after getting the doll and before returning it to do this achievement
// reset if player takes damage, pause lock until gameload
function ClaudiaPreconditions() {
    return ClaudiaTooEarlyPause() &&
          InteractionAchievementPreconditions() && never(TakenDamage()) && 
          pauseLockCondition()
}

function ClaudiaPostconditions() {
    return ClaudiaDollReturned() > prev(ClaudiaDollReturned())
}

function KingPreconditions() {
    return KingTooEarlyPause() &&
         InteractionAchievementPreconditions() && never(TakenDamage()) && never(LocationID() != PrivateQuarters) &&
         pauseLockCondition()
}

function KingPostconditions() {
    return KingGivenCameo() > prev(KingGivenCameo())
}

function GhostCondition(cheev,repeatvalue,type) {

    if type == "king" {
        return once(g_current_config_slot["id_byte"] == cheev["id"] && repeated(repeatvalue, totalTime() > prev(totalTime())))
    } else if type == "claudia" {
        return once(LocationID() == cheev["location"] && g_current_config_slot["id_byte"] == cheev["id"] && g_current_config_slot["data2_value"] == cheev["dptr"] && repeated(repeatvalue, totalTime() > prev(totalTime())))
    } else {
        assert(false,message="Unable to locate proper type for GhostCondition")
    }
}

function KingCondition(cheev,repeatvalue) {
    return once(g_current_config_slot["id_byte"] == cheev["id"] && repeated(repeatvalue, totalTime() > prev(totalTime())))
}



// frames per second
//fps             = 60

// Use totalTime() which is actual seconds.  game pauses timer when in menu and paused already, so better than counting frame hits
ten_seconds     = 10
thirty_seconds  = 30

function AchievementInteractionFunction(cheev,conditiontype) {
   if conditiontype == "post" {
        achievement(
        title = cheev["title"], points = cheev["points"], description = cheev["description"], type = cheev["type"], id=id_or_zero(cheev),
        trigger = InteractionAchievementPreconditions() &&
                  measured(tally_of(
                           cheev["list"], length(cheev["list"]),
                           (o) => once(
                                  LocationID() == o["location"] && 
                                  g_current_config_slot["id"] == o["id"] && 
                                  g_current_config_slot["func_id"] == o["fid"] && 
                                  g_current_config_slot["data_ptr"] == o["dptr"] && 
                                  prev(g_current_config_slot["data_ptr"] != o["dptr"])
                                  )
                  )) && cheev["postconditions"]
                 
    )
  } else if conditiontype == "pre" {
        achievement(
        title = cheev["title"], points = cheev["points"], description = cheev["description"], type = cheev["type"], id=id_or_zero(cheev),
        trigger = (InteractionAchievementPreconditions() && cheev["preconditions"]) &&
                  (measured(tally_of(
                           cheev["list"], length(cheev["list"]),
                           (o) => once(
                                  LocationID() == o["location"] && 
                                  g_current_config_slot["id"] == o["id"] && 
                                  g_current_config_slot["func_id"] == o["fid"] && 
                                  g_current_config_slot["data_ptr"] == o["dptr"] && 
                                  prev(g_current_config_slot["data_ptr"] != o["dptr"])
                                  )
                  )))
                 
    )      
  } else if conditiontype == "both" {
        achievement(
        title = cheev["title"], points = cheev["points"], description = cheev["description"], type = cheev["type"], id=id_or_zero(cheev),
        trigger = (InteractionAchievementPreconditions() && cheev["preconditions"]) &&
                  (measured(tally_of(
                           cheev["list"], length(cheev["list"]),
                           (o) => once(
                                  LocationID() == o["location"] && 
                                  g_current_config_slot["id"] == o["id"] && 
                                  g_current_config_slot["func_id"] == o["fid"] && 
                                  g_current_config_slot["data_ptr"] == o["dptr"] && 
                                  prev(g_current_config_slot["data_ptr"] != o["dptr"])
                                  )
                  )) && cheev["postconditions"])
    ) 
  } else if conditiontype == "none" {
    achievement(
        title = cheev["title"], points = cheev["points"], description = cheev["description"], type = cheev["type"], id=id_or_zero(cheev),
        trigger = (InteractionAchievementPreconditions()) &&
                  (measured(tally_of(
                           cheev["list"], length(cheev["list"]),
                           (o) => once(
                                  LocationID() == o["location"] && 
                                  g_current_config_slot["id"] == o["id"] && 
                                  g_current_config_slot["func_id"] == o["fid"] && 
                                  g_current_config_slot["data_ptr"] == o["dptr"] && 
                                  prev(g_current_config_slot["data_ptr"] != o["dptr"])
                                  )
                  ))) 
    )
  } else if conditiontype == "claudia" {
        achievement(
        title = cheev["title"], points = cheev["points"], description = cheev["description"], type = cheev["type"], id=id_or_zero(cheev),
        trigger = (ClaudiaPreconditions()) &&
                  (measured(tally_of(
                           cheev["list"], length(cheev["list"]), (o) => GhostCondition(o,ten_seconds,"claudia")
                  )) && trigger_when(ClaudiaPostconditions()))
    )
  } else if conditiontype == "king" {
        achievement(
        title = cheev["title"], points = cheev["points"], description = cheev["description"], type = cheev["type"], id=id_or_zero(cheev),
        trigger = (KingPreconditions()) &&
                  (measured(tally_of(
                           cheev["list"], length(cheev["list"]), (o) => GhostCondition(o,thirty_seconds,"king")
                  ), format="percent") && trigger_when(KingPostconditions()))
    )      
  } else {
      assert(false,message="Condition type error with  " + conditiontype)
  }
}




ClaudiaCheevos = [
    {"title": "I Ain't Afraid of No Ghost Girl", "points": HardChallenge, "description": "After retrieving Claudia's doll, spend 10 seconds with Claudia in every room she haunts and then return her doll without being damaged", "ghost": "claudia", "list": Claudia, "type": "missable", "id": 490702 },
    {"title": "I Ain't Afraid of No Ghost King", "points": MediumChallenge, "description": "After retrieving the King's cameo, spend 30 seconds with the King and then return the cameo without being damaged", "ghost": "king", "list": King, "type": "missable", "id": 505879 },
]

for c in ClaudiaCheevos {
   AchievementInteractionFunction(c,c["ghost"])
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
{"title": "Art Aficionado", "points": MediumChallenge, "description": "In one session, inspect every piece of framed art on the Orpheus", "list": Artwork, "type": "missable", "id": 503715},
{"title": "A Grave Opening", "points": EasyChallenge, "description": "Look at the clues and then open the crypt", "list": GraveClues, "type": "missable", "id": 497931,
   "postconditions": SolvedCryptPuzzle() > prev(SolvedCryptPuzzle()) && never(LocationID() != CemeteryGraveyard) },
{"title": "Is Anything Else Open?", "points": Minor, "description": "Overstay your welcome and get kicked out of the casino", "list": CasinoKickOut, "type": "missable", "id": 499034},
{"title": "Clued Cup", "points": EasyPuzzle, "description": "Discover the clues and then pick up the cup", "list": CupClues, "type": "missable", "id": 505897,
   "postconditions": trigger_when(once(LocationID() == GuestHallway && IsSpawnedCup() < prev(IsSpawnedCup()))), "preconditions": once(IsSpawnedCup() == 1)},
{"title": "Clues Clocked", "points": EasyPuzzle, "description": "Discover the clues and then pick up the clock key", "list": PQClock, "type": "missable", "id": 505899,
   "postconditions": trigger_when(once(LocationID() == WaterRoom && IsSpawnedClockKey() < prev(IsSpawnedClockKey()))), "preconditions": once(IsSpawnedClockKey() == 1)},   
{"title": "Pow.r th. Po.l P.mp", "points": MediumPuzzle, "type": "missable", "description": "View the instruction tooltip and start the pool pump", "list": PoolPump, "id": 497952,
   "preconditions": once(PoolPumpStarted() == 0), "postconditions": trigger_when(PoolPumpStarted() > prev(PoolPumpStarted())) && never(LocationID() != TerraceLazarette)
}
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
              ) && FlagPuzzleSolved() > prev(FlagPuzzleSolved()) && never(LocationID() != ReadingRoom)
)


// Mess hall

// King animation changes the id a lot, but in testing it always starts out at 0xdc
King = 0xdc

achievement(
    title = "Between a King and a Hard Place", points = EasyChallenge,
    description = "Escape the mess room without being hit by the king",
    trigger = GameRunning() &&
              once(LocationID() == MessRoom && prev(LocationID() == DiningRoomGalley)) &&
              once(g_current_config_slot["id"] == King) &&
              trigger_when(TalkedToFatherMessRoom() > prev(TalkedToFatherMessRoom())) &&
              never(TakenDamage()) && never(LocationID() != MessRoom) && never(GameLoaded()) && never(GameOver())
)


// use slowest walking speed and escape the cemetery without being hit
// reset on being in terracelazarette (indicates player has left cemetery)
// reset on being in basement (indicates player has died)
WalkingSpeed = byte(0x1a6b5d)
Slowest = 0
function CryptGateOpen() => bit1(locationBitflags(CemeteryCryptB,0))

achievement(
    title = "Dodged a Dead End", points = HardChallenge, type = "missable",
    description = "With walking speed setting set to slower, retrieve the fish plate and escape the cemetery without being damaged",
    trigger = GameRunning() &&
              once(LocationID() == CemeteryCryptB  && CryptGateOpen() > prev(CryptGateOpen())) &&
              trigger_when(FlyingFishPlateInLastSlot() == 0 && EscapedCemetery() > prev(EscapedCemetery())) &&
              never(TakenDamage()) && never(LocationID() == TerraceLazarette) && never(WalkingSpeed != Slowest) &&
              never(LocationID() == Basement) && never(GameLoaded())             
)


// Casino Achievements

function ptrToSlotPayout() => tbyte(0x09FA30)

PlayingSlots    = 0xc9
SlotWin         = 0x200
SlotJackpot     = 0x20a

achievement(
    title = "Slot Success", points = EasyChallenge, type="missable",
    description = "Win at slots",
    trigger = GameRunning() && LocationID() == Casino && CodeFlow() == PlayingSlots &&
              ((word(ptrToSlotPayout()) == SlotWin) || (word(ptrToSlotPayout()) == SlotJackpot))
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
    title = "Wheel of Fortune", points = MinorChallenge, type="missable",
    description = "Win at least 3 more chips than you bet while playing a single round of roulette",
    id = 492103,
    trigger = GameRunning() && LocationID() == Casino && CodeFlow() == PlayingRoulette && rouletteStatus() == RoulettePayout &&
              prev(rouletteStatus()) == RouletteInnerSpin && (word(tbyte(0x09FA2C) + 0x000048) - rouletteChipsBet()) > 2
)





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
    trigger = GameRunning() && never(LocationID() != Theater) && filmEngineerGone() == 0 && 
              // the first time you enter the theater the "In theater entrance" bit is not set for some reason
              // so this ornext covers both cases where you are in the front room
              __ornext(playerInTheaterEntrance() == 1 || (playerInTheater() == 0 && playerInTheaterBackRoom() == 0  && playerInFilmBooth() == 0)) &&
              once(g_current_config_slot["id"] == TheaterEngineer && g_current_config_slot["func_id"] == None && g_current_config_slot["data_ptr"] == MovieTheater1) &&
              once(g_current_config_slot["id"] == TheaterEngineer && g_current_config_slot["func_id"] == None && g_current_config_slot["data_ptr"] == MovieTheater2) &&
              once(g_current_config_slot["id"] == TheaterEngineer && g_current_config_slot["func_id"] == None && g_current_config_slot["data_ptr"] == MovieTheater3) &&
              once(g_current_config_slot["id"] == TheaterEngineer && g_current_config_slot["func_id"] == None && g_current_config_slot["data_ptr"] == MovieTheater4 && prev(g_current_config_slot["data_ptr"] != MovieTheater4))
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
    description = "Ride the carousel before locating the missing item",
    trigger = GameRunning() && LocationID() == AmusementParkCarousel && IsSpawnedAmusementParkEngagementRing() == 1 &&
              currentConfigSlotAddr() == prev(currentConfigSlotAddr()) &&
              any_of(HORSES, (h) => g_current_config_slot["id"] == h && prev(g_current_config_slot["id"] != h))
)



function JukeboxStatus() => dword(0x9fb64)
Playing = 2
Loading = 1


achievement(
    title = "Play That Funky Music", points = EasyPuzzle, type = "missable",
    description = "Unlock the jukebox and listen to a few songs",
    trigger = GameRunning() && JukeBoxUnlocked() == 1 && measured(tally(5, once(JukeboxStatus() == Playing && prev(JukeboxStatus() == Loading)))) && never(LocationID() != Casino)
)


// ratings


ptrResultsRating         = 0x8009f797
ptrResultsTotalPlaytime  = 0x80012145
// these 3 bytes are set this way in the CalcAndReturnResults() function of the game code
function resultsOnScreen()        => byte(0x1DE614) == 144 && byte(0x1DE615) == 144 && byte(0x1DE616) == 144
function prevresultsNotOnScreen() => prev(byte(0x1DE614) != 144) && prev(byte(0x1DE615) != 144) && prev(byte(0x1DE616) != 144)


IntelligenceScore  = dword(0x18baa0)
SecretsScore       = dword(0x18ba9c)
PhysicalScore      = dword(0x18ba08)

ResultsPTRAddr     = 0x801789c0

function ResultsPTRValue() => dword(0x1789c0)

// ESPER,GENIUS,SUPERIOR values
ResultsDisplay   = 0x12cfb0    //(0x912cf88)
ResultsTotalTime = 0x12d2d0   

//Average
// display = 0x12cf88  //(0x912cf60)
// time    = 0x12d2a8

// Novice, DONKEY
// display = 0x12cf38    //(0x912cf10)
// time    = 0x12d258

function ResultsPageRunning() {
    //return ptr(statePTR()) == 0x12cfb0 && prev(ptr(statePTR()) == 0x12d2d0)
    return statePTR() == ResultsPTRAddr && ResultsPTRValue() == ResultsDisplay && prev(ResultsPTRValue()) == ResultsTotalTime
}

ResultRatingComponent0 = dword(0x9f970)
ResultRatingComponent1 = dword(0x9f974)

function ratingScore() {
    return (ResultRatingComponent1 + ResultRatingComponent0 * 8)
}

ESPER    = 0xf
GENIUS   = 0xe
SUPERIOR = 0xd  // also average and novice
DONKEY   = 0xc




achievement(
    title = "Ranked: Esper", points = HardChallenge,
    description = "Complete the game with an ESPer rating",
    trigger = GameRunning() && resultsOnScreen() && ResultsPageRunning() && ratingScore() == ESPER
)

achievement(
    title = "Ranked: Genius", points = MediumChallenge,
    description = "Complete the game with a Genius or higher rating",
    trigger = GameRunning() && resultsOnScreen() && ResultsPageRunning() && ratingScore() >= GENIUS
)

//ENDINGS


EndingMissing = 0xd4
EndingTrue    = 0xdc
EndingGray    = 0xd3
Credits       = 0xd2



// There is a cutscene attached with the death scene, so worth an acheviement, but 0 points.
achievement(
    title = "Conclusion: A Dank Destination", points = 0,
    description = "Fail to survive the night and become a permanent fixture of the nightmare",
    id = 473928,  
    trigger = GameRunning() && LocationID() == Basement && gameOver() == 1 && prev(gameOver()) == 0
)

// similar to the game over scene, there is a unique ending for failing to escape, also 0 points
achievement(
    title = "Conclusion: Lost at Sea", points = 0,
    description = "Time runs out and Richard vanishes along with the Orpheus",
    id = 473924, 
    trigger = GameRunning() && CodeFlow() == EndingMissing && resultsOnScreen() && prevresultsNotOnScreen()
)

// True ending
achievement(
    title = "Conclusion: A New Dawn", points = MediumChallenge, type="win_condition",
    description = "Reclaim all the astral pieces, break the cycle of insatiable ambition, and find solace in the true ending",
    id = 473925,  
    trigger = GameRunning() && LocationID() == CompartmentA && CodeFlow() == Credits && prev(CodeFlow()) == EndingTrue
)

// evil ending
achievement(
    title = "Conclusion: Like Father Like Son", points = MediumChallenge, type="win_condition",
    description = "Reclaim all the astral pieces, succumb to the allure of power, and inherit the legacy of darkness",
    id = 473926,   
    trigger = GameRunning() && LocationID() == House && IsSpawnedBloodyKnife() > prev(IsSpawnedBloodyKnife())
)

// mysterious ending where the knife shows up in the trunk of the car, uhoh. 
// also called Gray ending
achievement(
    title = "Conclusion: A Sticking Point", points = EasyChallenge, type="win_condition",
    description = "Fail to make a choice, escape the Orpheus, and discover a point of contention",
    id = 473927, 
    trigger = GameRunning() && LocationID() == GrayEndingHouse && IsSpawnedKnifeInTrunk() > prev(IsSpawnedKnifeInTrunk())
)

// rich presence

function numSaves()     => dword(0x1a6ca0)


rich_presence_conditional_display(gameOver() == 1, "☠️-[ Game Over 👣:{1} 🕰️ {0} 💾:{2} ]-☠️", 
    rich_presence_value("Seconds", totalTime(), format="SECS"),
    rich_presence_value("Number", pedometer()),
    rich_presence_value("Number", numSaves())
)

RatingLookup = {
    0xbf7f: "Donkey",
    0x9f7f: "Novice",
    0x7f7f: "Average",
    0x5f7f: "Superior",
    0x3f7f: "Genius",
    0x1f7f: "ESPer",
}


function ratingTest() => dword(0x1de67c)
function resultsOnScreen2() => dword(0x1de660) == 0x91789c4

rich_presence_conditional_display(GameRunning() && resultsOnScreen2(), "🎬-[ Richard's Rating: {0} 🕰️ {1}]-🎬", 
    rich_presence_lookup("Rating", ratingTest(), RatingLookup),
    rich_presence_value("Seconds", totalTime(), format="SECS")    
)

/*

// these are stack frames, so unreliable
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
*/


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


// Roulette, Slots, or Blackjack
rich_presence_conditional_display((CodeFlow() == 0xc8 || CodeFlow() == 0xc9 || CodeFlow() == 0xca), "🤑-[ {0} 🥮:{1} ]-🤑",
    rich_presence_lookup("Special", CodeFlow(), SpecialLookup),
    rich_presence_value("Number", casinoGameChips())
)

//Watching Endings, Credits, or the Theater film
rich_presence_conditional_display((CodeFlow() == 0xdc || CodeFlow() == 0xd2 || CodeFlow() == 0xd3 || CodeFlow() == 0xcd ||
        CodeFlow() == 0xd4
    ), "🎬-[ {0} {1} ]-🎬",
    rich_presence_lookup("Special", CodeFlow(), SpecialLookup),
    rich_presence_lookup("VideoFile", filenamePointerForCdRomVideoPlaying(), VideoFileLookup)
)

// Possessed
rich_presence_conditional_display(GameRunning() && possessed() > 0, "👻-[ POSSESSED Exploring 👻👻👻👻👻 🌎:👻👻👻👻 🩹:👻 👣:👻 🕰️ 👻👻👻👻 💾:👻 ]-👻")

PuzzleLookup = {
    0x06: "Pouring Drinks",
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

// In a puzzle
rich_presence_conditional_display(GameRunning() && playerPuzzleStatus() == 0, "🧩-[ Richard is {0} 🌎:{1} 🩹:{2} 🕰️ {3} 👣:{4} ]-🧩",
    rich_presence_lookup("Puzzle", LocationID(), PuzzleLookup),
    rich_presence_lookup("Weather", weather(), WeatherLookup),
    rich_presence_lookup("PlayerCondition", playerCondition(), PlayerConditionLookup),
    rich_presence_value("Seconds", totalTime(), format="SECS"),
    rich_presence_value("Number", pedometer())
)

// Escaping the orpheus
rich_presence_conditional_display((endGameCountdownTimer() > 0 && playerPuzzleStatus() == 1 && LocationID() != 74), "🚨-[ Richard is trying to Escape the Orpheus 🕙 {0} ⏱️: {1} ]-🚨",
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


rich_presence_conditional_display(word(LocationID() * 36 + 0x082EC4) >= 10 && dword(0x09FB10) == 1 && gametime() > word(0x0000FF), "🔎-[ {0} {1} 🌎:{2} 🩹:{3} 👣:{4} 🕰️ {5} 💾:{6} ]-🔎",
    rich_presence_lookup("Location", LocationID(), LocationLookup),
    rich_presence_lookup("TimeLocation", LocationID(), TimeLocationLookup),
    rich_presence_lookup("Weather", weather(), WeatherLookup),
    rich_presence_lookup("PlayerCondition", playerCondition(), PlayerConditionLookup),
    rich_presence_value("Number", pedometer()),
    rich_presence_value("Seconds", totalTime(), format="SECS"),
    rich_presence_value("Number", numSaves())
)

rich_presence_conditional_display(dword(0x09FB10) == 1 && gametime() > word(0x0000FF), "🔎-[ {0} 🕙 {1} 🌎:{2} 🩹:{3} 👣:{4} 🕰️ {5} 💾:{6} ]-🔎",
    rich_presence_lookup("Location", LocationID(), LocationLookup),
    rich_presence_value("Minutes", gametimebyte() / 2.84444 + low4(0x1A6B31) * 90.0014, format="MINUTES"),
    rich_presence_lookup("Weather", weather(), WeatherLookup),
    rich_presence_lookup("PlayerCondition", playerCondition(), PlayerConditionLookup),
    rich_presence_value("Number", pedometer()),
    rich_presence_value("Seconds", totalTime(), format="SECS"),
    rich_presence_value("Number", numSaves())
)


// this checks LocationTimeID value for the current location
// Any values >= 10 are some date other than the present and Date from lookup table is used
rich_presence_conditional_display(word(LocationID() * 36 + 0x082EC4) >= 10 && dword(0x09FB10) == 1, "🔎-[ {0} {1} 🌎:{2} 🩹:{3} 👣:{4} 🕰️ {5} 💾:{6} ]-🔎",
    rich_presence_lookup("Location", LocationID(), LocationLookup),
    rich_presence_lookup("TimeLocation", LocationID(), TimeLocationLookup),
    rich_presence_lookup("Weather", weather(), WeatherLookup),
    rich_presence_lookup("PlayerCondition", playerCondition(), PlayerConditionLookup),
    rich_presence_value("Number", pedometer()),
    rich_presence_value("Seconds", totalTime(), format="SECS"),
    rich_presence_value("Number", numSaves())
)


rich_presence_conditional_display(dword(0x09FB10) == 1, "🔎-[ {0} 🕙 {1} 🌎:{2} 🩹:{3} 👣:{4} 🕰️ {5} 💾:{6} ]-🔎",
    rich_presence_lookup("Location", LocationID(), LocationLookup),
    rich_presence_value("Minutes", gametimebyte() / 2.84444, format="MINUTES"),
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


PlayingBlackjack                = 0xca
function BlackJackStatus()      => byte(0xA3A68)
function BlackJackPlayerTotal() => byte(0xA3BBD)
function BlackJackDealerTotal() => byte(0xA3BBE)
function BlackJackGamesLost()   => byte(0x9FA21)


leaderboard(
    title="Blackjack Win Streak",
    description="Win as many consecutive hands of blackjack that you can, submits on loss",
    id=124793,
    start=CodeFlow() == PlayingBlackjack && 
              tally(2, (BlackJackStatus() == 2 && prev(BlackJackStatus()) != 2 && BlackJackPlayerTotal() > BlackJackDealerTotal() )) &&
              never(prev(BlackJackGamesLost()) < BlackJackGamesLost()),
    cancel=LocationID() != Casino,
    submit=__ornext((BlackJackStatus() == 2 && BlackJackGamesLost() == 1 && prev(BlackJackGamesLost()) == 0) || CodeFlow() != PlayingBlackjack),
    value=measured(tally(0, once(always_true()),
                 (BlackJackStatus() == 2 && prev(BlackJackStatus()) != 2 && BlackJackPlayerTotal() > BlackJackDealerTotal()), always_false())
             ),
    format="VALUE",
    lower_is_better=false  
)

function grayEndingResults() {
    return GameRunning() && LocationID() == GrayEndingHouse && resultsOnScreen() && prevresultsNotOnScreen()
}

function evilEndingResults() {
    return GameRunning() && LocationID() == House && resultsOnScreen() && prevresultsNotOnScreen()
}

function trueEndingResults() {
    return GameRunning() && LocationID() == CompartmentA && resultsOnScreen() && prevresultsNotOnScreen()
}


leaderboard(
    title="Fastest Finish - Gray Ending",
    description="Beat the game as fast as you can, submits on results screen",
    start=grayEndingResults(),
    submit=grayEndingResults(),
    cancel=always_false(),
    value=measured(totalTime()),
    format="SECS",
    lower_is_better=true
)

leaderboard(
    title="Fastest Finish - True Ending",
    description="Complete the game and watch the true ending as fast as you can, submits on results screen",
    start=trueEndingResults(),
    submit=trueEndingResults(),
    cancel=always_false(),
    value=measured(totalTime()),
    format="SECS",
    lower_is_better=true
)

leaderboard(
    title="Fastest Finish - Evil Ending",
    description="Complete the game and watch the evil ending as fast as you can, submits on results screen",
    start=evilEndingResults(),
    submit=evilEndingResults(),
    cancel=always_false(),
    value=measured(totalTime()),
    format="SECS",
    lower_is_better=true
)










