extends Node2D

@onready var bar: ProgressBar = $ProgressBar

func update_bar(current: int, max: int):
	if max > 0 and bar:
		bar.value = float(current) / float(max) * 100
	else:
		print("Error: ProgressBar is Nil or invalid!")
