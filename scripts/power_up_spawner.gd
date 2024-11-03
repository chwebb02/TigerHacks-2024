extends Node2D

@export var all_power_up_spawn_chance: int = 1
@export var all_power_up_spawn_opportunities: int = 600
@export var power_up_rate: Dictionary = {"multitool": 20, "feather": 50, "fertilizer": 30}

var power_up_scene: PackedScene = preload("res://scenes/Power_Up.tscn")

enum TYPE {
	FEATHER,
	FERTILIZER,
	MULTITOOL
}
var lookup: Dictionary = {"feather": TYPE.FEATHER, "fertilizer": TYPE.FERTILIZER, "multitool": TYPE.MULTITOOL}

func spawn_power_up():
	var val = randi_range(0, 100)
	var power_up_type = "feather"
	if 0 <= val and val < power_up_rate["multitool"]:
		power_up_type = "multitool"
	elif power_up_rate["multitool"] <= val and val < power_up_rate["multitool"] + power_up_rate["fertilizer"]:
		power_up_type = "fertilizer"
	else:
		power_up_type = "feather"
	
	var pos = get_parent().find_spot_for_item()

	var child_node = power_up_scene.instantiate()
	child_node.set("Player1", get_parent().get_node("Player1"))
	child_node.set("Player2", get_parent().get_node("Player2"))
	child_node.set("position", pos[0])
	child_node.set("power_up_type", lookup[power_up_type])
	
	add_child(child_node)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:	
	var val = randi_range(0, all_power_up_spawn_opportunities)
	if val < all_power_up_spawn_chance:
		spawn_power_up()
