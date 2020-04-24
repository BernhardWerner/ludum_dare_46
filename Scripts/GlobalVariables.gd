extends Node

var worlds_unlocked := [true, false, false, false]
var server_numbers  := [4, 0, 0, 0]
var servers_needed_to_unlock := [0, 5, 10, 16]

######################### CUSTOM METHODS #########################

func update_world_locks() -> void:
	var sum := 0
	for i in range(4):
		sum += server_numbers[i]
	for j in range(4):
		if sum >= servers_needed_to_unlock[j] and not worlds_unlocked[j]:
			worlds_unlocked[j] = true
			server_numbers[j]  = 1


######################### BUILT-INS #########################

func _ready() -> void:
	pass

######################### SIGNALS #########################
