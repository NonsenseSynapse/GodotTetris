extends Node2D

var current_shape
var rotation_lock = false
var slow_drop_lock = false
var movement_lock = false

# Called when the node enters the scene tree for the first time.
func _ready():
	var shape = $ShapeGenerator.generate()
	current_shape = shape
	shape.show()
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#
	# Rotation
	#
	if !rotation_lock and Input.is_action_pressed("rotate_left"):
		rotation_lock = true
		$RotationTimer.start()
		current_shape.rotate_block_sprite()
	if !rotation_lock and Input.is_action_pressed("rotate_right"):
		rotation_lock = true
		$RotationTimer.start()
		current_shape.rotate_block_sprite(false)
		
	#
	# Slow Drop
	#
	if !slow_drop_lock and Input.is_action_pressed("slow_drop"):
		slow_drop_lock = true
		$SlowDropTimer.start()
		drop_block_one_step()
		
	#
	# Moving left and right
	#
	if !movement_lock and Input.is_action_pressed("move_left"):
		movement_lock = true
		$MovementTimer.start()
		move_block_left()
	if !movement_lock and Input.is_action_pressed("move_right"):
		movement_lock = true
		$MovementTimer.start()
		move_block_right()
		

func drop_block_one_step():
	current_shape.translate(Vector2(0, $ShapeGenerator.step_increment))
	
func move_block_left():
	current_shape.translate(Vector2(-$ShapeGenerator.step_increment, 0))
	
func move_block_right():
	current_shape.translate(Vector2($ShapeGenerator.step_increment, 0))
	
func _on_drop_timer_timeout():
	drop_block_one_step()
	print(current_shape.tile.get_rect())

func _on_rotation_timer_timeout():
	rotation_lock = false


func _on_slow_drop_timer_timeout():
	slow_drop_lock = false


func _on_movement_timer_timeout():
	movement_lock = false
