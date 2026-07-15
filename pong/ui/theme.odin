package ui

import rl "vendor:raylib"

Theme :: struct {
    text : rl.Color,
    background : rl.Color,
    player    : rl.Color
}

DefaultTheme :: Theme {
    text       = rl.WHITE,
    background = rl.BLACK,
    player     = rl.WHITE
}

ClearTheme :: Theme {
    text       = rl.BLACK,
    background = rl.WHITE,
    player     = rl.BLACK
}
