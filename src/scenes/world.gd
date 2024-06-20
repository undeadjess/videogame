extends Node3D

@onready var player = $Player
@onready var monster = $Monster

func _physics_process(_delta):
	monster.update_target_location(player.global_position)
