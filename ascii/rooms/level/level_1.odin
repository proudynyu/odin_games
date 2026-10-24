package level

import "core:log"
import "core:strings"

import "../../file"
import "../../rooms"

DIR_PATH :: "./rooms/data/level_1/"

ROOMS :: []string{
    "starter_room.json",
    "left_room.json",
    "right_room.json"
}

load_level_1 :: proc() -> []rooms.Room {
    log.info("Loading level 1")
    level_rooms := make([]string, len(ROOMS))
    for r, idx in ROOMS {
        level_rooms[idx] = strings.concatenate([]string{DIR_PATH, r})
    }

    rooms_buffer := make([]rooms.Room, len(ROOMS))
    for r, idx in level_rooms {
        buf := file.read_file(r)
        if buf == nil {
            log.fatalf("an error occured reading the file: %v", r)
            continue
        }

        room, err := rooms.load_room(buf)
        if err != nil {
            log.fatalf("an error occured loading the room: %v -> file:  %v", room, r)
            continue
        }
        rooms_buffer[idx] = room
    }
    return rooms_buffer
}
