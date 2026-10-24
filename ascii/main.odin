package main

import "core:log"
import rl "vendor:raylib"

import "rooms"
import "rooms/level"

GRID_WIDTH :: rooms.GRID_WIDTH
GRID_HEIGHT :: rooms.GRID_HEIGHT
CELL_SIZE :: rooms.CELL_SIZE

Player :: struct {
    x: i32,
    y: i32
}

draw_grid :: proc(current_room: ^rooms.Room) {
    for y:i32=0; y < GRID_HEIGHT; y+=1 {
        for x:i32=0; x < GRID_WIDTH; x+=1 {
            pos_x := x * CELL_SIZE
            pos_y := y * CELL_SIZE

            if current_room.layout[y][x] == 1 {
                rl.DrawRectangle(pos_x, pos_y, CELL_SIZE, CELL_SIZE, (rl.Color){ 20, 20, 20, 255 })
                rl.DrawText("#", pos_x + 8, pos_y + 4, 20, rl.DARKGRAY)
            } else if current_room.layout[y][x] == 2 {
                rl.DrawRectangle(pos_x, pos_y, CELL_SIZE, CELL_SIZE, (rl.Color){ 20, 20, 20, 255 })
                rl.DrawText("D", pos_x + 8, pos_y + 4, 20, rl.DARKGRAY)
            }else {
                rl.DrawText(".", pos_x + 10, pos_y + 6, 16, (rl.Color){ 50, 50, 50, 255 })
            }
        }
    }
}

update :: proc(p: ^Player, level_rooms: ^[]rooms.Room) {
    starter_room := rooms.load_starter_room(level_rooms)
    current_room := starter_room

    for {
            if rl.WindowShouldClose() {
                break
            }

            next_x := p.x
            next_y := p.y

            if rl.IsKeyPressed(.RIGHT) || rl.IsKeyPressed(.D) { next_x+=1 }
            if rl.IsKeyPressed(.LEFT) || rl.IsKeyPressed(.A) { next_x-=1 }
            if rl.IsKeyPressed(.DOWN) || rl.IsKeyPressed(.S) { next_y+=1 }
            if rl.IsKeyPressed(.UP) || rl.IsKeyPressed(.W) { next_y-=1 }

            current_pos := current_room.layout[next_y][next_x]

            if current_pos == 2  {
                door := rooms.get_current_door(current_room, next_y, next_x)
                if door == nil {
                    log.fatal("Could not load the correct door")
                    break
                }

                spawn, loaded_room := rooms.load_room_from_door(level_rooms, door, current_pos)
                current_room = loaded_room
                next_x := spawn.x
                next_y := spawn.y
                // if current_room == left_room {
                //     current_room = starter_room 
                //     next_x = left_border
                // } else if current_room == right_room {
                //     current_room = starter_room
                //     next_x = right_border
                // } else
                // if current_room == starter_room {
                //     if next_x == GRID_WIDTH - 1 {
                //         current_room = right_room
                //         next_x = left_border 
                //     }
                //     if next_x == 0 {
                //         current_room = left_room
                //         next_x = right_border
                //     } 
                // } 
            }

            if current_room.layout[next_y][next_x] == 0 {
                p.y = next_y
                p.x = next_x
            }

            rl.BeginDrawing()
            defer rl.EndDrawing()

            rl.ClearBackground(rl.BLACK)


            player_px_x := p.x * CELL_SIZE
            player_px_y := p.y * CELL_SIZE

            rl.DrawText("@", player_px_x + 6, player_px_y + 2, 22, rl.YELLOW)
    }
}

main :: proc() {
    screen_width := GRID_WIDTH * CELL_SIZE
    screen_height := GRID_HEIGHT * CELL_SIZE

    rl.InitWindow(screen_width, screen_height, "Ascii Game")
    defer rl.CloseWindow()

    rl.SetTargetFPS(60)

    player := Player { 3, 3 }

    level_1 := level.load_level_1()
    update(&player, &level_1)
}
