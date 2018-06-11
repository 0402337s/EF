// @description Insert description here
// You can write your code in this editor


if (file_exists("Cities.csv"))
{
	cities = load_csv("Cities.csv");
	
	var ww = ds_grid_width(cities);
	var hh = ds_grid_height(cities);
	for (var i = 1; i < hh; i++;) //Starts counting from 0?
	{
		//show_message(cities[# 4, i])
		x_pos = real(cities[# 3, i]);
		y_pos = real(cities[# 4, i]);
		instance_create_depth(x_pos, y_pos, 199, obj_city);
	}
}
else show_message("Cities.csv is missing!");

if (file_exists("Map_roads.csv"))
{
	ds_roads_map = load_csv("Map_roads.csv");
	var ww = ds_grid_width(ds_roads_map);
	var hh = ds_grid_height(ds_roads_map);
	mp_roads_grid = mp_grid_create(20, 40, ww, hh, 20, 20);
	mp_grid_clear_all(mp_roads_grid); //Remove all the existing forbidden cells
	for (var i = 0; i < ds_grid_width(ds_roads_map); i += 1) 
	{
		for (var j = 0; j < ds_grid_height(ds_roads_map); j += 1) 
		{
			if (ds_roads_map[# i, j]) == "Inf"
			{
				mp_grid_add_cell(mp_roads_grid, i, j);
			}
		}
	}
}
else show_message("Map_roads.csv is missing!");

arrow_start_x = 0;
arrow_start_y = 0;
arrow_end_x = 0;
arrow_end_y = 0;

path = path_add();

//aStar_init(36, 37, 20, 1, 1);