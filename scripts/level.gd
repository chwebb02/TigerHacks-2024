extends Node2D

@export var min_item_x: int
@export var max_item_x: int
@export var min_item_y: int
@export var max_item_y: int
@export var min_center_x: int
@export var max_center_x: int 

var turn = randi_range(1, 2)

func find_spot_for_item() -> Array:	
	turn = turn % 2 + 1
	var dir = Vector2(0, 0)
	if (turn == 1):
		dir = Vector2(randf_range(min_item_x, min_center_x), randf_range(min_item_y, max_item_y))
	else:
		dir = Vector2(randf_range(max_center_x, max_item_x), randf_range(min_item_y, max_item_y))
	
	return [dir, turn]
