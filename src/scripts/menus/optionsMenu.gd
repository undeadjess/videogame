extends MarginContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	add_fullscreenDropdown_items()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func add_fullscreenDropdown_items():
	$menu/menuList/dropdownFullscreen.add_item("Windowed")
	$menu/menuList/dropdownFullscreen.add_item("Borderless Windowed")
	$menu/menuList/dropdownFullscreen.add_item("Fullscreen")
func _on_dropdownFullscreen_item_selected(index):
	print(("receved request to update window display mode to index "), index)
	match index:
		0:
			print("updating window display mode to windowed...")
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		1:
			print("updating window display mode to fullscreen...")
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		2:
			print("updating window display mode to exclusive fulscreen...")
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)



func _on_buttonToggleSounds_pressed():
	pass # Replace with function body.


func _on_buttonReturn_pressed():
	get_tree().change_scene_to_file("res://scenes/menus/menuMain.tscn")




