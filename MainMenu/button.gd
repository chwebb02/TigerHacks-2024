extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _pressed():
	OS.shell_open("https://docs.google.com/document/d/1kxF6jKEciZ63IcCx4lf5uuG5WUAJqUKcuCKpcfppgz4/edit?usp=sharing")
