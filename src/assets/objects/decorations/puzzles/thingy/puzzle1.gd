extends Node3D

var interact = false
const obj = "ring"
var player

func _ready():
	player = $"../../AnimationPlayer"

func _physics_process(_delta):
	if(interact):
		interact = false
		player.play("spin" + name)
