extends Sprite2D

@onready var _animations = get_node("AnimationPlayer2")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func changeTool(tool: String):
	if _animations:
		if tool == "scythe":
			_animations.play("Scythe2")
			
		if tool == "shovel":
			_animations.play("Shovel2")
		if tool == "hoe":
			_animations.play("Hoe2")
	else:
		print("AnimationPlayer node is null")
		
func eggSplat():
	if $EggSplat2:
		var egg = $EggSplat2
		egg.visible = true
		egg.frame = 0
		egg.position = Vector2(800,-814)
		egg.position = Vector2(egg.position.x,egg.position.y + 20)
		await get_tree().create_timer(1).timeout
		egg.frame = 1
		egg.position = Vector2(egg.position.x,egg.position.y + 20)
		await get_tree().create_timer(1).timeout
		egg.frame = 2
		egg.position = Vector2(egg.position.x,egg.position.y + 20)
		await get_tree().create_timer(1).timeout
		egg.frame = 3
		egg.position = Vector2(egg.position.x,egg.position.y + 20)
		await get_tree().create_timer(1).timeout
		egg.frame = 4
		egg.position = Vector2(egg.position.x,egg.position.y + 20)
		await get_tree().create_timer(1).timeout
		egg.frame = 5
		egg.position = Vector2(egg.position.x,egg.position.y + 20)
		await get_tree().create_timer(1).timeout
		egg.visible = false
