extends CharacterBody3D


signal playerCollide

var SPEED_MULTIPLIER = 3.0
var pathing = true
var start_pathing = false
var time = 0

@onready var nav_agent = $NavigationAgent3D
@onready var head := $Head


func _physics_process(_delta):
	var moving = abs(velocity.x) > 0.1 || abs(velocity.z) > 0.1
	if moving:
		rotation.y = 9.4 + atan2(velocity.x, velocity.z)
	if start_pathing && pathing:
		time += 0.05
		var speed = (sin(time) / 2 + 0.5) * SPEED_MULTIPLIER
		var current_location = global_transform.origin
		var next_location = nav_agent.get_next_path_position()
		var new_velocity = (next_location - current_location).normalized() * speed
		
		velocity = velocity.move_toward(new_velocity, 0.25)
		move_and_slide()
		var playerPos = nav_agent.target_position
		var distance = playerPos.distance_to(head.global_position)
		if distance < 1.1:
			playerCollide.emit()
			pathing = false

	start_pathing = true


func update_target_location(target_location):
	nav_agent.target_position = target_location
