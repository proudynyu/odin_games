package ui

import "core:strings"
import rl "vendor:raylib"
import "core:fmt"

PlayerScore :: struct {
    value: int,
    pos_x: i32,
    pos_y: i32
}

new_player_score :: proc(x, y: i32) -> PlayerScore {
    return PlayerScore{
        value = 0,
        pos_y = y,
        pos_x = x
    }
}

Score :: struct {
    left_player  : PlayerScore,
    right_player : PlayerScore,
    text_color   : rl.Color
}

init_score :: proc(win_width: i32, theme: Theme) -> Score {
    y_pos : i32 = 16
    x_left_pos : i32 = 16
    x_right_pos := i32(win_width - 16)
    left_player := new_player_score(x_left_pos, y_pos)
    right_player := new_player_score(x_right_pos, y_pos)

    return Score {
        left_player = left_player,
        right_player = right_player,
        text_color = theme.text
    }
}

draw_score :: proc(s: ^Score) {
    font_size := i32(32)
    left      := s.left_player
    right     := s.right_player

    buf := strings.Builder{}

    left_score := strings.clone_to_cstring(fmt.sbprintf(&buf, "%s", left.value))
    right_score := strings.clone_to_cstring(fmt.sbprintf(&buf, "%s", right.value))
    rl.DrawText(left_score, left.pos_x, left.pos_y, font_size, s.text_color)
    rl.DrawText(right_score, right.pos_x, right.pos_y, font_size, s.text_color)
}
