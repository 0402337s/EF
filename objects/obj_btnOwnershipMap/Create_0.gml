/// @description Insert description here
// You can write your code in this editor

if (file_exists("Map_ownership.csv"))
{
	ownership_map = load_csv("Map_ownership.csv");
}
else show_message("Map_ownership.csv is missing!");

btn_down = false;
