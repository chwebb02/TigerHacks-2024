extends Button

# Define the original size and hover size
var original_size = Vector2(100, 50)  # Set this to your button's original size
var hover_size = original_size * 1.2  # 20% larger for hover effect

func _ready():
	position = original_size


func _process(delta):
	if(is_hovered()):
		scale = Vector2(1.1,1.1)
	else:
		scale = Vector2(1,1)
		$AudioStreamPlayer2D.play()
		
		
