extends Node2D

signal target_reached

export(int) var levelNumber = 0
export(int) var maxSelectableTiles = 8

func _ready():
	var error = $Grid.connect("tilePressed", self, "on_Grid_tilePressed")
	if error:
		print("Failed to connect tile_pressed signal, exiting...")
		get_tree().quit()
	error = $ResetButton.connect("reset_pressed", self, "on_ResetButton_reset_pressed")
	if error:
		print("Failed to connect reset_pressed signal, exiting...")
		get_tree().quit()
	error = $Timer.connect("timeout", self, "on_Timer_timeout")
	if error:
		print("Failed to connect timeout signal, exiting...")
		get_tree().quit()

	$LevelLabel.text = "Level: " + str(levelNumber)

func on_Grid_tilePressed(tileValue):
	$Equation.update_equation(tileValue)
	if $Equation.get_value() == $Target.get_target():
		$Timer.start()
		$Equation.correct_equation()
		$Grid.lock_grid_selection()
		emit_signal("target_reached")
	elif len($Grid.selectedTiles) >= maxSelectableTiles:
		$Timer.start()
		$Equation.lock_equation()
		$Grid.lock_grid_selection()

func on_ResetButton_reset_pressed():
	reset_level()

func on_Timer_timeout():
	reset_level()

func reset_level():
	$Grid.reset_grid_selection()
	$Equation.reset_equation()
