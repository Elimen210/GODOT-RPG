extends MeshInstance3D

func _physics_process(delta):
	if Input.is_action_just_pressed("interact") && $Neck/PlayerInteractor.is_detected():
		self.queue_free()
