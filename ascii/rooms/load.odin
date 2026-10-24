package rooms

import "core:log"
import "core:encoding/json"

import "../file"

GRID_WIDTH : i32 : 30
GRID_HEIGHT : i32 : 9
CELL_SIZE : i32 : 28

DIR_LEVEL :: "./rooms/data"

Grid :: [GRID_HEIGHT][GRID_WIDTH]i32 

Room :: struct {
    id: i32         `json:"id"`,
    name: cstring   `json:"name"`,
    level: i32      `json:"level"`,
    width: i32      `json:"width"`,
    height: i32     `json:"height"`,
    doors: []Door   `json:"doors"`,
    layout: Grid    `json:"layout"`
}

Level :: struct {
    id: i32         `json:"id"`,
    level: i32      `json:"level"`,
    rooms: []Room   `json:"rooms"`
}


// TODO: Verify if it is possible to merge this two functions and use a Generic Type for the output
load_level :: proc(data: []byte) -> (Level, json.Unmarshal_Error) {
    json_data := Level{}
    json_error := json.unmarshal(data, &json_data)
    if json_error != nil {
        log.fatalf("An error occured parsing the json file: \n%v", json_error)
        return Level{}, json_error
    }

    return json_data, nil
}

load_room :: proc(data: []byte) -> (Room, json.Unmarshal_Error) {
    json_data := Room{}
    json_error := json.unmarshal(data, &json_data)
    if json_error != nil {
        log.fatalf("An error occured parsing the json file: \n%v", json_error)
        return Room{}, json_error
    }

    return json_data, nil
}

load_room_from_file :: proc(f: string)-> (Room, json.Unmarshal_Error) {
    buf := file.read_file(f)
    defer delete(buf)

    room, err := load_room(buf)
    if err != nil {
        log.fatalf("an error occured loading the room: %v", room)
        return Room{}, err
    }
    return room, nil
}

load_starter_room :: proc(rooms: ^[]Room) -> ^Room {
    for &room in rooms {
        if room.name == "starter_room" {
            return &room
        }
    }
    return nil
}
