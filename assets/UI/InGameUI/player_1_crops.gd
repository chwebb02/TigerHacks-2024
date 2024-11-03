extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func incTomato():
	$Player1Tomatoes.text = $Player1Tomatoes.text + 1
	
func incPotato():
	$Player1Potato.text = $Player1Potato.text + 1
	
func incWheat():
	$Player1Wheat.text = $Player1Wheat.text + 1
