extends Area2D

signal debuff_p1
signal debuff_p2

enum TYPE {
	FOOTBALL,
	EGG,
	MANURE
}

# Debuff type: either football, egg, or manure
@export var debuff_type: TYPE = TYPE.EGG
@export var Player1: CharacterBody2D = null
@export var Player2: CharacterBody2D = null

var lookup = {TYPE.FOOTBALL: "football", TYPE.EGG: "egg", TYPE.MANURE: "manure"}

func _ready():
	var sprite = load("res://assets/Debuffs/" + str(lookup[debuff_type]) + ".png")
	$Sprite2D.texture = sprite
	
	debuff_p1.connect(Player1._on_debuff)
	debuff_p2.connect(Player2._on_debuff)

func _on_body_entered(body: Node2D) -> void:
	var victim = body.player_number % 2 + 1
	emit_signal("debuff_p" + str(victim), lookup[debuff_type])
	
	queue_free()
