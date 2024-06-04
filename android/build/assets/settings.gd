extends Control

var feet = 0
var inches = 0

func _ready():
	
	print(global.personaldic)

func _process(_delta):
	if global.personaldic['gender']:
		$gender.text = ' male'
	else:
		$gender.text = ' female'

func _on_gender_toggled(button_pressed):
	global.personaldic['gender'] = not global.personaldic['gender']


func _on_feet_value_changed(value):
	feet = value
	global.personaldic['height'] = ((feet*12)+inches)*2.54 #height in cm


func _on_inches_value_changed(value):
	inches = value
	global.personaldic['height'] = ((feet*12)+inches)*2.54 #height in cm


func _on_age_value_changed(value):
	global.personaldic['age'] = value


func _on_back_pressed():
	global.save_lists()
	get_tree().change_scene_to_file("res://main.tscn")
