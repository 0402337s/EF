// Ownership map button
// You can write your code in this editor

draw_sprite(spr_button, "lyr_Map", x, y)

draw_set_font(fnt_button);
draw_set_color(c_maroon)
draw_text(x-55, y-30, "Next Turn");
draw_text(x-50, y+10, "(Turn " + string(Turn_ID) + ")");
