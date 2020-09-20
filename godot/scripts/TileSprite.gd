extends Sprite

signal pressed

func _process(_delta):
	if Input.is_action_pressed("ui_touch"):
		if get_rect().has_point(get_local_mouse_position()):
			emit_signal("pressed")
