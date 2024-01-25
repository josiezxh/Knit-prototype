extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_entered(area):
	if(area.name == "head"):
	 #calling end_game func in level
		var main = get_tree().get_first_node_in_group("main")
		main.end_game()
