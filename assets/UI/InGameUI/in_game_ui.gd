extends Node2D

var player_1_score: int = 0
var player_2_score: int = 0
var timer: int = 90

var player1tools = []
var player2tools = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AudioStreamPlayer2D.play()
	$Control3.visible = false
	player_1_score = 0
	player_2_score = 0
	_on_player_1_switch_to_tool('hoe')
	_on_player_2_switch_to_tool('hoe')
	$Control/TimerText.text = str(timer)
	$Control/TimerVisual.radial_fill_degrees = 0
	while(timer > 0):
		timer = timer - 1
		$Control/TimerVisual.radial_fill_degrees = (120-(timer))*3
		
		$Control/TimerText.text = str(timer)
		await get_tree().create_timer(1).timeout
		if(timer == 10):
			$Timer.play()
	$AudioStreamPlayer2D.stop()
	await get_tree().create_timer(1).timeout
	$Boom.play()
	$TextureRect.visible = true;
	await get_tree().create_timer(3).timeout
	$AudioStreamPlayer2D2.play()
	$TextureRect.visible = false;
	$Control3.visible = true
	while player_1_score > 0:
		if $Control3/TextureRect/TextureProgressBar/ProgressBar.value < 99:
			$Control3/TextureRect/TextureProgressBar/ProgressBar.value = $Control3/TextureRect/TextureProgressBar/ProgressBar.value + 1
		elif $Control3/TextureRect/TextureProgressBar.value < 79:
			$Control3/TextureRect/TextureProgressBar.value = $Control3/TextureRect/TextureProgressBar.value + 2
		$Control3/TextureRect/Label.text = str(int($Control3/TextureRect/Label.text) + 1)
		player_1_score = player_1_score - 1
		await get_tree().create_timer(.01).timeout
	$Control3/TextureRect/TextureProgressBar/ProgressBar.fill_mode = ProgressBar.FILL_BOTTOM_TO_TOP
	while $Control3/TextureRect/TextureProgressBar/ProgressBar.value > 0:
		$Control3/TextureRect/TextureProgressBar/ProgressBar.value = $Control3/TextureRect/TextureProgressBar/ProgressBar.value - 2
		
		await get_tree().create_timer(.01).timeout
	while player_2_score > 0:
		if $Control3/TextureRect2/TextureProgressBar/ProgressBar.value < 99:
			$Control3/TextureRect2/TextureProgressBar/ProgressBar.value = $Control3/TextureRect2/TextureProgressBar/ProgressBar.value + 1
		elif $Control3/TextureRect2/TextureProgressBar.value < 79:
			$Control3/TextureRect2/TextureProgressBar.value = $Control3/TextureRect2/TextureProgressBar.value + 2
		$Control3/TextureRect2/Label.text = str(int($Control3/TextureRect2/Label.text) + 1)
		player_2_score = player_2_score - 1
		await get_tree().create_timer(.01).timeout
	$Control3/TextureRect2/TextureProgressBar/ProgressBar.fill_mode = ProgressBar.FILL_BOTTOM_TO_TOP
	while $Control3/TextureRect2/TextureProgressBar/ProgressBar.value > 0:
		$Control3/TextureRect2/TextureProgressBar/ProgressBar.value = $Control3/TextureRect2/TextureProgressBar/ProgressBar.value - 2
		
		await get_tree().create_timer(.01).timeout
		
		
		
	if(int($Control3/TextureRect/Label.text) > int($Control3/TextureRect2/Label.text)):
		$Control3/TextureRect/Label.visible = false
		await get_tree().create_timer(1).timeout
		$Control3/TextureRect/Label.visible = true
		$Bell.play()
		await get_tree().create_timer(1).timeout
		$Control3/TextureRect/Label.visible = false
		await get_tree().create_timer(1).timeout
		$Control3/TextureRect/Label.visible = true
		$Bell.play()
		await get_tree().create_timer(1).timeout
		$Control3/TextureRect/Label.visible = false
		await get_tree().create_timer(1).timeout
		$Control3/TextureRect/Label.visible = true
		$Bell.play()
		await get_tree().create_timer(3).timeout
	elif(int($Control3/TextureRect/Label.text) < int($Control3/TextureRect2/Label.text)):
		$Control3/TextureRect2/Label.visible = false
		await get_tree().create_timer(1).timeout
		$Control3/TextureRect2/Label.visible = true
		$Bell.play()
		await get_tree().create_timer(1).timeout
		$Control3/TextureRect2/Label.visible = false
		await get_tree().create_timer(1).timeout
		$Control3/TextureRect2/Label.visible = true
		$Bell.play()
		await get_tree().create_timer(1).timeout
		$Control3/TextureRect2/Label.visible = false
		await get_tree().create_timer(1).timeout
		$Control3/TextureRect2/Label.visible = true
		$Bell.play()
		await get_tree().create_timer(3).timeout
	else:
		$Control3/TextureRect2/Label.visible = false
		$Control3/TextureRect/Label.visible = false
		await get_tree().create_timer(1).timeout
		$Control3/TextureRect/Label.visible = true
		$Bell.play()
		$Control3/TextureRect2/Label.visible = true
		await get_tree().create_timer(1).timeout
		$Control3/TextureRect/Label.visible = false
		$Control3/TextureRect2/Label.visible = false
		await get_tree().create_timer(1).timeout
		$Control3/TextureRect/Label.visible = true
		$Bell.play()
		$Control3/TextureRect2/Label.visible = true
		await get_tree().create_timer(1).timeout
		$Control3/TextureRect/Label.visible = false
		$Control3/TextureRect2/Label.visible = false
		await get_tree().create_timer(1).timeout
		$Control3/TextureRect/Label.visible = true
		$Bell.play()
		$Control3/TextureRect2/Label.visible = true
		await get_tree().create_timer(3).timeout
	$AudioStreamPlayer2D2.stop()
	get_tree().change_scene_to_file("res://MainMenu/main_menu.tscn")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_player_1_throw_egg() -> void:
	$Control2/Player1Tool.eggSplat()
	pass # Replace with function body.


