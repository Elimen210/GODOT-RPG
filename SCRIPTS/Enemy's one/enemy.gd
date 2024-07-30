extends CharacterBody3D


@onready var nav_agent = $NavigationAgent3D
@onready var player = $"."
var SPEED = 5.0
@onready var state_controller = get_node("StateMachine")
var direction: Vector3
var Attacking: bool = false
var heath: int = 30
var damage: int = 20
var dying: bool = false
var just_hit: bool = false
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var state = {
	"idle": preload("res://SCRIPTS/Enemy's one/IdleState.gd"),
	"Attack": preload("res://SCRIPTS/Enemy's one/AttackState.gd"),
	"Death": preload("res://SCRIPTS/Enemy's one/DeathState.gd")
}
func change_state(new_state: String):
	print("Inside")
	if get_child_count() != 0:
		if !("Death" in get_child(0).name):
			get_child(0).queue_free()
	if state.has(new_state):
		var state_temp = state[new_state].new()
		state_temp.name = new_state
		add_child(state_temp)

func _ready():
	
	pass # Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if player:
		direction = (player.global_transform.origin - self.global_transform.origin).normalized()
	var current_location = global_transform.origin
	
	move_and_slide()
	
func update_target_location(target_location):
	nav_agent.set_targer_location(target_location)


func _on_chase_player_detection_body_entered(body):
	if body.is_in_group("player") and !dying:
	 	state_controller.change_state("Run")


func _on_chase_player_detection_body_exited(body):
	if body.is_in_group("player") and !dying:
		state_controller.change_stat("Idle")


func _on_attack_player_detection_body_entered(body):
	if body.is_in_group("player") and !dying:
		state_controller.change_stat("Attack")


func _on_attack_player_detection_body_exited(body):
	if body.is_in_group("player") and !dying:
		state_controller.change_stat("Run")


func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if "Attack" in anim_name:
		if (player in get_node("attack_player_detection")).get_overlapping_boddies() and !dying:
			state_controller.change_state("Attack")
	elif "Death" in anim_name:
		death()
		
func death():
	self.queue_free()
