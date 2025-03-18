# Structs
config_slot_fields = [
    {'name': "InteractionID", 'size': 4},
    {'name': "DataPTR", 'size': 4},
    {'name': "DataPTR2", 'size': 4, 'padding': 4},  # Padding!
    {'name': "FunctionID", 'size': 4, 'padding': 1796 },
]

location_spawn_fields = [
    {'name': "Bitflags1", 'size': 1},
    {'name': "Bitflags2", 'size': 1},
]


location_names = [
    "Upr Deck - Pilothouse",  # 0x00
    "Upr Deck - Passageway Outside",  # 0x01
    "Upr Deck - Chart Room",  # 0x02
    "Upr Deck - Captain's Cabin",  # 0x03
    "Upr Deck - Compartment",  # 0x04
    "Floor 1 - Reading Room",  # 0x05
    "Floor 1 - Lounge",  # 0x06
    "Floor 1 - Electrical Room",  # 0x07
    "Floor 1 - Grand Dining Room",  # 0x08
    "Upr Deck - Passageway Inside",  # 0x09
    "Floor 1 - Engineer Hallway",  # 0x0a
    "Floor 1 - Passenger Hallway",  # 0x0b
    "Floor 1 - Guest Hallway",  # 0x0c
    "Floor 1 - Dining Room Hallway",  # 0x0d
    "Floor 2 - Child Room",  # 0x0e
    "Floor 1 - Guest Room A",  # 0x0f
    "Floor 1 - Guest Room B",  # 0x10
    "Floor 1 - Guest Room C",  # 0x11
    "Floor 1 - Guest Room D",  # 0x12
    "Floor 1 - Special Guest Room",  # 0x13
    "The Past - Pier",  # 0x14
    "Floor 2 - Medical Office",  # 0x15
    "The Past - Castle",  # 0x16
    "The Past - Castle Terrace",  # 0x17
    "The Past - Laboratory",  # 0x18
    "Floor 2 - Theater",  # 0x19
    "Floor 2 - Mess Room",  # 0x1a
    "Floor 1 - Stairway",  # 0x1b
    "Floor 2 - Engineer's Room",  # 0x1c
    "Lwr Deck - Pool",  # 0x1d
    "Floor 1 - Dining Room Galley",  # 0x1e
    "Floor 2 - Casino",  # 0x1f
    "Floor 2 - Radio Room",  # 0x20
    "The Past - Steam Locomotive",  # 0x21
    "Floor 2 - Shower Room",  # 0x22
    "Floor 2 - Bathroom",  # 0x23
    "Floor 2 - Port Corridor",  # 0x24
    "Floor 2 - Starboard Corridor",  # 0x25
    "Floor 2 - Engine Corridor",  # 0x26
    "Lwr Deck - Deck Terrace",  # 0x27
    "Floor 1 - Private Quarters",  # 0x28
    "The Past - Cathedral",  # 0x29
    "Floor 2 - Theater Hallway",  # 0x2a
    "The Past - Cemetery Graveyard",  # 0x2b
    "Lwr Deck - Terrace Lazarette",  # 0x2c
    "Floor 2 - Crew's Corridor",  # 0x2d
    "Lwr Deck - Stern Passageway",  # 0x2e
    "Floor 1 - Water Room",  # 0x2f
    "Floor 1 - Forest Room",  # 0x30
    "Floor 1 - Sky Room",  # 0x31
    "Floor 1 - Fire Room",  # 0x32
    "Floor 1 - Owner's Quarters",  # 0x33
    "Floor 2 - Crew's Quarters B",  # 0x34
    "Floor 2 - Crew's Quarters A",  # 0x35
    "The Past - Library",  # 0x36
    "Father's House",  # 0x37
    "Living Room",  # 0x38
    "Basement",  # 0x39
    "The Past - Abandoned Mine A",  # 0x3a
    "The Past - Abandoned Mine B",  # 0x3b
    "the Past - Abandoned Mine C",  # 0x3c
    "The Past - Observatory A",  # 0x3d
    "The Past - Observatory B",  # 0x3e
    "The Past - Cemetery Crypt A",  # 0x3f
    "The Past - Cemetery Crypt B",  # 0x40
    "Floor 3 - Engine Room B",  # 0x41
    "Floor 3 - Engine Room A",  # 0x42
    "Floor 3 - Stern Passageway",  # 0x43
    "Floor 3 - Boiler A",  # 0x44
    "Floor 3 - Boiler B",  # 0x45
    "Floor 3 - Fuel Storage",  # 0x46
    "The Past - Cathedral Basement",  # 0x47
    "Floor 3 - Compartment B",  # 0x48
    "The Past - Cathedral Stairway",  # 0x49
    "Floor 3 - Compartment A",  # 0x4a
    "The Past - Amusement Park Fountain",  # 0x4b
    "The Past - Amusement Park Carousel",  # 0x4c
    "The Past - King's Quarters",  # 0x4d
    "Lwr Deck - Corridor to Pool",  # 0x4e
    "The Past - House",  # 0x4f
    "The Past - Valley",  # 0x50
    "a Cutscene: Flyby The Orpheus",  # 0x51
    "a Cutscene: Flyby The House",  # 0x52
    "a Cutscene: Going into the Cathedral",  # 0x53
    "a Cutscene: Train heading into tunnel",  # 0x54
    "a Cutscene: Boarding the Train",  # 0x55
    "a Cutscene: Driving to the House",  # 0x56
    "House(Gray Ending)",  # 0x57
    "a Cutscene: Flyby The Library",  # 0x58
    "a Cutscene: Going into the Abandoned Mine",  # 0x59
    "a Cutscene: Flyby The Castle",  # 0x5a
    "a Cutscene: Flyby The Observatory",  # 0x5b
    "????",  # 0x5c
    "The Past - House(Outside)"  # 0x5d
]





