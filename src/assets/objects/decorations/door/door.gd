@tool
extends StaticBody3D

const obj = "door"
var open = false
var interact = false

@export var locked: bool

@onready var part1 = $Part1
@onready var part2 = $Part2
@onready var baseRot = part1.rotation.y

func _physics_process(_delta):
	$Lock.visible = locked
	if !Engine.is_editor_hint():
		var player = get_parent_node_3d().player
		var monster = get_parent_node_3d().monster
		var playerPos = player.position
		var monsterPos = monster.position
		
		
		if interact:
			interact = false
			if !locked:
				if open:
					if !monsterPos.distance_to(global_position) < 1.4:
						open = false
						$AnimationPlayer.play("close")
				else:
					$AnimationPlayer.play("open")
					open = true
			else:
				if player.inventory.keys.keys > 0:
					locked = false
		
		if monsterPos.distance_to(global_position) < 1.4 && !open && !locked:
			monster.time = 3
			open = true
			$AnimationPlayer.play("open")
