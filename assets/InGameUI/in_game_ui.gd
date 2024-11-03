extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_player_1_throw_egg() -> void:
	$Control2/Player1Tool.eggSplat()
	pass # Replace with function body.


func _on_player_2_throw_egg() -> void:
	$Control2/Player2Tool.eggSplat()
	pass # Replace with function body.


func _on_player_1_switch_to_tool(tool:String) -> void:
	$Control2/Player1Tool.changeTool(tool)
	pass # Replace with function body.


func _on_player_2_switch_to_tool(tool:String) -> void:
	$Control2/Player2Tool.changeTool(tool)
	pass # Replace with function body.
