extends Node3D

var interact = false
const obj = "ring"
var player

func _ready():
	player = $"../../AnimationPlayer"

func _physics_process(_delta):
	var parent = $"../../"
	if(interact && !parent.complete):
		interact = false
		player.play("spin" + name)
		parent["ring" + name] += 1
