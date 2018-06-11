// Ownership map button
// You can write your code in this editor

Units_to_place = 3;

draw_sprite(spr_button, "lyr_Map", x, y)

draw_set_font(fnt_button);
draw_set_color(c_maroon)
draw_text(x-55, y-30, "Place Unit");
draw_text(x-55, y+10, "(" + string(Units_to_place) + " to place)");
