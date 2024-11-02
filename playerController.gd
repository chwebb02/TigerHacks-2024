extends CharacterBody2D


@export var player_number: int = 1

@export var acceleration: float = 64
@export var max_speed: float = 1024
@export var slowdown_factor: float = 0.05

var player: String = "player_"
func _ready():
	player = player + str(player_number) + "_"

func handle_movement():
	var velocity_change = Vector2(0, 0)
	
	if Input.is_action_pressed(player + "right"):
		velocity_change.x += acceleration
	if Input.is_action_pressed(player + "left"):
		velocity_change.x -= acceleration
	if Input.is_action_pressed(player + "up"):
		velocity_change.y -= acceleration
	if Input.is_action_pressed(player + "down"):
		velocity_change.y += acceleration
	
	if (velocity_change.x == 0):
		velocity.x = lerp(velocity.x, 0.0, slowdown_factor)
	if (velocity_change.y == 0):
		velocity.y = lerp(velocity.y, 0.0, slowdown_factor)
	
	velocity += velocity_change
	
	velocity.x = clamp(velocity.x, -1 * max_speed, max_speed)
	velocity.y = clamp(velocity.y, -1 * max_speed, max_speed)
	
	move_and_slide()

func _process(delta: float) -> void:
	handle_movement()
