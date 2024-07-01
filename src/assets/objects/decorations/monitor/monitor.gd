extends StaticBody3D

@onready var camera := $SubViewport/Camera3D

func _physics_process(_delta):
	var monster = get_parent_node_3d().monster
	camera.transform = monster.transform
	