spawnFlags = [
    {"location": 0x00, "field_name": "Bitflags1", "bit": 0, "description": "metal handle"},
    {"location": 0x00, "field_name": "Bitflags1", "bit": 1, "description": "metal handle being attached (temporary)"},
    {"location": 0x00, "field_name": "Bitflags1", "bit": 2, "description": "ship map"},
    {"location": 0x00, "field_name": "Bitflags1", "bit": 3, "description": "cure potion in cabinet 1"},
    {"location": 0x00, "field_name": "Bitflags1", "bit": 4, "description": "cure potion in cabinet 2"},
    {"location": 0x01, "field_name": "Bitflags1", "bit": 0, "description": "Greg Capstan (captain) astral piece"},
    {"location": 0x01, "field_name": "Bitflags1", "bit": 1, "description": "John Cutter astral piece"},
    {"location": 0x02, "field_name": "Bitflags1", "bit": 0, "description": "Billy Bollard Astral Piece"},
    {"location": 0x02, "field_name": "Bitflags1", "bit": 1, "description": "Iron Key"},
    {"location": 0x03, "field_name": "Bitflags1", "bit": 0, "description": "wire (after its cut off)"},
    {"location": 0x03, "field_name": "Bitflags1", "bit": 1, "description": "cure potion in drawer"},
    {"location": 0x03, "field_name": "Bitflags1", "bit": 2, "description": "leather organizer"},
    {"location": 0x03, "field_name": "Bitflags1", "bit": 3, "description": "comet book"},
    {"location": 0x04, "field_name": "Bitflags1", "bit": 0, "description": "wire cutters"},
    {"location": 0x05, "field_name": "Bitflags1", "bit": 0, "description": "Sailor Medal A is in a flag statue"},
    {"location": 0x05, "field_name": "Bitflags1", "bit": 1, "description": "Sailor Medal B is in a flag statue"},
    {"location": 0x05, "field_name": "Bitflags1", "bit": 2, "description": "Sailor Medal C is in a flag statue"},
    {"location": 0x05, "field_name": "Bitflags1", "bit": 3, "description": "Sailor Medal D is in a flag statue"},
    {"location": 0x05, "field_name": "Bitflags1", "bit": 4, "description": "Sailor Medal A (duct)"},
    {"location": 0x05, "field_name": "Bitflags1", "bit": 5, "description": "Brass Key"},
    {"location": 0x05, "field_name": "Bitflags1", "bit": 6, "description": "Ed Mooring Astral piece"},
    {"location": 0x06, "field_name": "Bitflags1", "bit": 0, "description": "claim ticket (far left under bar)"},
    {"location": 0x08, "field_name": "Bitflags1", "bit": 0, "description": "fire bird plate (after talking to ghost couple)"},
    {"location": 0x08, "field_name": "Bitflags1", "bit": 1, "description": "claim ticket (on table opposite the kitchen door)"},
    {"location": 0x0a, "field_name": "Bitflags1", "bit": 0, "description": "Robert Danforth Astral Piece"},
    {"location": 0x0c, "field_name": "Bitflags1", "bit": 0, "description": "glass"},
    {"location": 0x0c, "field_name": "Bitflags1", "bit": 1, "description": "Sailor medal B"},
    {"location": 0x0c, "field_name": "Bitflags1", "bit": 2, "description": "Robb Derick astral piece"},
    {"location": 0x0d, "field_name": "Bitflags1", "bit": 1, "description": "Peter Schooner astral piece"},
    {"location": 0x0e, "field_name": "Bitflags1", "bit": 0, "description": "record on the record player"},
    {"location": 0x0e, "field_name": "Bitflags1", "bit": 1, "description": "crown inserted in the chest"},
    {"location": 0x0e, "field_name": "Bitflags1", "bit": 2, "description": "Karen Moulding astral piece"},
    {"location": 0x0e, "field_name": "Bitflags1", "bit": 3, "description": "Fred Moulding astral piece"},
    {"location": 0x0e, "field_name": "Bitflags1", "bit": 4, "description": "Film (inside chest)"},
    {"location": 0x0e, "field_name": "Bitflags1", "bit": 5, "description": "Crown piece"},
    {"location": 0x0e, "field_name": "Bitflags1", "bit": 6, "description": "Gear (inside chest)"},
    {"location": 0x11, "field_name": "Bitflags1", "bit": 0, "description": "Sailor Medal C"},
    {"location": 0x11, "field_name": "Bitflags1", "bit": 1, "description": "Cure Potion (drawer)"},
    {"location": 0x11, "field_name": "Bitflags1", "bit": 2, "description": "Fiana Parcelling astral piece"},
    {"location": 0x12, "field_name": "Bitflags1", "bit": 0, "description": "Sailor Medal D"},
    {"location": 0x12, "field_name": "Bitflags1", "bit": 1, "description": "Cure Potion (drawer)"},
    {"location": 0x12, "field_name": "Bitflags1", "bit": 2, "description": "Diana Parcelling astral piece"},
    {"location": 0x13, "field_name": "Bitflags1", "bit": 0, "description": "Dress Suit"},
    {"location": 0x13, "field_name": "Bitflags1", "bit": 1, "description": "Claim Ticket (bathroom floor)"},
    {"location": 0x13, "field_name": "Bitflags1", "bit": 2, "description": "Claudia's Doll"},
    {"location": 0x14, "field_name": "Bitflags1", "bit": 0, "description": "rubber gloves"},
    {"location": 0x15, "field_name": "Bitflags1", "bit": 0, "description": "curing potion (drawer)"},
    {"location": 0x15, "field_name": "Bitflags1", "bit": 1, "description": "curing potion (cabinet)"},
    {"location": 0x15, "field_name": "Bitflags1", "bit": 2, "description": "antidote (locked in cabinet drawer)"},
    {"location": 0x18, "field_name": "Bitflags1", "bit": 0, "description": "Prescription (drawer by microscope)"},
    {"location": 0x19, "field_name": "Bitflags1", "bit": 0, "description": "Record (film booth)"},
    {"location": 0x19, "field_name": "Bitflags1", "bit": 1, "description": "Scott Garboard astral piece"},
    {"location": 0x19, "field_name": "Bitflags1", "bit": 2, "description": "Thomas Gusset astral piece"},
    {"location": 0x19, "field_name": "Bitflags1", "bit": 4, "description": "claim ticket (on purple sofa in main theater)"},
    {"location": 0x19, "field_name": "Bitflags1", "bit": 5, "description": "Cabinet Key"},
    {"location": 0x1c, "field_name": "Bitflags1", "bit": 0, "description": "Martin Backstaff Astral Piece"},
    {"location": 0x1c, "field_name": "Bitflags1", "bit": 1, "description": "curing potion (in back room chest)"},
    {"location": 0x1d, "field_name": "Bitflags1", "bit": 1, "description": "claim ticket (in locker starboard side lockerroom)"},
    {"location": 0x1d, "field_name": "Bitflags1", "bit": 2, "description": "curing potion (far left locker in the port side lockerroom)"},
    {"location": 0x1e, "field_name": "Bitflags1", "bit": 0, "description": "water plate"},
    {"location": 0x1e, "field_name": "Bitflags1", "bit": 1, "description": "Ernest Ullage Astral piece"},
    {"location": 0x1f, "field_name": "Bitflags1", "bit": 0, "description": "Claim ticket (on the ground by the roulette table)"},
    {"location": 0x1f, "field_name": "Bitflags1", "bit": 1, "description": "Elizabeth Crownest Blackjack Dealer Astral piece"},
    {"location": 0x1f, "field_name": "Bitflags1", "bit": 2, "description": "Poly Owning Casino Manager Astral piece"},
    {"location": 0x1f, "field_name": "Bitflags1", "bit": 3, "description": "Tom Rudder Roulette Dealer Astral piece"},
    {"location": 0x20, "field_name": "Bitflags1", "bit": 0, "description": "Music Box"},
    {"location": 0x20, "field_name": "Bitflags1", "bit": 1, "description": "Forest Fire Plate"},
    {"location": 0x20, "field_name": "Bitflags1", "bit": 2, "description": "Oscar Rockwell Astral Piece"},
    {"location": 0x21, "field_name": "Bitflags1", "bit": 1, "description": "blue stone (henry gives to crea)"},
    {"location": 0x21, "field_name": "Bitflags1", "bit": 2, "description": "crank  (only spawns after the conductor gets knocked out)"},
    {"location": 0x21, "field_name": "Bitflags1", "bit": 3, "description": "crank opening the lid of the train car"},
    {"location": 0x22, "field_name": "Bitflags1", "bit": 0, "description": "Curing potion  (middle locker)"},
    {"location": 0x23, "field_name": "Bitflags1", "bit": 0, "description": "Claim ticket (last toilet stall)"},
    {"location": 0x27, "field_name": "Bitflags1", "bit": 0, "description": "Eye of a Sea Fish"},
    {"location": 0x2c, "field_name": "Bitflags1", "bit": 0, "description": "Emllie Scuttle astral piece"},
    {"location": 0x2c, "field_name": "Bitflags1", "bit": 1, "description": "Pendant being given to ghost"},
    {"location": 0x2d, "field_name": "Bitflags1", "bit": 0, "description": "Mike Transom Astral Piece"},
    {"location": 0x2d, "field_name": "Bitflags1", "bit": 1, "description": "Charlie Girder Astral Piece"},
    {"location": 0x2f, "field_name": "Bitflags1", "bit": 0, "description": "clock key (on table main room)"},
    {"location": 0x2f, "field_name": "Bitflags1", "bit": 1, "description": "curing potion (ground in bedroom)"},
    {"location": 0x30, "field_name": "Bitflags1", "bit": 0, "description": "Emilia Rockwell astral piece"},
    {"location": 0x32, "field_name": "Bitflags1", "bit": 0, "description": "Jack Rockwell astral piece"},
    {"location": 0x32, "field_name": "Bitflags1", "bit": 1, "description": "claim ticket (on large bed)"},
    {"location": 0x33, "field_name": "Bitflags1", "bit": 0, "description": "engine room key"},
    {"location": 0x34, "field_name": "Bitflags1", "bit": 0, "description": "sailors document"},
    {"location": 0x36, "field_name": "Bitflags1", "bit": 0, "description": "Old Book (in bin)"},
    {"location": 0x37, "field_name": "Bitflags1", "bit": 0, "description": "red book"},
    {"location": 0x37, "field_name": "Bitflags1", "bit": 1, "description": "winding key"},
    {"location": 0x37, "field_name": "Bitflags1", "bit": 2, "description": "Knife after killing the policeman (evil ending)"},
    {"location": 0x38, "field_name": "Bitflags1", "bit": 0, "description": "small key on table"},
    {"location": 0x3c, "field_name": "Bitflags1", "bit": 0, "description": "Claudia's Doll"},
    {"location": 0x3e, "field_name": "Bitflags1", "bit": 0, "description": "red stone"},
    {"location": 0x40, "field_name": "Bitflags1", "bit": 0, "description": "plate in wall"},
    {"location": 0x40, "field_name": "Bitflags1", "bit": 1, "description": "pendant"},
    {"location": 0x44, "field_name": "Bitflags1", "bit": 0, "description": "piston key"},
    {"location": 0x44, "field_name": "Bitflags1", "bit": 1, "description": "curing potion (floor at bottom of stairs)"},
    {"location": 0x47, "field_name": "Bitflags1", "bit": 0, "description": "showing blue stone fragment to crea"},
    {"location": 0x48, "field_name": "Bitflags1", "bit": 0, "description": "Valve"},
    {"location": 0x48, "field_name": "Bitflags1", "bit": 1, "description": "Knife (in secret room during final sequence)"},
    {"location": 0x4c, "field_name": "Bitflags1", "bit": 0, "description": "engagement ring"},
    {"location": 0x4d, "field_name": "Bitflags1", "bit": 0, "description": "cameo falls out after touching  king corpse"},
    {"location": 0x4f, "field_name": "Bitflags1", "bit": 0, "description": "bullet on the table"},
    {"location": 0x57, "field_name": "Bitflags1", "bit": 0, "description": "knife in trunk"},
    {"location": 0x5d, "field_name": "Bitflags1", "bit": 0, "description": "blue stone piece"}
]