func _on_player_2_throw_egg() -> void:
	$Control2/Player2Tool.eggSplat()
	pass # Replace with function body.


func _on_player_1_switch_to_tool(tool:String) -> void:
	$Control2/Player1Tool.changeTool(tool)
	pass # Replace with function body.


func _on_player_2_switch_to_tool(tool:String) -> void:
	$Control2/Player2Tool.changeTool(tool)
	pass # Replace with function body.


func _on_player_2_collect_crop(crop:String, num:int, points:int) -> void:
	if crop == "wheat":
		$'Control/Player2Crops/Player2Wheat'.text = str(int($'Control/Player2Crops/Player2Wheat'.text) + num)
	elif crop == "potato":
		$'Control/Player2Crops/Player2Potatoes'.text = str(int($'Control/Player2Crops/Player2Potatoes'.text) + num)
	else:
		$'Control/Player2Crops/Player2Tomatoes'.text = str(int($'Control/Player2Crops/Player2Tomatoes'.text) + num)
	
	player_2_score += points


func _on_player_1_collect_crop(crop:String, num:int, points:int) -> void:
	if crop == "wheat":
		$'Control/Player1Crops/Player1Wheat'.text = str(int($'Control/Player1Crops/Player1Wheat'.text) + num)
	elif crop == "potato":
		$'Control/Player1Crops/Player1Potatoes'.text = str(int($'Control/Player1Crops/Player1Potatoes'.text) + num)
	else:
		$'Control/Player1Crops/Player1Tomatoes'.text = str(int($'Control/Player1Crops/Player1Tomatoes'.text) + num)
	
	player_1_score += points


func _on_player_1_tool_disabled(tool:String) -> void:
	player1tools.append(tool)
	pass # Replace with function body.


func _on_player_1_all_tools_enabled() -> void:
	player1tools = []
	pass # Replace with function body.


func _on_player_2_all_tools_enabled() -> void:
	player2tools = []
	pass # Replace with function body.


func _on_player_2_tool_disabled(tool:String) -> void:
	player2tools.append(tool)
	pass # Replace with function body.
