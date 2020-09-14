extends Button

signal reset_pressed

func _pressed():
	print("RESET")
	emit_signal("reset_pressed")
