/// @description Insert description here
// You can write your code in this editor

//I'll need drawing options for cities, units and muli-object selection

if num_on_same_tile == 0
{
	Multi_draw = false;
	City_draw = false;
	Unit_draw = false;
}
else if num_on_same_tile == 1
{
	// only 1 thing on tile, show that:
	if Type_on_same_tile[0] == "City"
	{
		Multi_draw = false;
		City_draw = true;
		Unit_draw = false;
	}
	else if Type_on_same_tile[0] == "Unit"
	{
		Multi_draw = false;
		City_draw = false;
		Unit_draw = true;
	}
	Mouse_click_ID = ID_on_same_tile[0];
}
else if num_on_same_tile > 1
{
	Multi_draw = true;
	City_draw = false;
	Unit_draw = false;
}

if Multi_draw == true
{
	draw_set_colour(c_silver);
	draw_set_alpha(0.9);
	draw_rectangle(TL_corner_X, TL_corner_Y, BR_corner_X, BR_corner_Y, false)
			
	draw_set_font(fnt_button);
	for (var i = 0; i < num_on_same_tile; i += 1)
	{
		if mouse_x >= TL_corner_X + 30 && mouse_x <= TL_corner_X + 200 &&
		mouse_y >= TL_corner_Y + 10 + i * 30 && mouse_y <= TL_corner_Y + 30 + i * 30 
		//if mouse over, then highlight that text		
		{
			draw_set_color(c_black)
			// if there's a mouse click on this, then select that object:
			if (mouse_check_button_released(mb_left) == true)
			{
				num_on_same_tile = 1;
				Type_on_same_tile[0] = Type_on_same_tile[i];
				Name_on_same_tile[0] = Name_on_same_tile[i]; 
				ID_on_same_tile[0] = ID_on_same_tile[i]; 
				break;
			}
		}
		else
		{
			draw_set_color(c_maroon)
		}
		draw_text(TL_corner_X + 40, TL_corner_Y + 10 + i * 30, string(Name_on_same_tile[i]))
	}
}
else if City_draw == true
{
	//var i = Mouse_click_ID;

	var x_pos = real(obj_backgroundScotland.cities[# 3, ID_on_same_tile[0]]);
	var y_pos = real(obj_backgroundScotland.cities[# 4, ID_on_same_tile[0]]);

	//to work out which city it is we are returning to...
	var City_Name = obj_backgroundScotland.cities[# 1, ID_on_same_tile[0]];
	var City_Population = obj_backgroundScotland.cities[# 2, ID_on_same_tile[0]];
	
	draw_set_colour(c_yellow);
	if ID_on_same_tile[0] == obj_gameVariables.PlayerCity
	{
		draw_set_colour(c_silver);
	}
	draw_set_alpha(0.9);
	//draw_rectangle(x + 30, y, x + 200, y + 100, false)
	draw_rectangle(TL_corner_X, TL_corner_Y, BR_corner_X, BR_corner_Y, false)

	draw_set_font(fnt_button);
	draw_set_color(c_maroon)
	
	draw_text(TL_corner_X + 40, TL_corner_Y + 10, City_Name)
	draw_text(TL_corner_X + 40, TL_corner_Y + 35, string("Units = " + City_Population))
	if ID_on_same_tile[0] == obj_gameVariables.PlayerCity
	{
		if real(City_Population) > 0
		{
			draw_button(TL_corner_X + 40, TL_corner_Y + 60, TL_corner_X + 190, TL_corner_Y + 90, !mouse_check_button(mb_left))
			draw_set_color(c_black)
			draw_text(TL_corner_X + 45, TL_corner_Y + 65, string("Place Unit?"))
			//if we press place unit button:
			if (mouse_check_button(mb_left) && mouse_x >= 750 + 40 &&
				mouse_y >= TL_corner_Y + 60 && mouse_x <= TL_corner_X + 190 && mouse_y <=  TL_corner_Y + 90)
			{
				obj_backgroundScotland.cities[# 2, ID_on_same_tile[0]] = string(real(obj_backgroundScotland.cities[# 2, ID_on_same_tile[0]]) - 1);
				scr_createUnit();
				mouse_clear(mb_any)
			}
		}
		else
		{
			draw_set_color(c_black)
			draw_text(TL_corner_X + 45, TL_corner_Y + 65, string("No Units Left"))
		}
	}
	//City_draw = false;
}
else if Unit_draw == true
{
	draw_set_colour(c_silver);
	draw_set_alpha(0.9);
	draw_rectangle(TL_corner_X, TL_corner_Y, BR_corner_X, BR_corner_Y, false)
	
	draw_set_font(fnt_button);
	draw_set_color(c_maroon)
	draw_text(TL_corner_X + 40, TL_corner_Y + 10, Name_on_same_tile[0]);
	draw_text(TL_corner_X + 40, TL_corner_Y + 50, string("Effectiveness = " + string(obj_unit.Effectiveness[ID_on_same_tile[0]])));
	draw_text(TL_corner_X + 40, TL_corner_Y + 80, string("Mobility = " + string(obj_unit.Mobility[ID_on_same_tile[0]])));
	draw_text(TL_corner_X + 40, TL_corner_Y + 110, string("Influence = " + string(obj_unit.Influence[ID_on_same_tile[0]])));
	
	//if there is some movement logged, draw an arrow:
	if (obj_unit.Move_X[ID_on_same_tile[0]] != 0 && obj_unit.Move_Y[ID_on_same_tile[0]] != 0)
	{
		draw_set_color(c_black)
		//draw_arrow(obj_unit.X_Pos[ID_on_same_tile[0]], obj_unit.Y_Pos[ID_on_same_tile[0]], 
		//obj_unit.Move_X[ID_on_same_tile[0]], obj_unit.Move_Y[ID_on_same_tile[0]], 20);
		var Move_X_temp = obj_unit.Move_X[ID_on_same_tile[0]];
		var Move_Y_temp = obj_unit.Move_Y[ID_on_same_tile[0]];
		for (var i = 0; i < array_length_1d(Move_X_temp) - 1; i += 1)
		{
			draw_arrow(Move_X_temp[i], Move_Y_temp[i], Move_X_temp[i+1], Move_Y_temp[i+1], 20);
		}
		//draw_path(obj_backgroundScotland.path, obj_unit.X_Pos[ID_on_same_tile[0]], obj_unit.Y_Pos[ID_on_same_tile[0]], true);
	}
	
}
