extends Node2D

export(int) var maxEquationLength = 8

var equationString = ""
var equationValue = 0

func update_equation(tileValue):
	if len(equationString) >= maxEquationLength:
		equationString = ""
		equationValue = 0
	equationString += str(tileValue)
	$Label.text = "Equation: " + equationString
	print(tileValue)
