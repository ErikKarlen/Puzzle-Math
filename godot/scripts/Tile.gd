extends Node2D

signal pressed

var tileValue = null

func _ready():
	var error = $Sprite.connect("pressed", self, "on_Sprite_pressed")
	if error:
		print("Failed to connect pressed signal, exiting...")
		get_tree().quit()

func on_Sprite_pressed():
	emit_signal("pressed", tileValue)
