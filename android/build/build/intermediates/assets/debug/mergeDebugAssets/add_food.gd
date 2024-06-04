extends Control

var item = ['',0,0,0,0,0,0] #units,cals,protein,carbs,fat,icon,popularity
var nameKey = 'default'

func _ready():
	for i in len(global.foodicons):
		$icons.add_icon_item(global.foodicons[i])

	for i in global.menudic.keys():
		$deleteButton.get_popup().add_item(i)

	$deleteButton.get_popup().index_pressed.connect(delete_an_item)

#func _process(_delta):
#	pass
func delete_an_item(id):
	var ids = $deleteButton.get_popup().get_item_text(id)
	global.menudic.erase(ids)
	$deleteButton.get_popup().remove_item(id)
	global.save_lists()

func _on_icons_item_selected(index):
	item[-1] = index


func _on_cal_per_unit_value_changed(value):
	item[1] = value


func _on_carb_per_unit_value_changed(value):
	item[3] = value


func _on_fat_per_unit_value_changed(value):
	item[4] = value


func _on_pro_per_unit_value_changed(value):
	item[2] = value


func _on_save_pressed():
	global.menudic[nameKey] = item
	global.save_lists()


func _on_goback_pressed():
	get_tree().change_scene_to_file("res://main.tscn")


func _on_foodname_text_changed(new_text):
	nameKey = new_text


func _on_units_text_changed(new_text):
	item[0] = new_text
