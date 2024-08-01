extends Area3D

@onready var hp_bar = get_node("HPBar")

func _physics_process(delta):
	if Input.is_action_just_pressed("interact"):
		self.queue_free()
