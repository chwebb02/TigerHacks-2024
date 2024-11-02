extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MainMenuSounds.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_pressed() -> void:
	$MainMenuSounds.stop()
	pass # Replace with function body.
