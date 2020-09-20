extends Node2D

signal pressed

var tileValue = null
var isSelectable = true

func _ready():
	var error = $Sprite.connect("pressed", self, "on_Sprite_pressed")
	if error:
		print("Failed to connect pressed signal, exiting...")
		get_tree().quit()

func on_Sprite_pressed():
	if isSelectable:
		isSelectable = false
		emit_signal("pressed", get_grid_position())

func get_grid_position():
	var tileSize = $Sprite.texture.get_size()
	var gridPosition = position / tileSize - Vector2(0.5, 0.5)
	return Vector2(gridPosition[1], gridPosition[0])

func lock_tile():
	isSelectable = false
	$Sprite.modulate = Color(0.5, 0.5, 0.5)

func unlock_tile():
	isSelectable = true
	$Sprite.modulate = Color(1.0, 1.0, 1.0)