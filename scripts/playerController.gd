extends CharacterBody2D


# Platyer 1 or two (can be extended later)
@export var player_number: int = 1

# Constants for handling feel of player movement
@export var acceleration: float = 64
@export var max_speed: float = 1024
@export var slowdown_factor: float = 0.05

# Modifier for max_speed
var speed_modifier: float = 1

# For tools
var tool_cursor: int = 0
var tools: Array = ["scythe", "hoe", "shovel"]
var tools_enabled: Dictionary = {"scythe": true, "hoe": true, "shovel": true}


# Define the player number
var player: String = "player_"
func _ready():
	player = player + str(player_number) + "_"

# Handle movement for a single frame
func handle_movement():
	var velocity_change = Vector2(0, 0)
	
	# Modify movement direction based on user input
	if Input.is_action_pressed(player + "right"):
		velocity_change.x += acceleration
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("side")
	if Input.is_action_pressed(player + "left"):
		velocity_change.x -= acceleration
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play("side")
	if Input.is_action_pressed(player + "up"):
		velocity_change.y -= acceleration
		$AnimatedSprite2D.play("up")
	if Input.is_action_pressed(player + "down"):
		velocity_change.y += acceleration
		$AnimatedSprite2D.play("down")
	
	# Slow down in a direction if no accleration is applied in that direction
	if (velocity_change.x == 0):
		velocity.x = lerp(velocity.x, 0.0, slowdown_factor)
	if (velocity_change.y == 0):
		velocity.y = lerp(velocity.y, 0.0, slowdown_factor)
	
	# Update velocity with the change this step
	velocity += velocity_change
	
	# Limit velocity to maximums
	velocity.x = clamp(velocity.x, -1 * speed_modifier * max_speed, speed_modifier * max_speed)
	velocity.y = clamp(velocity.y, -1 * speed_modifier * max_speed, speed_modifier * max_speed)
	
	$AnimatedSprite2D.speed_scale = sqrt(velocity.x * velocity.x + velocity.y * velocity.y) / max_speed
	
	# Actually move around
	move_and_slide()


func switch_tool():
	var i = 0
	while i < 3:
		tool_cursor = (tool_cursor + 1) % len(tools)
		if tools_enabled[tools[tool_cursor]]:
			break
		
		i += 1

func _process(delta: float) -> void:
	handle_movement()
	
	if Input.is_action_just_pressed(player + "change_tool"):
		switch_tool()
		
	if Input.is_action_just_pressed(player + "use_tool"):
		if tools_enabled[tools[tool_cursor]]:
			var sig = "use_" + tools[tool_cursor]
			emit_signal(sig)
