extends Node

var CC_file = "user://caloryCounter.save"
var menudic = {}
var trackingdic = {}
var personaldic = {'height':0,'age':0,'gender':false}
var foodicons = {}

var meal = ''

var date = Time.get_date_string_from_system()

var stats_file = "user://CC_statistics.csv"
#var breakfast = {}
#var lunch = {}
#var dinner = {}
#var snacks = {}
#var weight = 0.0
#var water = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	print('global call')
	for i in 23:
		foodicons[i] = load("res://assets/foods/food"+ str(i+1)+".png")
	
#	save_lists()
	load_lists()
#	for i in menudic:
#		if len(i) < 7:
#			i.append(0)
	
#	if trackingdic.has(date):
#		breakfast = trackingdic[date]['breakfast']
#		lunch = trackingdic[date]['lunch']
#		dinner = trackingdic[date]['dinner']
#		snacks = trackingdic[date]['snacks']
#		weight = trackingdic[date]['weight']
#		water = trackingdic[date]['water']
#	else:
#		trackingdic[date] = {}
	if not trackingdic.has(date):
		trackingdic[date] = {'breakfast':{},'lunch':{},'dinner':{},'snacks':{},'weight':0.0,'water':0}
	
	stats_file = OS.get_system_dir(3) + '/CC_statistics.csv'
	OS.request_permissions()

#func _notification(notif):
#	MainLoop.notifiction_w
#	if notif == MainLoop.NOTIFICATION_WM_FOCUS_OUT:
#		save_lists() 
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(_delta):
#	pass

#TODO
#add save and load
#make it so save whenever app minimized as well as on logging
func load_lists():
	var file = FileAccess.open(CC_file, FileAccess.READ)
	if FileAccess.file_exists(CC_file):
		var content = file.get_var()
#		print('content 2:')
#		print(content[2])
		menudic = content[0]
		trackingdic = content[1]
		personaldic = content[2]
#	else:
#		menudic = {}
#		trackingdic = {}
#		personaldic = {}
		
func save_lists():
#	trackingdic[date] = {}
#	trackingdic[date]['breakfast'] = breakfast
#	trackingdic[date]['lunch'] = lunch
#	trackingdic[date]['dinner'] = dinner
#	trackingdic[date]['snacks'] = snacks
#	trackingdic[date]['weight'] = weight
#	trackingdic[date]['water'] = water
#	print('saving: ' + str(personaldic))
	var savetuple = [menudic, trackingdic, personaldic]
	var file = FileAccess.open(CC_file, FileAccess.WRITE)
	file.store_var(savetuple)

func export_saves(): #date, weight, calories, protein, carbs, fat
	var file = FileAccess.open(stats_file, FileAccess.WRITE)
#	file.store_csv_line(['banana','orange','pineapple']) #how to store a line in excel
#	file.store_csv_line(['1','2','3'])
	file.store_csv_line(['date(ISO8601)', 'weight(lbs)', 'calories(Kcal)', 'protein(g)', 'carbs(g)', 'fat(g)', 'water(cups)'])
	for day in trackingdic.keys():
		print(day)
		var cals = 0
		var protein = 0
		var carbs = 0
		var fat = 0
		for meal in ['breakfast','lunch','dinner']:
			for item in trackingdic[day][meal].keys(): #menu format: units,cals,protein,carbs,fat,icon
				if menudic.has(item):
					cals += trackingdic[day][meal][item] * menudic[item][1] #cals += amount*cals
					protein += trackingdic[day][meal][item] * menudic[item][2]
					carbs += trackingdic[day][meal][item] * menudic[item][3]
					fat += trackingdic[day][meal][item] * menudic[item][4]
		file.store_csv_line([day,str(trackingdic[day]['weight']),str(cals),str(protein),str(carbs), str(fat), str(trackingdic[day]['water'])])

#save structure 
#tracking= ['date',[breakfast],[lunch],[dinner],[snack],weight]
#menu item = [units,cals,protein,carbs,fat,icon]
#each meal consists of []

#Time.get_date_string_from_system() # 'YYY-MM-DD'
#
#	f.store_var(savetuple)
#	f.close()
#
#
#	file.store_string(content)
	
