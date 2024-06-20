extends MarginContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# play button
func _on_buttonPlay_pressed():
	get_tree().change_scene_to_file("res://scenes/map-main.tscn")


func _on_buttonOptions_pressed():
	get_tree().change_scene_to_file("res://scenes/menus/menuOptions.tscn")


func _on_buttonCredits_pressed():
	print("credits button pressed")


func _on_buttonExit_pressed():
	print("exit button pressed, closing")
	get_tree().quit()
