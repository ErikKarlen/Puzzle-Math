extends Node2D

signal target_reached

export(int) var levelNumber = 0

func _ready():
	$LevelLabel.text = "Level: " + str(levelNumber)
	var error = $Grid.connect("tilePressed", self, "on_Grid_tilePressed")
	if error:
		print("Failed to connect tile_pressed signal, exiting...")
		get_tree().quit()
	error = $ResetButton.connect("reset_pressed", self, "on_ResetButton_reset_pressed")
	if error:
		print("Failed to connect reset_pressed signal, exiting...")
		get_tree().quit()

func on_Grid_tilePressed(tileValue):
	$Equation.update_equation(tileValue)
	if $Equation.get_value() == $Target.get_target():
		emit_signal("target_reached")
		print("Target reached!")

func on_ResetButton_reset_pressed():
	$Grid.reset_grid()
	$Equation.reset_equation()
