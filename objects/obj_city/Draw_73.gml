/// @description Insert description here
// You can write your code in this editor

if Mouse_over == true
{
	var hh = ds_grid_height(obj_backgroundScotland.cities);
	for (var i = 1; i < hh; i++;) //Starts counting from 0?
	{
		var x_pos = real(obj_backgroundScotland.cities[# 3, i]);
		var y_pos = real(obj_backgroundScotland.cities[# 4, i]);

		if (mouse_x >= x_pos - 10 && mouse_x < x_pos + 10 &&
			mouse_y >= y_pos - 10 && mouse_y < y_pos + 10)
		{
			var City_Name = obj_backgroundScotland.cities[# 1, i];
			var City_Population = obj_backgroundScotland.cities[# 2, i];
				
			draw_set_colour(c_yellow);
			if i == obj_gameVariables.PlayerCity
			{
				draw_set_colour(c_silver);
			}
			draw_set_alpha(0.5);
			draw_rectangle(x + 30, y, x + 200, y + 100, false)

			draw_set_font(fnt_button);
			draw_set_color(c_maroon)
			draw_text(x + 40, y + 10, City_Name)
			draw_text(x + 40, y + 35, string("Units = " + City_Population))
		}
	}
}

draw_set_alpha(1);