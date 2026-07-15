package ui

import rl "vendor:raylib"

Screen :: enum {
    start,
    game,
    pause,
    settings
}

Menu :: struct {
    start_game : bool,
    setting    : bool,
    quit       : bool
}

initial_screen :: proc(state: ^State, width, height: i32) {
    start_text := cstring("Start")
    start_text_size := rl.MeasureText(start_text, state.font_size)

    settings_text := cstring("Settings")
    settings_text_size := rl.MeasureText(settings_text, state.font_size)

    quit_text := cstring("Quit")
    quit_text_size := rl.MeasureText(quit_text, state.font_size)

    spacing := i32(6 + state.font_size)
    size_text := max(start_text_size, quit_text_size, settings_text_size)

    mid_x := i32(width / 2 - size_text  / 2)
    mid_y := i32(height / 2 - state.font_size / 2)
    rl.DrawText(start_text, mid_x, mid_y + spacing, state.font_size, state.theme.text)
    rl.DrawText(settings_text, mid_x, mid_y, state.font_size, state.theme.text)
    rl.DrawText(start_text, mid_x, mid_y - spacing, state.font_size, state.theme.text)
}

change_screen :: proc(screen: Screen, state: ^State) {
    switch screen {
    case .start: 
        if state.screen == .start {
            return
        }
        state.screen = .start
        return
    case .game:
        if state.screen == .game {
            return
        }
        state.screen = .game
        return
    case .pause:
        if state.screen == .pause {
            return
        }
        state.screen = .pause
        return
    case .settings:
        if state.screen == .settings {
            return
        }
        state.screen = .settings
        return
    }
}
