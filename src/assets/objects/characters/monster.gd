extends CharacterBody3D


signal playerCollide

var speedMultiplier = 3.0
var pathing = true
var startPathing = false
var time = 0

@onready var nav_agent = $NavigationAgent3D
@onready var head := $Head
@onready var camera := $Head/Camera3D

func _physics_process(_delta):
	if(startPathing && pathing):
		time += 0.05
		var speed = (sin(time) / 2 + 0.5) * speedMultiplier
		var current_location = global_transform.origin
		var next_location = nav_agent.get_next_path_position()
		var new_velocity = (next_location - current_location).normalized() * speed
		
		velocity = velocity.move_toward(new_velocity, 0.25)
		move_and_slide()

	startPathing = true

func update_target_location(target_location):
	nav_agent.target_position = target_location

func _on_area_3d_body_entered(body: Node3D):
	if(body.has_meta("player")):
		playerCollide.emit()
		pathing = false
