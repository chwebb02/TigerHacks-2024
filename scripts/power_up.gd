extends Area2D

signal power_up

@export var power_up_type: String = "feather"

func _ready():
	var sprite = load("res://assets/Powerups/" + str(power_up_type) + ".png")
	$Sprite2D.texture = sprite

func _on_body_entered(body: Node2D) -> void:
	var player = body.player_number2
	emit_signal("power_up", player, power_up_type)
	
	queue_free()
