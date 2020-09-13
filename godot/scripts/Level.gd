extends Node2D

signal target_reached

export(int) var levelNumber = 0

func _ready():
	$LevelLabel.text = "Level: " + str(levelNumber)
	var error = $Grid.connect("tilePressed", self, "on_Grid_tilePressed")
	if error:
		print("Failed to connect pressed signal, exiting...")
		get_tree().quit()

func on_Grid_tilePressed(tileValue):
	$Equation.update_equation(tileValue)
	if $Equation.get_value() == $Target.get_target():
		emit_signal("target_reached")
		print("Target reached!")
