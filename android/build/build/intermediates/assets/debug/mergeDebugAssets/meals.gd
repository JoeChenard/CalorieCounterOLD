extends Control

var item = preload("res://food_item.tscn")

var calories = 0
var protein = 0
var carbs = 0
var fat = 0
var meal = []


# Called when the node enters the scene tree for the first time.
func _ready():
	global.load_lists()
	for i in global.menudic.keys():
		$foodList.get_popup().add_item(i, int(i))
	
	$foodList.get_popup().index_pressed.connect(addfooditem)
#	$foodList.panel.

func _process(_delta):
	calories = 0
	protein = 0
	carbs = 0
	fat = 0
	for i in $selectedfood/box.get_children():
		calories += i.cals
		protein += i.protein
		carbs += i.carbs
		fat += i.fat
	
	$calories.text = str(round(calories)) + 'kcals'
	if (protein > 0) || (carbs > 0) || (fat > 0):
		$Macros.protein = snapped(100*protein/(protein + carbs + fat), 0.01)
		$Macros.carbs = snapped(100*carbs/(protein + carbs + fat), 0.01)
		$Macros.fat = snapped(100*fat/(protein + carbs + fat), 0.01)

func addfooditem(id):
	id = $foodList.get_popup().get_item_text(id)
	var newitem = item.instantiate()
	newitem.itemName = id
	newitem.units = global.menudic[id][0]
	newitem.Bcals = global.menudic[id][1]
	newitem.Bprotein = global.menudic[id][2]
	newitem.Bcarbs = global.menudic[id][3]
	newitem.Bfat = global.menudic[id][4]
	newitem.icon = global.menudic[id][5]
	
	$selectedfood/box.add_child(newitem)
	$selectedfood/box.move_child(newitem, 0)
#	newitem.id = newitem.get_instance_id()
#	print('id'+str(id))
	newitem.trash.connect(delete)
	newitem.change.connect(updateMeal)
	
#	$selectedfood.scroll_vertical = 10000000000#not sure how to find scroll max value in gdscript2.0, still doesn't work quite right
	
func updateMeal(itemName, value):
	global.save_lists()


func delete():
#	print(global.trackingdic[global.date]['breakfast'].erase(itemName))
#	global.trackingdic[global.date]['breakfast'].erase(itemName)
	global.save_lists()
	get_tree().reload_current_scene()
#	$selectedfood/box.remove_child(instance_from_id(itemName))
	

func _on_food_list_pressed():
	if len(global.menudic) > 30:
		DisplayServer.virtual_keyboard_show('')


func _on_goback_pressed():
	get_tree().change_scene_to_file("res://main.tscn")
