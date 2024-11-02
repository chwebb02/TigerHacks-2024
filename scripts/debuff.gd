extends Area2D

signal debuff

# Debuff type: either football, egg, or manure
@export var debuff_type: String = "football"

func _ready():
	var sprite = load("res://assets/Debuffs/" + str(debuff_type) + ".png")
	$Sprite2D.texture = sprite

func _on_body_entered(body: Node2D) -> void:
	var victim = body.player_number % 2 + 1
	emit_signal("debuff", debuff_type, victim)
	
	queue_free()
