extends Area2D

signal harvest_crop

enum TYPE {
	WHEAT,
	POTATO,
	TOMATO
}

@export var crop_type: TYPE = TYPE.WHEAT
@export var grow_speed: float = 1
@export var player: CharacterBody2D

# Lookup dict for crop type, helps simplify work in editor
var lookup: Dictionary = {TYPE.WHEAT: "wheat", TYPE.POTATO: "potato", TYPE.TOMATO: "tomato"}

# Crop value lookup
var crop_values: Dictionary = {TYPE.WHEAT: 1, TYPE.POTATO: 5, TYPE.TOMATO: 15}

# Whether or not the crop can be harvested by a player
var harvestable: bool = false

# Player field number
var field_number = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("grow_" + str(lookup[crop_type]), 1 / grow_speed)
	$ReadyTimer.start(1 / grow_speed)
	
	field_number = player.player_number
	player.harvest.connect(_on_harvest)
	harvest_crop.connect(player._on_harvest_crop)

func _on_ready_timer_timeout() -> void:
	harvestable = true

func _on_harvest(crop: String, player) -> void:
	var areas = get_overlapping_areas()
	for area in areas:
		if harvestable and area.get_parent() == player and (crop == lookup[crop_type] or crop == "all"):
			emit_signal("harvest_crop", lookup[crop_type], crop_values[crop_type])
			queue_free()
