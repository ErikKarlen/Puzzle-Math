extends Node2D

export(int) var maxEquationLength = 8

onready var equation = ""
onready var value = 0
onready var expression = Expression.new()
onready var expressionString = ""

func update_equation(tileValue):
	if len(equation) >= maxEquationLength:
		equation = ""
		expressionString = ""
		value = 0
	if tileValue is int:
		expressionString += str(tileValue)
	else:
		expressionString += ".0" + str(tileValue)
	equation += str(tileValue)
	var error = expression.parse(expressionString, [])
	if error == OK:
		value = expression.execute([], null, true)
	$Label.text = equation + " = " + str(value)

func get_value():
	return value
