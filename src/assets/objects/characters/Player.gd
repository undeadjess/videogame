extends CharacterBody3D

var speed
const WALK_SPEED = 2
const SPRINT_SPEED = 3.5
const JUMP_VELOCITY = 4.5
const SENSITIVITY = 0.001

const ITEM_RAY_LENGTH = 1000.0

#view bobbing
const BOB_FREQ = 2.0
const BOB_AMP = 0.07
var t_bob = 0.0
var alive = true
var inventory = {
	"keys": {
		"keys": 0,
		"bronzeKey": false,
		"silverKey": false,
		"goldKey": false
	},
	"items": {
		"shovel": false
	}
}
var stamina = 1
var from = Vector3(0, 0, 0)
var to = Vector3(0, 0, 0)

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var head := $Head
@onready var camera := $Head/Camera3D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion && alive:
			head.rotate_y(-event.relative.x * 0.001)
			camera.rotate_x(-event.relative.y * 0.001)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(90))
			
			from = camera.project_ray_origin(event.position)
			to = from + camera.project_ray_normal(event.position) * ITEM_RAY_LENGTH

func _physics_process(delta):
	# Add the gravity.
	if !is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") && is_on_floor() && alive:
		velocity.y = JUMP_VELOCITY
	
	# Handle sprint.
	if Input.is_action_pressed("sprint") && alive:
		speed = SPRINT_SPEED
	else:
		speed = WALK_SPEED

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	if !alive:
		input_dir = Vector2.ZERO
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = lerp(velocity.x, direction.x * speed, delta * 7.0)
			velocity.z = lerp(velocity.z, direction.z * speed, delta * 7.0)
	else:
		velocity.x = lerp(velocity.x, direction.x * speed, delta * 3.0)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * 3.0)

	t_bob += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = _headbob(t_bob)
	
	move_and_slide()
	
	
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(from, to, 4294967295, [get_rid()])
	var result = space_state.intersect_ray(query)
	if result != {  }:
		var object = result.collider;	
		if "item" in object:
			if Input.is_action_just_pressed("interact"):
				match object.item:
					"key":
						inventory.keys.keys += 1
					"shovel":
						inventory.shovel = true
				object.pickedUp = true
	

func _headbob(time):
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.x = cos(time * BOB_FREQ / 2) * BOB_AMP
	return pos


func _on_monster_player_collide() -> void:
	alive = false
