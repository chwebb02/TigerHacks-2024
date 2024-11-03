extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

var curr = 0
func _pressed():
	if(curr==0):
		get_parent().get_node("TextureRect4").visible = false
		get_parent().get_node("TextureRect5").visible = true
	if(curr==1):
		get_parent().get_node("TextureRect5").visible = false
		get_parent().get_node("TextureRect6").visible = true
	if(curr==2):
		get_parent().get_node("TextureRect6").visible = false
		get_parent().get_node("TextureRect7").visible = true
		text = "PLAY"
	if(curr==3):
		get_parent().get_node("TextureRect7").visible = false
		get_parent().startGame()
	curr = curr + 1
		
