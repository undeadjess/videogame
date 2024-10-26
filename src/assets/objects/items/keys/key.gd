extends RigidBody3D

const ITEM = "key"
var picked_up = false
var hovered = false


func _physics_process(_delta):
	hovered = false
	if picked_up:
		queue_free()
