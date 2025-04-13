extends RichTextLabel

var text_file_path = "res://Dialogue/foobar.txt"
var file = FileAccess.open(text_file_path, FileAccess.READ)
var content = file.get_as_text()
var list = content.split("\n")
var index = 0


func _ready():
	for i in list:
		print (i)

func _on_gui_input(_event: InputEvent):
	if Input.is_action_pressed("shoot"):
		if index < list.size() - 1:
			text = list[index]
			index += 1
		else:
			print("fyra noll fyra loser")
