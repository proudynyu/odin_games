package main

import "core:fmt"
import rl "vendor:raylib"

import "ui"

WIDTH :: 800
HEIGHT :: 600
TITLE :: "Pong game";

start_game :: proc(state: ^ui.State) {
    ui.change_screen(.start, state)
}


main :: proc() {
    rl.InitWindow(WIDTH, HEIGHT, TITLE)
    defer rl.CloseWindow()

    rl.SetTargetFPS(60)
    state := ui.init_state(WIDTH)

    for {
        if rl.WindowShouldClose() {
            break
        }

        rl.BeginDrawing()
        defer rl.EndDrawing()
        rl.ClearBackground(state.theme.background)

        ui.initial_screen(&state, WIDTH, HEIGHT)
    }
    fmt.println("Hello, world!")
}
