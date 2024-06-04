extends "res://meals.gd"


func _ready():
	global.meal = 'dinner'
	super()
	$foodList.get_popup().set_max_size(DisplayServer.reso)
	
	for id in global.trackingdic[global.date]['dinner'].keys():
		if not(id in global.menudic):
			pass
		else:
			var newitem = item.instantiate()
			newitem.itemName = id
			newitem.units = global.menudic[id][0]
			newitem.Bcals = global.menudic[id][1]
			newitem.Bprotein = global.menudic[id][2]
			newitem.Bcarbs = global.menudic[id][3]
			newitem.Bfat = global.menudic[id][4]
			newitem.icon = global.menudic[id][5]
			$selectedfood/box.add_child(newitem)
			newitem.id = newitem.get_instance_id()
			newitem.trash.connect(delete)
			newitem.change.connect(updateMeal)
			newitem._on_input_value_changed(global.trackingdic[global.date]['dinner'][id])
			newitem.get_child(1).get_line_edit().text = str(global.trackingdic[global.date]['dinner'][id])


func updateMeal(itemName, value):
#	print('tracking' + str(global.trackingdic))
	global.trackingdic[global.date]['dinner'][itemName] = value
	super(itemName, value)

