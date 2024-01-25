extends Node2D

@onready var yarn = preload("res://yarn.tscn")
var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	add_yarn()


func add_yarn():
	var instance = yarn.instantiate()
	instance.global_position = Vector2(randi_range(-500,500),randi_range(-250,250))
	# in yarn, connect signal "yarn_used" to calling function spawn_yarn
	instance.yarn_used.connect(spawn_yarn)
	# adding a yarn node to level node
	add_child(instance)

func spawn_yarn():
	score += 5
	add_yarn()
	# add a scarf body tile
	$scarf.add_body_tile()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Container/score_lable.text = "Rows: " + (str(score))

func end_game():
	# print("game over")
	# add end game code
	get_tree().paused = true
	
