extends Node

var tshapes = []
var mass = 0.0
var step_increment

# Called when the node enters the scene tree for the first time.
func _ready():
	for node in get_children():
		step_increment = node.tile_square_length
		# Cast the node variant type to a type of TShape
		# var tshape: TShape = node
		# Add up the weights
		# mass += tshape.weight
		tshapes.append(node)


func generate():
	var random_shape = tshapes[randi() % tshapes.size()]
	return random_shape

func test_generator():
	var pos = Vector2(80, 20)
	for t in get_children():
		t.rotate(false)
		t.position = pos
		pos.y += t.tile_container_size * t.tile_square_length + 5
