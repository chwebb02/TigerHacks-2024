extends Node2D

@export var all_debuff_spawn_chance: int = 1
@export var all_debuff_spawn_opportunities: int = 600
@export var debuff_rate: Dictionary = {"manure": 50, "egg": 30, "football": 20}

var debuff_scene: PackedScene = preload("res://scenes/Debuff.tscn")

enum TYPE {
	FOOTBALL,
	EGG,
	MANURE
}
var lookup: Dictionary = {"football": TYPE.FOOTBALL, "egg": TYPE.EGG, "manure": TYPE.MANURE}

func spawn_debuff():
	var val = randi_range(0, 100)
	var debuff_type = "manure"
	if 0 <= val and val < debuff_rate["football"]:
		debuff_type = "football"
	elif debuff_rate["football"] <= val and val < debuff_rate["football"] + debuff_rate["egg"]:
		debuff_type = "egg"
	else:
		debuff_type = "manure"
	
	var pos = get_parent().find_spot_for_item()

	var child_node = debuff_scene.instantiate()
	child_node.set("Player1", get_parent().get_node("Player1"))
	child_node.set("Player2", get_parent().get_node("Player2"))
	child_node.set("position", pos[0])
	child_node.set("debuff_type", lookup[debuff_type])
	
	add_child(child_node)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var val = randi_range(0, all_debuff_spawn_opportunities)
	if val < all_debuff_spawn_chance:
		spawn_debuff()
