extends Node2D

signal tilePressed # TODO: change to tile_pressed

enum TileType {
	ZERO,
	ONE,
	TWO,
	THREE,
	FOUR,
	FIVE,
	SIX,
	SEVEN,
	EIGHT,
	NINE,
	ADDITION,
	SUBTRACTION,
	MULTIPLICATION,
	DIVISION,
	RANDOM_NUMBER,
	RANDOM_OPERATOR,
	RANDOM,
	NONE
}

const NUMBERS_COUNT = 10
const OPERATORS_COUNT = 4

const Tile = preload("res://scenes/Tile.tscn")
const ZeroTile = preload("res://scenes/numbers/ZeroTile.tscn")
const OneTile = preload("res://scenes/numbers/OneTile.tscn")
const TwoTile = preload("res://scenes/numbers/TwoTile.tscn")
const ThreeTile = preload("res://scenes/numbers/ThreeTile.tscn")
const FourTile = preload("res://scenes/numbers/FourTile.tscn")
const FiveTile = preload("res://scenes/numbers/FiveTile.tscn")
const SixTile = preload("res://scenes/numbers/SixTile.tscn")
const SevenTile = preload("res://scenes/numbers/SevenTile.tscn")
const EightTile = preload("res://scenes/numbers/EightTile.tscn")
const NineTile = preload("res://scenes/numbers/NineTile.tscn")
const AdditionTile = preload("res://scenes/operators/AdditionTile.tscn")
const SubtractionTile = preload("res://scenes/operators/SubtractionTile.tscn")
const MultiplicationTile = preload("res://scenes/operators/MultiplicationTile.tscn")
const DivisionTile = preload("res://scenes/operators/DivisionTile.tscn")

export(Vector2) var positionOffset
export(Array, Array, TileType) var puzzleGrid = []
export(int) var gridHeight = 1
export(int) var gridWidth = 1

var grid = []
var maxRowLength = 0
var maxColumnLength = 0
var selectedTiles = []

func _ready():
	randomize()
	create_grid()

func create_grid():
	if !puzzleGrid && gridHeight > 0 && gridWidth > 0:
		for i in range(gridHeight):
			puzzleGrid.append([])
			for _j in range(gridWidth):
				puzzleGrid[i].append(randi() % (NUMBERS_COUNT + OPERATORS_COUNT))
	else:
		print("Invalid grid size, exiting...")
		get_tree().quit()

	for row in puzzleGrid.size():
		grid.append([])
		for col in puzzleGrid[row].size():
			create_grid_tile(row, col)

	var projectResolution = Vector2(
		ProjectSettings.get_setting("display/window/size/width"),
		ProjectSettings.get_setting("display/window/size/height")
	)
	position = positionOffset + Vector2(
		projectResolution[0] / 2 - maxRowLength / 2,
		projectResolution[1] / 2 - maxColumnLength / 2
	)

func create_grid_tile(row, col):
	var tile_instance = get_tile_scene(puzzleGrid[row][col]).instance()
	add_child(tile_instance)
	var tile_size = tile_instance.get_node("Sprite").texture.get_size()
	tile_instance.position = Vector2(
		tile_size[0] / 2 + col * tile_size[0],
		tile_size[1] / 2 + row * tile_size[1]
	)
	if tile_instance.position[0] > maxRowLength:
		maxRowLength = tile_instance.position[0] + tile_size[0] / 2
	if tile_instance.position[1] > maxColumnLength:
		maxColumnLength = tile_instance.position[1] + tile_size[1] / 2
	grid[row].append(tile_instance)
	var error = tile_instance.connect("pressed", self, "on_Tile_pressed")
	if error:
		print("Failed to connect pressed signal, exiting...")
		get_tree().quit()
	return tile_instance


func get_tile_scene(tileType):
	match tileType:
		TileType.ZERO:
			return ZeroTile
		TileType.ONE:
			return OneTile
		TileType.TWO:
			return TwoTile
		TileType.THREE:
			return ThreeTile
		TileType.FOUR:
			return FourTile
		TileType.FIVE:
			return FiveTile
		TileType.SIX:
			return SixTile
		TileType.SEVEN:
			return SevenTile
		TileType.EIGHT:
			return EightTile
		TileType.NINE:
			return NineTile
		TileType.ADDITION:
			return AdditionTile
		TileType.SUBTRACTION:
			return SubtractionTile
		TileType.MULTIPLICATION:
			return MultiplicationTile
		TileType.DIVISION:
			return DivisionTile
		TileType.RANDOM_NUMBER:
			var random_number = randi() % NUMBERS_COUNT
			return get_tile_scene(random_number)
		TileType.RANDOM_OPERATOR:
			var random_operator = OPERATORS_COUNT + randi() % NUMBERS_COUNT
			return get_tile_scene(random_operator)
		TileType.RANDOM:
			var random_operator = randi() % (NUMBERS_COUNT + OPERATORS_COUNT)
			return get_tile_scene(random_operator)
		_:
			return Tile

func on_Tile_pressed(tileValue, gridPosition):
	var selectedTile = grid[gridPosition[0]][gridPosition[1]]
	if len(selectedTiles) > 0:
		var diff = selectedTiles[-1].get_grid_position() - gridPosition
		if diff.length_squared() <= 1 && !(selectedTile in selectedTiles):
			if !(selectedTile.tileValue is String && selectedTiles[-1].tileValue is String):
				selectedTiles.append(selectedTile)
				emit_signal("tilePressed", tileValue)
	elif selectedTile.tileValue is int:
		selectedTiles.append(selectedTile)
		emit_signal("tilePressed", tileValue)

func reset_grid():
	selectedTiles = []
