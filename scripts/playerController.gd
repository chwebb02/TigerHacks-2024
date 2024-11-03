extends CharacterBody2D

signal throw_egg
signal harvest
signal switch_to_tool
signal tool_disabled
signal all_tools_enabled
signal harvest_item

# Player 1 or two (can be extended later)
@export var player_number: int = 1

# Constants for handling feel of player movement
@export var acceleration: float = 64
@export var max_speed: float = 1024
@export var slowdown_factor: float = 0.05
@export var stop_tolerance: float = 32

# Power-up constants
@export var fertilizer_min_time: float = 1.2
@export var fertilizer_max_time: float = 3.7
@export var feather_min_time: float = 1.5
@export var feather_max_time: float = 2.9
@export var multitool_min_time: float = 1
@export var multitool_max_time: float = 1.8
@export var feather_speedup_factor: float = 0.5

# Debuff constants
@export var football_min_time: float = 1.2
@export var football_max_time: float = 5.8
@export var poop_min_time: float = 2.2
@export var poop_max_time: float = 4.9
@export var poop_slowdown_factor: float = 0.4

# Modifier for max_speed
var speed_modifier: float = 1
var yield_modifier: float = 1
var multitool_enabled: bool = false

# For tools
var tool_cursor: int = 0
var tools: Array = ["scythe", "hoe", "shovel"]
var tools_enabled: Dictionary = {"scythe": true, "hoe": true, "shovel": true}
var tools_to_crop: Dictionary = {"scythe": "wheat", "hoe": "potato", "shovel": "tomato"}

# Define the player number
var player: String = "player_"
func _ready() -> void:
	player = player + str(player_number) + "_"

# Handle movement for a single frame
var dir = "down"
func handle_movement() -> void:
	var velocity_change = Vector2(0, 0)
	
	# Modify movement direction based on user input
	if Input.is_action_pressed(player + "right"):
		velocity_change.x += acceleration * speed_modifier
		$AnimatedSprite2D.flip_h = false
		dir = "side"
	if Input.is_action_pressed(player + "left"):
		velocity_change.x -= acceleration * speed_modifier
		$AnimatedSprite2D.flip_h = true
		dir = "side"
	if Input.is_action_pressed(player + "up"):
		velocity_change.y -= acceleration * speed_modifier
		dir = "up"
	if Input.is_action_pressed(player + "down"):
		velocity_change.y += acceleration * speed_modifier
		dir = "down"
	
	$AnimatedSprite2D.play(dir)
	
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
	if abs(velocity.x) <= stop_tolerance and abs(velocity).y <= stop_tolerance:
		$AnimatedSprite2D.play("idle_" + str(dir))
		velocity = Vector2(0, 0)
	
	if dir == "down":
		$HarvestArea.rotation_degrees = 0
	elif dir == "side":
		var mod = 1 if $AnimatedSprite2D.flip_h else -1
		$HarvestArea.rotation_degrees = 90 * mod
	elif dir == "up":
		$HarvestArea.rotation_degrees = 180
	
	# Actually move around
	move_and_slide()

func modify_harvest_area():
	if tools[tool_cursor] == "scythe":
		$HarvestArea/CollisionShape2D.scale = Vector2(16, 1)
	elif tools[tool_cursor] == "hoe":
		$HarvestArea/CollisionShape2D.scale = Vector2(6, 2)
	else:
		$HarvestArea/CollisionShape2D.scale = Vector2(3, 1)

func switch_tool() -> void:
	var i = 0
	while i < 3:
		tool_cursor = (tool_cursor + 1) % len(tools)
		if tools_enabled[tools[tool_cursor]]:
			break
		
		i += 1
	
	if multitool_enabled:
		emit_signal("switch_to_tool", "multitool")
		return
	
	emit_signal("switch_to_tool", tools[tool_cursor])
	
	modify_harvest_area()

func _process(delta: float) -> void:
	handle_movement()
	
	if Input.is_action_just_pressed(player + "change_tool"):
		switch_tool()
	
	if Input.is_action_just_pressed(player + "use_tool"):
		if multitool_enabled:
			emit_signal("harvest", "all", $".")
		
		if tools_enabled[tools[tool_cursor]]:
			emit_signal("harvest", tools_to_crop[tools[tool_cursor]], $".")

func disable_tool():
	tools_enabled[tools[tool_cursor]] = false
	emit_signal("tool_disabled", tools[tool_cursor])
	switch_tool()

func display_egg():
	emit_signal("throw_egg")

func _on_debuff(type: String) -> void:
	if (type == "football"):
		disable_tool()
		$FootballTimer.start(randf_range(football_min_time, football_max_time))
	elif (type == "egg"):
		display_egg()
	else:
		speed_modifier *= (1 - poop_slowdown_factor)
		$PoopTimer.start(randf_range(poop_min_time, poop_max_time))

func _on_power_up(type: String) -> void:
	if (type == "fertilizer"):
		yield_modifier *= 2
		$FertilizerTimer.start(randf_range(fertilizer_min_time, fertilizer_max_time))
	elif (type == "multitool"):
		multitool_enabled = true
		$HarvestArea/CollisionShape2D.scale = Vector2(16, 1)
		$MultitoolTimer.start(randf_range(multitool_min_time, multitool_max_time))
	else:
		speed_modifier *= (1 + feather_speedup_factor)
		$FeatherTimer.start(randf_range(feather_min_time, feather_max_time))


func _on_fertilizer_timer_timeout() -> void:
	yield_modifier = 1

func _on_feather_timer_timeout() -> void:
	speed_modifier = 1

func _on_multitool_timer_timeout() -> void:
	modify_harvest_area()
	multitool_enabled = false

func _on_poop_timer_timeout() -> void:
	speed_modifier = 1

func _on_football_timer_timeout() -> void:
	for tool in tools:
		tools_enabled[tool] = true
	
	emit_signal("all_tools_enabled")

func _on_harvest_crop(type: String, value: int) -> void:
	value *= yield_modifier
	emit_signal("harvest_item", type, yield_modifier, value)
