extends Node

@onready var player = $Character

func _physics_process(delta):
	get_tree().call_group("ennemies", "update_target_location", player.global_transform.origin)
