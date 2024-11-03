extends Node2D

@export var all_crop_spawn_chance: int = 1
@export var all_crop_spawn_opportunities: int = 60
@export var crop_rate: Dictionary = {"wheat": 70, "potato": 20, "tomato": 10}

var crop_scene = preload("res://scenes/Crop.tscn")

enum TYPE {
	WHEAT,
	POTATO,
	TOMATO
}
var lookup: Dictionary = {"wheat": TYPE.WHEAT, "potato": TYPE.POTATO, "tomato":TYPE.TOMATO}

func spawn_crop():
	var val = randi_range(0, 100)
	var crop_type = "wheat"
	print(val)
	if 0 <= val and val < crop_rate["tomato"]:
		crop_type = "tomato"
	elif crop_rate["tomato"] <= val and val < crop_rate["tomato"] + crop_rate["potato"]:
		crop_type = "potato"
	else:
		crop_type = "wheat"
	
	var pos: Array = get_parent().find_spot_for_item()

	var child_node = crop_scene.instantiate()
	child_node.set("player", get_parent().get_node("Player" + str(pos[1])))
	child_node.set("position", pos[0])
	child_node.set("crop_type", lookup[crop_type])
	
	add_child(child_node)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var val = randi_range(0, all_crop_spawn_opportunities)
	if val < all_crop_spawn_chance:
		spawn_crop()
