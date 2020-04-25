extends Node

var worlds_unlocked := [true, true, false, false]
var server_numbers  := [7, 2, 0, 0]
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


func save_data() -> Dictionary:
	return {        
			"node_path" : self.get_path(),
			
			"worlds_unlocked" : worlds_unlocked,
			"server_numbers" : server_numbers
	}


######################### BUILT-INS #########################

func _ready() -> void:
	add_to_group("persist")
	print(self.filename)

######################### SIGNALS #########################
