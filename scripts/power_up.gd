extends Area2D

signal power_up_p1
signal power_up_p2

enum TYPE {
	FEATHER,
	FERTILIZER,
	MULTITOOL
}

@export var power_up_type: TYPE = TYPE.FEATHER
@export var Player1: Node2D = null
@export var Player2: Node2D = null

var lookup = {TYPE.FEATHER: "feather", TYPE.FERTILIZER: "fertilizer", TYPE.MULTITOOL: "multitool"}

func _ready():
	var sprite = load("res://assets/Powerups/" + str(lookup[power_up_type]) + ".png")
	$Sprite2D.texture = sprite
	
	power_up_p1.connect(Player1._on_power_up)
	power_up_p2.connect(Player2._on_power_up)

func _on_body_entered(body: Node2D) -> void:
	var player = body.player_number
	emit_signal("power_up_p" + str(player), lookup[power_up_type])
	
	queue_free()
