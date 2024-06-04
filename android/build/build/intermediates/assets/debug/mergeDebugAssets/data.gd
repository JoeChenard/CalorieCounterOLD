extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in global.trackingdic.keys():
		$date.get_popup().add_item(i, int(i))
	
	$date.get_popup().index_pressed.connect(changedate)

func changedate(id):
	id = $date.get_popup().get_item_text(id)
	print(id)
	global.date = id
	$Label.text = 'date changed to: ' + id

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_back_pressed():
	get_tree().change_scene_to_file("res://main.tscn")


func _on_export_pressed():
	global.export_saves()
	$Label.text = 'exported to: ' + OS.get_system_dir(3) + '/CC_statistics.csv'
