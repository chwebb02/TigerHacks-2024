extends Button

# Define the original size and hover size
var original_size = Vector2(100, 50)  # Set this to your button's original size
var hover_size = original_size * 1.2  # 20% larger for hover effect

func _ready():
	position = original_size

func _gui_input(event):
		if get_rect().has_point(event.position):
			
			scale = Vector2(1.1,1.1)  # Increase size on hover
			await get_tree().create_timer(.5).timeout
			scale = Vector2(1,1)
			
		else:
			scale = Vector2(1,1)
