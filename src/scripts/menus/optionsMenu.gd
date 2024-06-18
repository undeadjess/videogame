extends MarginContainer




# Called when the node enters the scene tree for the first time.
func _ready():
	add_fullscreenDropdown_items()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_buttonToggleFullscreen_pressed():
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func add_fullscreenDropdown_items():
	$menu/menuList/dropdownFullscreen.add_item("a")


func _on_buttonToggleSounds_pressed():
	pass # Replace with function body.


func _on_buttonReturn_pressed():
	get_tree().change_scene_to_file("res://scenes/mainMenu.tscn")
