var Start, Target, Map, weight, n_row, n_col, i, j, H, G 
var dist_target_from_ij, Cell_Multiplier, F, current
var solved, A, I, skip, k, newG, newF, newNode

Start[0] = argument[0] - x;
Start[1] = argument[1] - y;
Target[0] = argument[2] - x;
Target[1] = argument[3] - y;

//Start[0] = 14*20;
//Start[1] = 31*20;
//Target[0] = 24*20;
//Target[1] = 5*20;

//Nodes
Map = obj_backgroundScotland.ds_roads_map; //

n_row = ds_grid_height(Map);
n_col = ds_grid_width(Map);

F = ds_grid_create(n_col, n_row);
G = ds_grid_create(n_col, n_row);
H = ds_grid_create(n_col, n_row);

Cell_Multiplier = 20; //How to convert from map pixels to road tiles

Start[0] = round(Start[0]/Cell_Multiplier);
Start[1] = round(Start[1]/Cell_Multiplier);
Target[0] = round(Target[0]/Cell_Multiplier);
Target[1] = round(Target[1]/Cell_Multiplier);

//Add in the possibility of roads:
//Roads = obj_backgroundScotland.roads_map;

//Heuristic Weight%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
weight = 1; //Try 1, 1.5, 2, 2.5
//Increasing weight makes the algorithm greedier, and likely to take a
//longer path, but with less computations.
//weight = 0 gives Djikstra algorithm
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

