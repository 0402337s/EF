/// @description Insert description here
// You can write your code in this editor

// draw arrow for unit movement
if obj_infoWindow.Unit_draw == true
{
	//obj_unit.Move_X[obj_infoWindow.ID_on_same_tile[0]] = mouse_x;
	//obj_unit.Move_Y[obj_infoWindow.ID_on_same_tile[0]] = mouse_y;
	
	arrow_start_x = obj_unit.X_Pos[obj_infoWindow.ID_on_same_tile[0]];
	arrow_start_y = obj_unit.Y_Pos[obj_infoWindow.ID_on_same_tile[0]];
	arrow_end_x = mouse_x;
	arrow_end_y = mouse_y;
	//show_message(string(x) + " " + string(y));
	
	//scr_getShortestPath([arrow_start_x, arrow_start_y],
	//[arrow_end_x, arrow_end_y]);
	
	//path = path_add();
	//xstart = 20; // x position of map
	//ystart = 40; // y position of map
	//scr_mpGridAstar(mp_roads_grid, ds_roads_map, path,
	//arrow_start_x, arrow_start_y, arrow_end_x, arrow_end_y,
	//xstart, ystart, 35, 35, 20, 20);
	
	//Path = array_create(20);
	scr_pathFind(arrow_start_x, arrow_start_y, arrow_end_x, arrow_end_y);
	
	//aStar_find_path(arrow_start_x, arrow_start_y, arrow_end_x, arrow_end_y);
	
	//draw_arrow(arrow_start_x, arrow_start_y, arrow_end_x, arrow_end_y, 10);
	
	//path = path_add();
	//if mp_grid_path(mp_roads_grid, path, arrow_start_x, arrow_start_y, arrow_end_x, arrow_end_y, 1)
    //{
		//path_start(path, 0, 3, 0);
    //}

}