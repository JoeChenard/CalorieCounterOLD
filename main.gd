extends Control

var calories = 0
var protein = 0
var carbs = 0
var fat = 0

var random = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	random.randomize()
#	print(global.menudic)
#	print(global.trackingdic)
	
	for j in ['breakfast','lunch','dinner','snacks']:
		for i in global.trackingdic[global.date][j].keys():
			if not(i in global.menudic):
				pass
			else:#units,cals,protein,carbs,fat,icon
				calories += global.trackingdic[global.date][j][i]*global.menudic[i][1]
				protein += global.trackingdic[global.date][j][i]*global.menudic[i][2]
				carbs += global.trackingdic[global.date][j][i]*global.menudic[i][3]
				fat += global.trackingdic[global.date][j][i]*global.menudic[i][4]
	$calories.text = str(round(calories)) + 'Kcals'
	if (protein > 0) || (carbs > 0) || (fat > 0):
		$Macros.protein = snapped(100*protein/(protein + carbs + fat), 0.01)
		$Macros.carbs = snapped(100*carbs/(protein + carbs + fat), 0.01)
		$Macros.fat = snapped(100*fat/(protein + carbs + fat), 0.01)
	
	print(global.trackingdic)
	print(global.menudic)
#	$weight.get_line_edit().text = str(global.trackingdic[global.date]['weight']) + 'lbs'
	$weight.value = global.trackingdic[global.date]['weight']
	$BMR.text = str(round(BMRcalc(global.trackingdic[global.date]['weight']))) + 'Kcals'

	$water.value = global.trackingdic[global.date]['water']
	$water.get_line_edit().visible = false

	for i in range(0,$meals.get_item_count()):
		$meals.set_item_tooltip_enabled(i,false)
		
	$water.get_line_edit().set_virtual_keyboard_enabled(false)
	
	

func BMRcalc(lbs):
	var kg = lbs/2.205
	if global.personaldic['gender']:
		return (10*kg)+(6.25*global.personaldic['height'])-(5*global.personaldic['age'])+5
	else:
		return (10*kg)+(6.25*global.personaldic['height'])-(5*global.personaldic['age'])-161

func _process(_delta):
	if calories <= BMRcalc(global.trackingdic[global.date]['weight']):
		$Card.modulate = Color('313131')
	else:
		$Card.modulate = Color('881000')
	
#	$debug.text = 'menu: ' + str(global.menudic) + '\ntracking: ' + str(global.trackingdic) + '\npersonal: ' + str(global.personaldic)



func _on_addfood_pressed():
		get_tree().change_scene_to_file("res://add_food.tscn")


func _on_meals_item_selected(index):
	match(index):
		0:
			get_tree().change_scene_to_file("res://breakfast.tscn")
		1:
			get_tree().change_scene_to_file("res://lunch.tscn")
		2:
			get_tree().change_scene_to_file("res://dinner.tscn")
		3:
			get_tree().change_scene_to_file("res://snacks.tscn")


func _on_settings_pressed():
	get_tree().change_scene_to_file("res://settings.tscn")


func _on_water_value_changed(value):
	global.trackingdic[global.date]['water'] = value
	$water/AnimatedSprite2D.frame = value
	$water/Label.text = str(value)
	print(global.trackingdic)
	global.save_lists()


func _on_weight_value_changed(value):
	global.trackingdic[global.date]['weight'] = value
	$BMR.text = str(round(BMRcalc(global.trackingdic[global.date]['weight']))) + 'Kcals'
	global.save_lists()
#	$weight.get_line_edit().text = str(global.trackingdic[global.date]['weight']) + 'lbs'


func _on_log_pressed():
	if calories <= BMRcalc(global.trackingdic[global.date]['weight']):
		if random.randi_range(0,1) == 1:
			$proud.play()
		else:
			$goodjob.play()


func _on_statistics_pressed():
	get_tree().change_scene_to_file("res://data.tscn")
#	global.export_saves()
#	print('exported!')
#	global.menudic = {} 
#	global.trackingdic = {}
#	global.personaldic = {}
