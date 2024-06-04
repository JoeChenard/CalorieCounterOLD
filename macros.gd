extends Control

var fat = 0
var carbs = 0
var protein = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$fat.value = fat + carbs + protein
	$carbs.value = carbs + protein
	$protein.value = protein
	$Label.text = str(protein) + "% Protein\n" + str(carbs) + "% Carbs\n" + str(fat) + "% Fat"
