extends Node2D

func _ready():
    var error = $Sprite.connect("pressed", self, "on_pressed")
    if error:
        print("Failed to connect pressed signal, exiting...")
        get_tree().quit()

func on_pressed():
	print("pressed")