def find_bitflags(location_id, field_name, bitflag_list):
    """
    Finds all bitflag entries in a list that match a given location ID and field name.

    Args:
        location_id (int): The ID of the location to search for.
        field_name (str): The name of the field to search for (e.g., "Bitflags1").
        bitflag_list (list): The list of bitflag dictionaries to search.

    Returns:
        list: A list of bitflag dictionaries that match the specified criteria.  Returns an empty list if no matches are found.
    """
    matching_bitflags = [
        flag for flag in bitflag_list
        if flag["location"] == location_id and flag["field_name"] == field_name
    ]
    return matching_bitflags


def generate_struct_array_notes(struct_name, fields, array_length, base_address=0x0, location_names=None, reference_notes=False):
    """
    Generates code notes for an array of structs, optionally including a list of location names and the ability to
    add references to the notes from the base address.

    Args:
        struct_name (str): The name of the struct (e.g., "ConfigSlot").
        fields (list): A list of dictionaries, where each dictionary represents a field
                       in the struct.  See previous examples for the structure of the dictionaries.
        array_length (int): The number of elements in the array.
        base_address (int): The base memory address of the struct array. Defaults to 0x0.
        location_names (list of str, optional): A list of location names, one for each element in the array.
                                                 Defaults to None (no location names). If provided, the length of
                                                 this list MUST match array_length.
        reference_notes (bool, optional): Whether to add references to the notes from the base address.
                                            Defaults to False.

    Returns:
        list: A list of strings, where each string is a code note.
    """

    notes = []
    struct_size = calculate_struct_size(fields)  # Calculate the total size of the struct

    if location_names and len(location_names) != array_length:
        raise ValueError("Length of location_names list must match array_length")

    for i in range(array_length):
        struct_base_address = base_address + (i * struct_size)
        location_name = location_names[i] if location_names else None  # Get location name for this index
        notes.extend(generate_struct_notes(struct_name, fields, base_address=struct_base_address, array_index=i, location_name=location_name, array_base_address=base_address if reference_notes else None))  # Pass location_name
    return notes


