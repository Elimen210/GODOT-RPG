extends Node

var state = {
	"idle": preload("res://SCRIPTS/Enemy's one/IdleState.gd"),
	"Attack": preload("res://SCRIPTS/Enemy's one/AttackState.gd"),
	"Run": preload("res://SCRIPTS/Enemy's one/RunState.gd"),
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
