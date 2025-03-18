
# Structs
config_slot_fields = [
    {'name': "InteractionID", 'size': 4},
    {'name': "DataPTR", 'size': 4},
    {'name': "DataPTR2", 'size': 4, 'padding': 4},  # Padding!
    {'name': "FunctionID", 'size': 4},
]

location_spawn_fields = [
    {'name': "Bitflags1", 'size': 1},
    {'name': "Bitflags2", 'size': 1},
]


def generate_struct_array_notes(struct_name, fields, array_length, base_address=0x0):
    """
    Generates code notes for an array of structs, optionally including a list of location names.

    Args:
        struct_name (str): The name of the struct (e.g., "ConfigSlot").
        fields (list): A list of dictionaries, where each dictionary represents a field
                       in the struct.  See previous examples for the structure of the dictionaries.
        array_length (int): The number of elements in the array.
        base_address (int): The base memory address of the struct array. Defaults to 0x0.

    Returns:
        list: A list of strings, where each string is a code note.
    """

    notes = []
    struct_size = calculate_struct_size(fields)  # Calculate the total size of the struct


    for i in range(array_length):
        struct_base_address = base_address + (i * struct_size)
        notes.extend(generate_struct_notes(struct_name, fields, base_address=struct_base_address, array_index=i))
    return notes


def generate_struct_notes(struct_name, fields, base_address=0x0, array_index=None):
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


        #This is where the magic happens, it appends the location information and bitflag information
        current_note = f"N0:0x{base_address + offset:x}:\"[{field_size * 8}-bit] {full_field_name}"
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
config_slot_array_notes = generate_struct_array_notes("ConfigSlot", config_slot_fields, array_length=10, base_address=0x1d8d10)
for note in config_slot_array_notes:
    print(note)

location_spawn_array_notes = generate_struct_array_notes("LocationSpawns", location_spawn_fields, array_length=94, base_address=0x1a4b30)
for note in location_spawn_array_notes:
    print(note)