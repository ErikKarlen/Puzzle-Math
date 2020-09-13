extends Node2D

export(int) var targetNumber = 0

func _ready():
	$Label.text = "Target: " + str(targetNumber)

func get_target():
	return targetNumber