extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("title")
	$MainMenuSounds.play()
	$Button2.visible = false
	$TextureRect4.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_pressed() -> void:
	$TextureRect4.visible = true
	$Button2.visible = true


func startGame():
	$MainMenuSounds.stop()
	$TextureRect2.visible = true
	$Button2.visible = false
	$TextureRect2/Label.text = "3"
	$AudioStreamPlayer2D.play()
	await get_tree().create_timer(1).timeout
	$TextureRect2/Label.text = "2"
	$AudioStreamPlayer2D.play()
	await get_tree().create_timer(1).timeout
	$TextureRect2/Label.text = "1"
	$AudioStreamPlayer2D.play()
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://scenes/Main.tscn")
