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

		var new_object = load(node_data["filename"]).instance()
		get_node(node_data["parent"]).add_child(new_object)
		if new_object.get("pos_x") and new_object.get("pos_x"):
			new_object.position = Vector2(node_data["pos_x"], node_data["pos_y"])
 
		for i in node_data.keys():
			if i == "filename" or i == "parent" or i == "pos_x" or i == "pos_y":
				continue
			new_object.set(i, node_data[i])
	save_game.close()
	
	
	
func save_game() -> void:
	var save_game = File.new()
	save_game.open("user://savegame.save", File.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("persist")
	for node in save_nodes:
		if node.filename.empty():
			print("persistent node '%s' is not an instanced scene, skipped" % node.name)
			continue
		if not node.has_method("save_data"):
			print("persistent node '%s' is missing a save_data() function, skipped" % node.name)
			continue
			
		save_game.store_line(to_json(node.call("save_data")))
	save_game.close()

######################### BUILT-INS #########################

func _ready() -> void:
	pass
