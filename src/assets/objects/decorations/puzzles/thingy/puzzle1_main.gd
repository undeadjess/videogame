extends Node3D

var ring_1 = 0;
var ring_2 = 0;
var ring_3 = 0;

var RING_1_END = 3;
var RING_2_END = 1;
var RING_3_END = 4;

var complete = false;

@onready var keyPath = preload("res://assets/objects/items/keys/key.tscn")


func _physics_process(_delta):
	if !complete:
		if ring_1 > 4:
			ring_1 -= 5
			
		if ring_2 > 4:
			ring_2 -= 5
			
		if ring_3 > 4:
			ring_3 -= 5
			
		var ring_1_correct = ring_1 == RING_1_END;
		var ring_2_correct = ring_2 == RING_2_END;
		var ring_3_correct = ring_3 == RING_3_END;

		if ring_1_correct && ring_2_correct && ring_3_correct:
			complete = true;
			var key = keyPath.instantiate()
			add_child(key)
			key.global_position.y += 1
			
