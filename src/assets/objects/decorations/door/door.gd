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
	
	part1.rotation.y = baseRot + (90 if open else 0)
	part2.rotation.y = baseRot - (90 if open else 0)
