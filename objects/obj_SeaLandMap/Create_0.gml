//This will create the sea/land map boundaries

//show_message(MapFilePath + "Map_small.csv");
if (file_exists("Map_small.csv"))
{
	background_map = load_csv("Map_small.csv");
}
else show_message("Map_small.csv is missing>");

var n_rows
n_rows = 100;
var n_cols
n_cols = 100;

for (var row_idx = 1; row_idx < n_rows; row_idx += 1)
{
	for (var col_idx = 1; col_idx < n_cols; col_idx += 1)
	{
		if (background_map[# row_idx, col_idx] == "0")
		{
			instance_create_layer(col_idx, row_idx, "Instances", obj_bckgrdSea);
		}
		else
		{
			instance_create_layer(col_idx, row_idx, "Instances", obj_bckgrdLand);
		}
	}
}

sprite_save(obj_SeaLandMap, 0, "Sea_Land.png")