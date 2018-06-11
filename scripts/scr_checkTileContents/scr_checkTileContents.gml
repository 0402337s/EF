
//Going to need to work out how many units are on the same tile
//And need to work out if there's a city there too.

//Need to set Mouse_click to true for obj_unit

//obj_city.Mouse_click = false;
obj_city.Mouse_over = false;
//Mouse_click = true;
//Mouse_click_ID = -1;

//First column is the object name, 
//second column is string ("Unit" for unit, "City" for city)
//third column is the row entry
obj_infoWindow.Name_on_same_tile = array_create(20); //20
obj_infoWindow.Type_on_same_tile = array_create(20); //20
obj_infoWindow.ID_on_same_tile = array_create(20); //20
obj_infoWindow.num_on_same_tile = 0;

var hh = ds_grid_height(obj_backgroundScotland.cities);
for (var i = 1; i < hh; i++;) //Starts counting from 0?
{
	var x_pos = real(obj_backgroundScotland.cities[# 3, i]);
	var y_pos = real(obj_backgroundScotland.cities[# 4, i]);

	if (mouse_x >= x_pos - 10 && mouse_x < x_pos + 10 &&
		mouse_y >= y_pos - 10 && mouse_y < y_pos + 10)
	{
		obj_infoWindow.num_on_same_tile = obj_infoWindow.num_on_same_tile + 1;
		obj_infoWindow.Name_on_same_tile[obj_infoWindow.num_on_same_tile - 1] = obj_backgroundScotland.cities[# 1, i];
		obj_infoWindow.Type_on_same_tile[obj_infoWindow.num_on_same_tile - 1] = "City";
		obj_infoWindow.ID_on_same_tile[obj_infoWindow.num_on_same_tile - 1] = i;
	}
}

hh = array_length_1d(obj_unit.ID);
for (var i = 0; i < hh; i += 1)
{
	if (mouse_x >= obj_unit.X_Pos[i] - 10 && mouse_x < obj_unit.X_Pos[i] + 10 &&
		mouse_y >= obj_unit.Y_Pos[i] - 10 && mouse_y < obj_unit.Y_Pos[i] + 10)
	{
		obj_infoWindow.num_on_same_tile = obj_infoWindow.num_on_same_tile + 1;
		obj_infoWindow.Name_on_same_tile[obj_infoWindow.num_on_same_tile - 1] = string("Unit:" + string(obj_unit.ID[i]));
		obj_infoWindow.Type_on_same_tile[obj_infoWindow.num_on_same_tile - 1] = "Unit";
		obj_infoWindow.ID_on_same_tile[obj_infoWindow.num_on_same_tile - 1] = i;
	}
}

if (obj_infoWindow.num_on_same_tile > 20)
{
	show_message("Too many units on tile")
}
else if (obj_infoWindow.num_on_same_tile == 0)
{
	show_message("Nothing on tile?")
}