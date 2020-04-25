extends Node

var current_scene = null

######################### CUSTOM METHODS #########################

func deferred_goto_scene(path) -> void:
	var new_scene = ResourceLoader.load(path)
	
	if (weakref(current_scene).get_ref()):
		current_scene.free()
	current_scene = new_scene.instance()
	
	
	if GlobalVariables.menu_bgm.playing:
		if not current_scene.is_in_group("menu"):
			GlobalVariables.menu_bgm.stop()
	else:
		if current_scene.is_in_group("menu"):
			GlobalVariables.menu_bgm.play()
		

	get_tree().get_root().add_child(current_scene)
	get_tree().set_current_scene(current_scene)
	
	

	
func goto_scene(path) -> void:
	call_deferred("deferred_goto_scene", path)
	
	
######################### BUILT-INS #########################	
	
func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)
	

