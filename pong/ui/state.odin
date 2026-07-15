package ui

State :: struct {
    score     : Score,
    running   : bool,
    screen    : Screen,
    theme     : Theme,
    font_size : i32
}

init_state :: proc(screen_width: i32) -> State {
    return State{
        score     = init_score(screen_width, DefaultTheme),
        running   = false,
        screen    = .start,
        theme     = DefaultTheme,
        font_size = i32(32)
    }
}

