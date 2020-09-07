extends Node2D

export(int) var levelNumber = 0

func _ready():
	$Label.text = "Level: " + str(levelNumber)
