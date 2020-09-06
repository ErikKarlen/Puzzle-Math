extends Node2D

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

export(Array, Array, TileType) var puzzleGrid = []

var grid = []

func _ready():
	randomize()
	create_grid()

func create_grid():
	var max_row_length = 0
	var max_column_length = 0
	for row in puzzleGrid.size():
		grid.append([])
		for col in puzzleGrid[row].size():
			var tile_instance = get_tile_scene(puzzleGrid[row][col]).instance()
			add_child(tile_instance)
			var tile_size = tile_instance.get_node("Sprite").texture.get_size()
			tile_instance.position = Vector2(
				tile_size[0] / 2 + col * tile_size[0],
				tile_size[1] / 2 + row * tile_size[1]
			)
			grid[row].append(tile_instance)
			if tile_instance.position[0] > max_row_length:
				max_row_length = tile_instance.position[0] + tile_size[0] / 2
			if tile_instance.position[1] > max_column_length:
				max_column_length = tile_instance.position[1] + tile_size[1] / 2

	var projectResolution = Vector2(
		ProjectSettings.get_setting("display/window/size/width"),
		ProjectSettings.get_setting("display/window/size/height")
	)
	print(max_row_length)
	print(max_column_length)
	position = Vector2(
		projectResolution[0] / 2 - max_row_length / 2,
		projectResolution[1] / 2 - max_column_length / 2
	)

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
			var random_operator = randi() % TileType.size()
			return get_tile_scene(random_operator)
		_:
			return Tile