def generate_struct_notes(struct_name, fields, base_address=0x0, array_index=None, location_name=None, array_base_address=None):
    """
    Generates code notes for a single struct (helper function).
    """
    notes = []
    offset = 0
    for field in fields:
        field_name = field['name']
        field_size = field['size']
        padding = field.get('padding', 0)

        # Construct the full field name with the array index, if applicable
        if array_index is not None:
            full_field_name = f"{struct_name}[{array_index:x}].{field_name}"
        else:
            full_field_name = f"{struct_name}.{field_name}"

        # Add the location name to the note, if provided
        if location_name:
            location_string = f" {location_name}"
        else:
            location_string = ""

        #This is where the magic happens, it appends the location information and bitflag information
        current_note = f"N0:0x{base_address + offset:x}:\"[{field_size * 8}-bit] {full_field_name}{location_string}"

        # If it's not the first element in the array, add a reference note
        if array_base_address is not None and array_index != 0:
            current_note += f"\\r\\nSee 0x{array_base_address + offset:x} note for details"

        #Find relevant
        relevant_bitflags = find_bitflags(array_index, field_name, spawnFlags)

        #Loop though all matched bits and make them strings
        bitflag_strings = []
        for bitflag in relevant_bitflags:
            bitflag_strings.append(f"bit{bitflag['bit']}={bitflag['description']}") #Append to the bits

        #add bitstring together
        if bitflag_strings:
            bitflag_string = "\\r\\n" + "\\r\\n".join(bitflag_strings)
            current_note+=bitflag_string
        #add the end point
        current_note+='\"'
        notes.append(current_note)


        offset += field_size + padding
    return notes


def calculate_struct_size(fields):
    """
    Calculates the total size of the struct in bytes, including padding.
    """
    total_size = 0
    for field in fields:
        total_size += field['size'] + field.get('padding', 0)
    return total_size


# Generate notes for an array of 10 ConfigSlot structs
config_slot_array_notes = generate_struct_array_notes("ConfigSlot", config_slot_fields, array_length=10, base_address=0x1d8d10, reference_notes=True)
for note in config_slot_array_notes:
    print(note)

# Generate notes for array of 94 location spawns
location_spawn_notes = generate_struct_array_notes("LocationSpawns", location_spawn_fields, array_length=94, base_address=0x1a4a68, location_names=location_names)
for note in location_spawn_notes:
    print(note)