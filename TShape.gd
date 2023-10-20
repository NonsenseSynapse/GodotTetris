extends Node2D

@export_multiline var cells: String
@export var color: Color
@export var weight = 1.0
@export var tile_texture: Texture

var rotation_rads = PI / 2
var rotation_degs = 90

var tile_map: Array
var tile_container_size: int
var tile_square_length
var edge_pos
var coordinate_matrices = [[-1,1], [-1,0,1],[-2,-1,1,2]]
var tile

# How many seconds we wait to automatically move a block down
var movement_speed = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	var lines = cells.split("\n")
	for line in lines:
		var row = []
		for ch in line:
			row.append(ch == "x")
		tile_map.append(row)
	tile_container_size = int(max(tile_map.size(), tile_map[0].size()))

	
	# Create Tile
	tile = Sprite2D.new()
	tile.texture = tile_texture
	tile.modulate = color

	# Evaluate useful vars
	tile_square_length = tile_texture.get_size().x
	edge_pos = tile_square_length * tile_container_size / 2.0

	# Add the tiles as child nodes
	set_tile_positions(true)
	hide()

func set_tile_positions(add_tiles = false):
	var pos = Vector2.ZERO
	var idx = 0
	for row in tile_map:
		for cell in row:
			if cell:
				if add_tiles:
					tile.position = pos
					add_child(tile.duplicate())
				else:
					get_child(idx).position = pos
					idx += 1
			pos.x += tile_square_length
		pos.x = 0
		pos.y += tile_square_length

#func rotate_block(left=true):
#	# TODO: this feels more complicated than it needs to be?
#
#	var rotation_matrix = coordinate_matrices[tile_container_size - 2]
#	var rotated_tiles = tile_map.duplicate(true)
#	if left:
#		for y in tile_container_size:
#			var xx = rotation_matrix.find(-rotation_matrix[y])
#			for x in tile_container_size:
#				rotated_tiles[y][x] = tile_map[x][xx]
#	else:
#		for x in tile_container_size:
#			var yy = rotation_matrix.find(-rotation_matrix[x])
#			for y in tile_container_size:
#				rotated_tiles[y][x] = tile_map[yy][y]
#	tile_map = rotated_tiles
#	set_tile_positions(false)
	
func rotate_block_sprite(left=true):
	var rotation_val = rotation_degs
	if left:
		rotation_val = -rotation_val
		
	self.rotation_degrees = int(self.rotation_degrees + rotation_val) % 360


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
