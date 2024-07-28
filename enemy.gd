extends CharacterBody3D

var enemy_heath = 30
@onready var nav_agent = $NavigationAgent3D

var SPEED = 5.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var current_location = global_transform.origin
	var next_location = nav_agent.get_next_location()
	var new_velocity = (next_location - current_location).normaized() * SPEED
	
	velocity = new_velocity
	move_and_slide()
	
func update_target_location(target_location):
	nav_agent.set_targer_location(target_location)
