extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta):
	if(is_hovered()):
		scale = Vector2(1.1,1.1)
		
	else:
		scale = Vector2(1,1)
		$AudioStreamPlayer2D.play()
		
func _pressed():
	get_tree().quit()