//Heuristic Map of all nodes
for (i = 0; i < n_col; i += 1)
{
	for (j = 0; j < n_row; j += 1)
	{
		//show_message(Map[# i,j]);
        if (Map[# i,j] != "99999")
		{
			dist_target_from_ij = sqrt(sqr(Target[0] - i) + sqr(Target[1] - j));
            H[i,j] = weight * dist_target_from_ij;
            G[i,j] = 99998;
		}
		else
		{
			H[i,j] = 99999;
            G[i,j] = 99999;
		}
	}
}
//show_message(string(H[Target[0], Target[1]]) + " " + string(H[Target[0] - 1, Target[1] - 1]))
//initial conditions%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
G[Start[0], Start[1]] = 0;
F[Start[0], Start[1]] = H[Start[0], Start[1]];

//closedNodes = ds_list_create();
var closedNodes_0 = ds_list_create();
var closedNodes_1 = ds_list_create();
var closedNodes_2 = ds_list_create();
var closedNodes_3 = ds_list_create();
var closedNodes_4 = ds_list_create();
//closedNodes = array_create(5);
var openNodes_0 = ds_list_create();
var openNodes_1 = ds_list_create();
var openNodes_2 = ds_list_create();
var openNodes_3 = ds_list_create();
var openNodes_4 = ds_list_create();
//openNodes = array_create(5);
openNodes_0[| 0] = Start[0]; 
openNodes_1[| 0] = Start[1];
openNodes_2[| 0] = G[Start[0], Start[1]]
openNodes_3[| 0] = F[Start[0], Start[1]]
openNodes_4[| 0] = 0; //[x y G F cameFrom]

//show_message(string(openNodes_0[| 0]) + " " + string(openNodes_1[| 0]) + " " + string(openNodes_2[| 0]) + " "
//	+ string(openNodes_3[| 0]) + " " + string(openNodes_4[| 0]))

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//Solve
solved = false;

while (ds_list_size(openNodes_0) > 0)
{
	if (ds_grid_get(Map, Target[0], Target[1]) == "99999")
	{
        show_message("Goal is in sea")
        break;
	}
	
    //find node from open set with smallest F value
	A = 999999;
	for (i = 0; i < ds_list_size(openNodes_3); i += 1)
	{
		if (openNodes_3[| i] < A)
		{
			//Can use ds_list_ function for this
			A = openNodes_3[| i];
			I = i;
		}
	}
	//[A, I] = min(openNodes(:,4));
   
    //%set current node
    current[0] = openNodes_0[| I];
    current[1] = openNodes_1[| I];
    current[2] = openNodes_2[| I];
    current[3] = openNodes_3[| I];
    current[4] = openNodes_4[| I];
   
    //%if goal is reached, break the loop
	//show_message("Current 0 = " + string(current[0]) + " Current 1 = " + string(current[1]) + 
	//" Target 0 = " + string(Target[0]) + " Target 1 = " + string(Target[1]))
    if(current[0] == Target[0] && current[1] == Target[1])
	{
        closedNodes_0[| ds_list_size(closedNodes_0)] = current[0];
        closedNodes_1[| ds_list_size(closedNodes_1)] = current[1];
        closedNodes_2[| ds_list_size(closedNodes_2)] = current[2];
        closedNodes_3[| ds_list_size(closedNodes_3)] = current[3];
        closedNodes_4[| ds_list_size(closedNodes_4)] = current[4];
        solved = true;
        break;
	}
   
    //%remove current node from open set and add it to closed set
	ds_list_delete(openNodes_0, I)
	ds_list_delete(openNodes_1, I)
	ds_list_delete(openNodes_2, I)
	ds_list_delete(openNodes_3, I)
	ds_list_delete(openNodes_4, I)
    //openNodes[I,:] = [];
    //closedNodes = [closedNodes;current];
	closedNodes_0[| ds_list_size(closedNodes_0)] = current[0];
	closedNodes_1[| ds_list_size(closedNodes_1)] = current[1];
	closedNodes_2[| ds_list_size(closedNodes_2)] = current[2];
	closedNodes_3[| ds_list_size(closedNodes_3)] = current[3];
	closedNodes_4[| ds_list_size(closedNodes_4)] = current[4];
   
    //%for all neighbors of current node
    for (i = current[0]-1; i <= current[0]+1; i += 1)
	{
        for (j = current[1]-1; j <= current[1]+1; j += 1)
        {   
            //%if out of range skip
            if (i < 0 || i > n_col - 1 || j < 0 || j > n_row - 1) continue;
            //    continue
            //end
           
            //%if object skip
            if (ds_grid_get(Map,i,j) == "99999") continue;
            //    continue
            //end
           
            //%if current node skip
            if (i == current[0] && j == current[1]) continue;
            //    continue
            //end
           
            //%if already in closed set skip
            skip = 0;
            for (k = 0; k < ds_list_size(closedNodes_0); k += 1)
			{
                if (i == closedNodes_0[| k] && j==closedNodes_1[| k])
				{
                    skip = 1;
                    break;
				}
			}
            if (skip == 1)
			{
                continue
			}
           
            A = -1;
            //%Check if already in open set
            if(!ds_list_empty(openNodes_0))
			{
                for (k = 0; k < ds_list_size(openNodes_0); k += 1)
				{
                    if (i == openNodes_0[| k] && j==openNodes_1[| k])
					{
                        A = k;
                        break;
					}
				}
			}
           
            dist_target_from_ij = sqrt(sqr(current[0] - i) + sqr(current[1] - j));
            newG = real(G[current[0],current[1]]) + dist_target_from_ij * sqr(real(ds_grid_get(Map,i,j)));
			//show_message(current[0]);
			//show_message(current[1]);
			//show_message(ds_grid_get(Map,current[0],current[1]));
			//show_message(newG)
            //newG = newG + real(ds_grid_get(Map,current[0],current[1]));
           
            //%if not in open set, add to open set
            if (A==-1)
			{
                G[i,j] = newG;
                newF = G[i,j] + H[i,j];
                newNode[0] = i;
                newNode[1] = j;
                newNode[2] = G[i,j];
                newNode[3] = newF;
                newNode[4] = ds_list_size(closedNodes_4)-1;
                //openNodes = [openNodes; newNode];
				openNodes_0[| ds_list_size(openNodes_0)] = newNode[0];
				openNodes_1[| ds_list_size(openNodes_1)] = newNode[1];
				openNodes_2[| ds_list_size(openNodes_2)] = newNode[2];
				openNodes_3[| ds_list_size(openNodes_3)] = newNode[3];
				openNodes_4[| ds_list_size(openNodes_4)] = newNode[4];
                continue;
			}
           
            //if no better path, skip
            if (newG >= G[i,j]) continue;
                //continue
            //end
           
            G[i,j] = newG;
            newF = newG + H[i,j];
            openNodes_1[| A] = newG;
			openNodes_2[| A] = newF;
			openNodes_3[| A] = ds_list_size(closedNodes_4)-1;
		}
	}
}

if (solved)
{
    //Path plotting
    k = ds_list_size(closedNodes_0)-1;
	var path_length = 0;
    while (k > 1)
	{
        k = closedNodes_4[| k];
		path_length += 1;
	}
	
    k = ds_list_size(closedNodes_0)-1;
    //path = ds_list_create();
	path_X = array_create(path_length);
	path_Y = array_create(path_length);
    while (k > 1)
	{
        i = closedNodes_0[| k];
        j = closedNodes_1[| k];
        k = closedNodes_4[| k];
        //path = [i,j; path];
		//show_message(string(i) + " " + string(j) + " " + string(k))
		//path[path_length] = [i*Cell_Multiplier, j*Cell_Multiplier]; //May not be right???
		path_X[path_length] = i*Cell_Multiplier + x + Cell_Multiplier/2; //May not be right???
		path_Y[path_length] = j*Cell_Multiplier + y + Cell_Multiplier/2; //May not be right???
		path_length = path_length - 1;
	}
	path_X[0] = Start[0] * Cell_Multiplier + x + Cell_Multiplier/2;
	path_Y[0] = Start[1] * Cell_Multiplier + y + Cell_Multiplier/2;
	//show_message(path_X)
	//show_message(path_Y)
	obj_unit.Move_X[obj_infoWindow.ID_on_same_tile[0]] = path_X;
	obj_unit.Move_Y[obj_infoWindow.ID_on_same_tile[0]] = path_Y;
}
else
{
    show_message("No Path Found")
}

