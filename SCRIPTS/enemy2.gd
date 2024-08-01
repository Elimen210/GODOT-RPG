extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var health: int = 30
var damage: int = 10
@onready var hitbox = $WeaponSlot/MeshInstance3D2/hitbox
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var anim_player = $AnimationPlayer
@onready var anim_tree = $AnimationTree

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
		
		
func _on_chase_player_detection_body_entered(body):
	if body.is_in_group("player"):
		print("Ennemy entered")

func _on_chase_player_detection_body_exited(body):
	if body.is_in_group("player"):
		print("Ennemy exited")


func _on_attack_player_detection_body_entered(body):
	if body.is_in_group("player"):
		print("Ennemy able to be fight")


func _on_attack_player_detection_body_exited(body):
	if body.is_in_group("player"):
		print("Ennemy exited purchase HIM daamn")

func death():
	self.queue_free()


		
