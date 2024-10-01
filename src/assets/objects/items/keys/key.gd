extends RigidBody3D

const item = "key"
var pickedUp = false
var hovered = false

func _physics_process(_delta):
	hovered = false
	if pickedUp:
		queue_free()
