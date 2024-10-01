extends Node3D

var ring1 = 0;
var ring2 = 0;
var ring3 = 0;

var ring1End = 3;
var ring2End = 1;
var ring3End = 4;

var complete = false;

@onready var keyPath = preload("res://assets/objects/items/keys/key.tscn")

func _physics_process(_delta):
	if(!complete):
		if(ring1 > 4):
			ring1 -= 5
		if(ring2 > 4):
			ring2 -= 5
		if(ring3 > 4):
			ring3 -= 5
		var ring1Correct = ring1 == ring1End;
		var ring2Correct = ring2 == ring2End;
		var ring3Correct = ring3 == ring3End;

		if(ring1Correct && ring2Correct && ring3Correct):
			complete = true;
			var key = keyPath.instantiate()
			add_child(key)
			key.global_position.y += 1
			
