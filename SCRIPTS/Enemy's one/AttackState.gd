extends Node


var AIController

func _ready() -> void:
	AIController = get_parent().get_parent()
	AIController.get_node("AnimationTree").travel("Idle")
	if AIController.Idling :
		await AIController.get_node("AnimationTree").animation_finished
	AIController.Attacking = true
	AIController.look_at(AIController.global_transform.origin + AIController.direction, Vector3(0, 1, 0))
func _physics_process(delta):
	if AIController:
		AIController.velocity.x = 0
		AIController.velocity.z = 0
