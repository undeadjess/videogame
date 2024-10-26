extends StaticBody3D

@onready var CAMERA := $SubViewport/Camera3D


func _physics_process(_delta):
	var monster = get_parent_node_3d().monster
	CAMERA.transform = monster.head.global_transform
	
