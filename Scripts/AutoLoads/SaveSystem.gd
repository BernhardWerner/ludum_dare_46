extends Node

######################### CUSTOM METHODS #########################


func load_game():
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		return 

	var save_nodes = get_tree().get_nodes_in_group("persist")
	for i in save_nodes:
		i.queue_free()

	save_game.open("user://savegame.save", File.READ)
	while save_game.get_position() < save_game.get_len():
		var node_data = parse_json(save_game.get_line())

		var node = get_node(node_data["node_path"])
		
 
		for i in node_data.keys():
			if i == "filename":
				continue
			node.set(i, node_data[i])
	
		print(node.save_data())
	save_game.close()
	
	
	
func save_game() -> void:
	var save_game = File.new()
	save_game.open("user://savegame.save", File.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("persist")
	for node in save_nodes:
		if not node.has_method("save_data"):
			print("persistent node '%s' is missing a save_data() function, skipped" % node.name)
			continue

		save_game.store_line(to_json(node.call("save_data")))
	save_game.close()

######################### BUILT-INS #########################

func _ready() -> void:
	pass
