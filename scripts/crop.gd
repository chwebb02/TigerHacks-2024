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
var lookup = {TYPE.WHEAT: "wheat", TYPE.POTATO: "potato", TYPE.TOMATO: "tomato"}

# Whether or not the crop can be harvested by a player
var harvestable: bool = false

# Player field number
var field_number = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	field_number = player.player_number
	player.harvest.connect(_on_harvest)
	
	$AnimatedSprite2D.play("grow_" + str(lookup[crop_type]), 1 / grow_speed)
	$ReadyTimer.start(1 / grow_speed)

func _on_ready_timer_timeout() -> void:
	harvestable = true

func _on_harvest(crop: String) -> void:
	print("in _on_harvest!")
	
	var areas = get_overlapping_areas()
	
	print("Overlapping areas: " + str(areas))
	
	if harvestable and areas.size() > 0:
		for area in areas:
			print("Player area: " + str(area.get_parent().player_number))
			print(crop)
			print(lookup[crop_type])
			
			var play = area.get_parent()
			if crop == lookup[crop_type] and play.player_number == field_number:
				print("Harvested")
				emit_signal("harvest_crop", field_number, crop)
				queue_free()
