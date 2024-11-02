extends Area2D

signal harvest_crop

enum TYPE {
	WHEAT,
	POTATO,
	TOMATO
}

@export var crop_type: TYPE = TYPE.WHEAT
@export var grow_speed: float = 1
@export var field_number: int = 1
@export var HUD: Node2D = null

# Lookup dict for crop type, helps simplify work in editor
var lookup = {TYPE.WHEAT: "wheat", TYPE.POTATO: "potato", TYPE.TOMATO: "TOMATO"}

# Whether or not the crop can be harvested by a player
var harvestable: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("grow_" + str(lookup[crop_type]), 1 / grow_speed)
	$ReadyTimer.start(1 / grow_speed)

func _on_ready_timer_timeout() -> void:
	harvestable = true

func _on_harvest(crop: String) -> void:
	var areas = get_overlapping_areas()
	
	if harvestable and areas.size() > 0:
		for area in areas:
			var player = area.get_parent()
			if player.has_meta("player_number") and player.player_number == field_number:
				emit_signal("harvest_crop", field_number, lookup[crop_type])
				queue_free()
