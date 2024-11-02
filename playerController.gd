extends CharacterBody2D


# Signals
signal use_scythe
signal use_hoe
signal use_shovel
signal throw_egg
signal throw_football
signal throw_poop

# Which player is controlling this object
@export var player_number: int = 1

# For the way that truman moves and handles
@export var acceleration: float = 64
@export var max_speed: float = 1024
@export var slowdown_factor: float = 0.05

var speed_limit: float = max_speed

# Modifier attributes
@export var football_min_wait: float = 1.0
@export var football_max_wait: float = 3.3
@export var poop_slowdown: float = 0.2
@export var poop_min_wait: float = 1.0
@export var poop_max_wait: float = 5.2

# The tools and whether or not they are able to be used
var tools: Array = ["scythe", "hoe", "shovel"]
var tools_enabled: Dictionary = {"scythe": true, "hoe": true, "shovel": true}
var tool_cursor: int = 0

# Handle the other truman throwing an egg
func _on_throw_egg():
	# Cover this player's half of the screen with an egg
	pass

# Handle the other truman throwing a football
func _on_throw_football():
	tools_enabled[tools[tool_cursor]] = false
	tool_cursor = (tool_cursor + 1) % len(tools)
	$FootballTimer.start(randf_range(football_min_wait, football_max_wait))

# Handle the other truman throwing poop
func _on_throw_poop():
	speed_limit = max_speed * (1 - poop_slowdown)
	$PoopTimer.start(randf_range(poop_min_wait, poop_max_wait))

# Define which player controls to use
var player: String = "player_"
func _ready():
	player = player + str(player_number) + "_"

# Handle player movement for a single frame
func handle_movement():
	var velocity_change = Vector2(0, 0)
	
	# Figure out how the velocity should 
	# change this frame according to player input
	if Input.is_action_pressed(player + "right"):
		velocity_change.x += acceleration
	if Input.is_action_pressed(player + "left"):
		velocity_change.x -= acceleration
	if Input.is_action_pressed(player + "up"):
		velocity_change.y -= acceleration
	if Input.is_action_pressed(player + "down"):
		velocity_change.y += acceleration
	
	# If no input, slow down in given direction
	if (velocity_change.x == 0):
		velocity.x = lerp(velocity.x, 0.0, slowdown_factor)
	if (velocity_change.y == 0):
		velocity.y = lerp(velocity.y, 0.0, slowdown_factor)
	
	# Modify the velocity by this frame's amount of change
	velocity += velocity_change
	
	# Limit the velocity to the maximum allowed
	velocity.x = clamp(velocity.x, -1 * max_speed, max_speed)
	velocity.y = clamp(velocity.y, -1 * max_speed, max_speed)
	
	# Actually move the object
	move_and_slide()

func _process(delta: float) -> void:
	handle_movement()
	
	# Change tool
	if Input.is_action_just_pressed(player + "change_tool"):
		tool_cursor = (tool_cursor + 1) % len(tools)
		
		while not tools_enabled[tools[tool_cursor]]:
			tool_cursor = (tool_cursor + 1) % len(tools)
	
	# Use current tool
	if Input.is_action_just_pressed(player + "use_tool"):
		var sig = "use_" + str(tools[tool_cursor])
		emit_signal(sig)
	
	


func _on_poop_timer_timeout() -> void:
	speed_limit = max_speed


func _on_football_timer_timeout() -> void:
	for tool in tools:
		tools_enabled[tool] = true
