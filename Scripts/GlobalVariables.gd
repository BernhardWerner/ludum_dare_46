extends Node

var worlds_unlocked := [true, false, false, false]
var server_numbers  := [4, 0, 0, 0]
var servers_needed_to_unlock := [5, 8, 12, 16]

######################### CUSTOM METHODS #########################

func update_world_locks() -> void:
	var sum := 0
	for i in range(4):
		sum += server_numbers[i]
	for i in range(4):
		if sum >= servers_needed_to_unlock[i]:
			worlds_unlocked[i] = true
			server_numbers[i]  = 1


######################### BUILT-INS #########################

func _ready() -> void:
	pass

######################### SIGNALS #########################
