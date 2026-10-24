package rooms

Door :: struct {
    x: i32          `json:"x"`,
    y: i32          `json:"y"`,
    spawn_x: i32    `json:"spawn_x"`,
    spawn_y: i32    `json:"spawn_y"`,
    target: string  `json:"target"`
}

get_current_door :: proc(r: ^Room, player_x, player_y: i32) -> ^Door {
    doors := r.doors
    founded : ^Door
    for &d in doors {
        if d.x == player_x && d.y == player_y {
            founded = &d
        }
    }
    return founded
}

load_room_from_door :: proc(rooms: ^[]Room, d: ^Door, current_pos: i32) -> ([2]i32, ^Room) {
    room_name := d.target
    spawn := [2]i32{d.spawn_x, d.spawn_y}

    loaded_room: ^Room
    for &room in rooms {
        if string(room.name) == d.target {
            loaded_room = &room
        }
    }

    return spawn, loaded_room
}
