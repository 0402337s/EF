//show_message("1")

object_set_visible( obj_unit, true );

var obj_unit_length = array_length_1d(obj_unit.ID);

for (var i = 0; i <= obj_unit_length; i += 1)
{
	if (obj_unit.ID[i] == 0)
	{
		break;
	}
		
}

if (i == obj_unit_length)
{
	show_message("Ran out of unit space"); 
}
//instance_create_depth(x, y, depth, obj);

var x_pos = real(obj_backgroundScotland.cities[# 3, obj_infoWindow.Mouse_click_ID]);
var y_pos = real(obj_backgroundScotland.cities[# 4, obj_infoWindow.Mouse_click_ID]);
	
var inst_ID = instance_create_layer(x_pos, y_pos, "lyr_Units", obj_unit);

obj_unit.ID[i] = i + 1;
obj_unit.inst_ID[i] = inst_ID;
//obj_unit.Owner[i] = obj_gameVariables.PlayerCity;
obj_unit.Owner[i] = obj_infoWindow.Mouse_click_ID;
obj_unit.X_Pos[i] = x_pos;
obj_unit.Y_Pos[i] = y_pos;
obj_unit.Move_X[i] = 0;
obj_unit.Move_Y[i] = 0;
obj_unit.Mobility[i] = 5 * 20;
obj_unit.Influence[i] = 4;
obj_unit.Effectiveness[i] = 10;