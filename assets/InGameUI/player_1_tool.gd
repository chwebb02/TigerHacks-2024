extends Sprite2D

@onready var _animations = get_node("AnimationPlayer")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	eggSplat()
	pass
	
func changeTool(tool: String):
	if _animations:
		_animations.play(tool + "2")
	else:
		print("AnimationPlayer node is null")
		
func eggSplat():
	if $EggSplat:
		$EggSplat.visible = true
		$EggSplat.frame = 5
	
