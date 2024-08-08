extends StaticBody3D

const obj = "door"
var locked = false
var open = false
var interact = false

@onready var part1 = $Part1
@onready var part2 = $Part2
@onready var baseRot = part1.rotation.y

func _physics_process(_delta):
	var player = get_parent_node_3d().player
	var monster = get_parent_node_3d().monster
	var playerPos = player.position
	var monsterPos = monster.position
	
	$Lock.visible = locked
	
	if interact:
		interact = false
		if !locked:
			if open:
				if !monsterPos.distance_to(global_position) < 1.4:
					open = false
			else:
				open = true
		else:
			if player.inventory.keys.keys > 0:
				locked = false
				
	
	if playerPos.distance_to(global_position) < 1.125 && !open && !locked:
		open = true
	
	if monsterPos.distance_to(global_position) < 1.4 && !open && !locked:
		monster.time = 3
		open = true
	
	part1.rotation.y = baseRot + (deg_to_rad(90) if open else 0)
	part2.rotation.y = baseRot - (deg_to_rad(90) if open else 0)
