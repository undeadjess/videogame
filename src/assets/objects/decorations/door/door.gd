extends StaticBody3D

const obj = "door"
var locked = false
var open = false
var interact = false

@onready var part1 = $Part1
@onready var part2 = $Part2
@onready var baseRot = part1.rotation.y

func _physics_process(_delta):
	if interact && !locked:
		interact = false
		open = !open
	
	var playerPos = get_parent_node_3d().player.position
	if playerPos.distance_to(global_position) < 1.125 && !open:
		open = true
	
	var monsterPos = get_parent_node_3d().monster.position
	if monsterPos.distance_to(global_position) < 1.4 && !open:
		open = true
	
	part1.rotation.y = baseRot + (1.5 if open else 0)
	part2.rotation.y = baseRot - (1.5 if open else 0)
