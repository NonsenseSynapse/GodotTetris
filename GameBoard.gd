extends Node2D

@export var tile_size: int
@export var width: int = 10
@export var height: int = 20
@export var default_tile_texture: Texture

# TODO: maybe remove?
@export var color: Color

var bg_texture_index: int = 0
var set_texture_index: int = 1
var board_cells: Array

class BoardCell:
	var x: int
	var y: int
	var texture_index: int
	var color_index: int
	
	func _init(x, y, texture_index, color_index):
		self.x = x
		self.y = y
		self.texture_index = texture_index
		self.color_index = color_index
	
	

# Called when the node enters the scene tree for the first time.
func _ready():
#	$Sprite2D.color = color
#	$ColorRect.color = color
#	$ColorRect.size = Vector2(tile_size * width, tile_size * height)
#	$ColorRect.show()
#	print($ColorRect.size)
	
	
#	$TileMap.show()
	print('made it after')
	
	for bg_x in range(0, width):
		board_cells.append([])
		for bg_y in range(0, height):
			var new_tile = BoardCell.new(bg_x, bg_y, 0, 0)
			board_cells[bg_x].append(new_tile)
	
	#print(board_cells)
	paint_bg_cells()
	
	paint_one_cell(5, 5)
	paint_one_cell(5, 6)
	paint_one_cell(6, 6)
	paint_one_cell(6, 7)
	
func paint_bg_cells():
	for cell_row in board_cells:
		for cell in cell_row:
			$TileMap.set_cell(0, Vector2(cell.x, cell.y), bg_texture_index, Vector2(0, 0))

func paint_one_cell(x, y):
	board_cells[x][y].color_index = set_texture_index
	$TileMap.set_cell(0, Vector2(x, y), set_texture_index, Vector2(0, 0))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
