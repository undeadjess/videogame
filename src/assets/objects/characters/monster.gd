extends CharacterBody3D


signal playerCollide

var SPEED = 1.0
var pathing = true
var startPathing = false
var time = 0

@onready var nav_agent = $NavigationAgent3D
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var head := $Head
@onready var camera := $Head/Camera3D

func _physics_process(_delta):
	if(startPathing && pathing):
		time += 0.05
		SPEED = (sin(time) / 2 + 0.5)
		var current_location = global_transform.origin
		var next_location = nav_agent.get_next_path_position()
		var new_velocity = (next_location - current_location).normalized() * SPEED
		
		velocity = velocity.move_toward(new_velocity, 0.25)
		move_and_slide()
		var playerPos = nav_agent.target_position
		var distance = playerPos.distance_to(head.global_position)
		if(distance < 1.25):
			playerCollide.emit()
			pathing = false

	startPathing = true

func update_target_location(target_location):
	nav_agent.target_position = target_location
