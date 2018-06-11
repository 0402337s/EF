/// @Button press
// You can write your code in this editor

if (btn_down == false)
{
	//Destroy any other overlays
	instance_destroy(obj_ownership1);
	instance_destroy(obj_ownership2);
	obj_btnOwnershipMap.btn_down = false;
	
	var x_pos, y_pos
	var Map = obj_backgroundScotland.ds_roads_map;
	var n_rows = ds_grid_height(Map);
	var n_cols = ds_grid_width(Map);

	for (var row_idx = 1; row_idx < n_rows; row_idx += 1)
	{
		for (var col_idx = 1; col_idx < n_cols; col_idx += 1)
		{
			x_pos = obj_backgroundScotland.x + (col_idx) * 20;
			y_pos = obj_backgroundScotland.y + (row_idx) * 20;
			if (Map[# col_idx, row_idx] == "1")
			{
				instance_create_layer(x_pos, y_pos, "lyr_Overlay", obj_ownership1);
				//obj_ownershipWhite.image_alpha = 0.5;
				//obj_ownershipWhite.image_blend = c_maroon;
			}
			else if (Map[# col_idx, row_idx] == "2")
			{
				instance_create_layer(x_pos, y_pos, "lyr_Overlay", obj_ownership2);
				//obj_ownershipWhite.image_alpha = 0.5;
				//obj_ownershipWhite.image_blend = c_yellow;
			}
		}
	}
}
else
{
	instance_destroy(obj_ownership1);
	instance_destroy(obj_ownership2);
}

if (btn_down == false) btn_down = true;
else btn_down = false;