
// Next turn algorithms:
// First, we'll have to check the player has done everything legally...

// Second, run through the AI cities to build their units

var hh = ds_grid_height(obj_backgroundScotland.cities);
for (var i = 1; i < hh; i++;) //Starts counting from 0?
{
	if i == obj_gameVariables.PlayerCity
	{
		// Don't need to do anything for the player:
		continue;
	}

	obj_infoWindow.Mouse_click_ID = i;
	var City_Population = obj_backgroundScotland.cities[# 2, i];
	while (real(City_Population) > 0)
	{
		obj_backgroundScotland.cities[# 2, i] = 
		string(real(obj_backgroundScotland.cities[# 2, i]) - 1);
		City_Population = obj_backgroundScotland.cities[# 2, i];
		scr_createUnit();
	}
}

// Now, run through the unit list to make sure all of the AI units have moves:
var hh = array_length_1d(obj_unit.ID);

for (var i = 0; i < hh; i += 1)
{
	if (obj_unit.ID[i] != 0)
	{
		if (obj_unit.Owner[i] != obj_gameVariables.PlayerCity)
		{
			if (obj_unit.Move_X[i] == 0 && obj_unit.Move_Y[i] == 0)
			{
				
				
				
				
				obj_unit.Move_X[i] = 500;
				obj_unit.Move_Y[i] = 500;
			}
		}
	}
}

// Finally, move all of the units

var hh = array_length_1d(obj_unit.ID);
var distance = 0;
var bearing = 0;

for (var i = 0; i < hh; i += 1)
{
	if (obj_unit.ID[i] != 0)
	{
		if (obj_unit.Move_X[i] != 0 && obj_unit.Move_Y[i] != 0)
		{
			distance = sqrt(sqr(obj_unit.Move_X[i] - obj_unit.X_Pos[i]) +
						    sqr(obj_unit.Move_Y[i] - obj_unit.Y_Pos[i]));
			bearing = point_direction(obj_unit.X_Pos[i], obj_unit.Y_Pos[i],
									  obj_unit.Move_X[i], obj_unit.Move_Y[i]);
			if obj_unit.Mobility[i] >= distance
			{
				obj_unit.X_Pos[i] = obj_unit.Move_X[i];
				obj_unit.Y_Pos[i] = obj_unit.Move_Y[i];
				obj_unit.Move_X[i] = 0;
				obj_unit.Move_Y[i] = 0;
			}
			else
			{
				obj_unit.X_Pos[i] = obj_unit.X_Pos[i] + obj_unit.Mobility[i] * dcos(bearing);
				// I don't understand why Y needs a negative sign?
				obj_unit.Y_Pos[i] = obj_unit.Y_Pos[i] - obj_unit.Mobility[i] * dsin(bearing);
			}
			
			//Destroy current units, then remake it?
			instance_destroy(obj_unit.inst_ID[i]);
			obj_unit.inst_ID[i] = instance_create_layer(
			obj_unit.X_Pos[i], obj_unit.Y_Pos[i], "lyr_Units", obj_unit);
		}
	}
}