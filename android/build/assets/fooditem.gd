extends Control

signal change(itemName, value)
signal trash
var id

var itemName = ''
var units = ''
var icon = 0
var Bcals = 0
var Bprotein = 0
var Bcarbs = 0
var Bfat = 0
var cals = 0
var protein = 0
var carbs = 0
var fat = 0
#var Bvalue = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$icon.set_texture(global.foodicons[icon])
	$icon.set_region_rect(Rect2(0,100,32,32))
	self.set_custom_minimum_size(Vector2(720,405))
	
	print(itemName)
	$foodname.text = itemName
	$units.text = units
	
	

func _process(_delta):
	pass

func _on_input_value_changed(value):
	cals = value*Bcals
	protein = value*Bprotein
	carbs = value*Bcarbs
	fat = value*Bfat
	updateinfo()
	emit_signal("change", itemName, value)

func updateinfo():
	$nutrients.text = str(cals) + 'kcals\n' + str(protein) + 'g\n' + str(carbs) + 'g\n' + str(fat) + 'g'
#	$nutrients1.text = str(cals) + 'kcals\n' + str(protein) + 'g'
#	$nutrients2.text = str(carbs) + 'g\n' + str(fat) + 'g'


func _on_trash_pressed():
	global.trackingdic[global.date][global.meal].erase(itemName)
	emit_signal('trash')
