extends Node3D

var interact = false
const OBJ = "ring"
var player


func _ready():
	player = $"../../AnimationPlayer"


func _physics_process(_delta):
	var parent = $"../../"
	if interact && !parent.complete:
		interact = false
		player.play("spin" + name)
		parent["ring_" + name] += 1
