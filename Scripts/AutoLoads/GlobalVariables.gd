extends Node

const servers_needed_to_unlock := [0, 6, 10, 16]
const server_start_number := [3, 3, 2, 2]

var worlds_unlocked := [true, false, false, false]
var server_numbers  := [3, 0, 0, 0]

var menu_bgm := AudioStreamPlayer.new()

######################### CUSTOM METHODS #########################

func load_game() -> void:
	var save_file = File.new()
	if not save_file.file_exists("user://savefile.bs"):
		return 
		
	save_file.open("user://savefile.bs", File.READ)
	while save_file.get_position() < save_file.get_len():
		var node_data = parse_json(save_file.get_line())
		
		for i in node_data.keys():
			set(i, node_data[i])
	save_file.close()

func save_game() -> void:
	var save_file = File.new()
	save_file.open("user://savefile.bs", File.WRITE)
	save_file.store_line(to_json({
		"worlds_unlocked": worlds_unlocked,
		"server_numbers": server_numbers
	}))
	save_file.close()



func update_world_locks() -> void:
	var sum := 0
	for i in range(4):
		sum += server_numbers[i]
	for j in range(4):
		if sum >= servers_needed_to_unlock[j] and not worlds_unlocked[j]:
			worlds_unlocked[j] = true
			server_numbers[j]  = server_start_number[j]

######################### BUILT-INS #########################

func _ready() -> void:
	add_to_group("persist")
	print(self.filename)
	
	menu_bgm.stream = preload("res://Sounds/ChillLofi.ogg")
	menu_bgm.volume_db = -10
	add_child(menu_bgm)


######################### SIGNALS #########################

func _on_level_complete(world_number : int) -> void:
	server_numbers[world_number - 1] = min(server_numbers[world_number - 1] + 1, 10)
	update_world_locks()
	save_game()
