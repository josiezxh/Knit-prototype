extends Node2D

var direction = UP
var time = 0
var time_to_move = 0.015
@export var move_distance : float = 6
enum{nan, UP, DOWN, LEFT, RIGHT}

var body_tiles_list = []

@onready var scarf_body = preload("res://scarf_body.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	user_inputs()
	# Timer for movement
	time -= delta
	if (time < 0):
		move_scarf()
		time = time_to_move

# moves head of scarf based off user input
func move_scarf():
	if(direction == UP):
		global_translate(Vector2(0,-1) * move_distance)
	elif(direction == DOWN):
		global_translate(Vector2(0,1) * move_distance)
	elif(direction == LEFT):
		global_translate(Vector2(-1,0) * move_distance)
	elif(direction == RIGHT):
		global_translate(Vector2(1,0) * move_distance)
	# Move body along aswell
	var body_tiles = get_tree().get_nodes_in_group("body")
	for tile in body_tiles:
		tile.add_to_trail(direction) # adds heads movement to each tiles trail list

# Taking in user input for movement control
func user_inputs():
	if(Input.is_action_just_pressed("ui_up")):
		direction = UP
	elif(Input.is_action_just_pressed("ui_down")):
		direction = DOWN
	elif(Input.is_action_just_pressed("ui_left")):
		direction = LEFT
	elif(Input.is_action_just_pressed("ui_right")):
		direction = RIGHT

func add_body_tile():
	var last_tile = body_tiles_list.back() # returns null if empty
	if(last_tile):
		var instance = scarf_body.instantiate()
		get_owner().add_child(instance)
		instance.global_position = last_tile.global_position
		instance.move_trail = last_tile.move_trail.duplicate()
		body_tiles_list.append(instance) # add to my body tile list
	else: # first body tile being added to head
		var instance = scarf_body.instantiate()
		instance.get_node("CollisionShape2D").set_disabled(true)
		get_owner().add_child(instance)
		instance.global_position = global_position
		body_tiles_list.append(instance) # add to my body tile list

