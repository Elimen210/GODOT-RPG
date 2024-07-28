extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const DASH_VELOCITY = 30.0
const SPEED_VELOCITY = -10.0
@export var mouse_sensitivity = 0.5
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var camera := $Neck/Camera3D
@onready var neck := $Neck
@onready var anim_player = $AnimationPlayer
@onready var hitbox = $WeaponSlot/MeshInstance3D2/hitbox
signal hit
var player_health = 100.0
var attack := 10

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if Input.is_action_just_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		#dash
		if Input.is_action_just_pressed("insert"):
			velocity.x *= DASH_VELOCITY
		if Input.is_action_just_pressed("insert") && Input.is_action_just_pressed("ui_up"):
			velocity.z *= DASH_VELOCITY
		
		#sprint
		if Input.is_action_just_pressed("sprint"):
			velocity.x = SPEED_VELOCITY
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	
func _process(delta):
	if Input.is_action_just_pressed("attack"):
		anim_player.play("attack")
		hitbox.monitoring = true
		
	
	move_and_slide()


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "attack":
		anim_player.play("idle")
		hitbox.monitoring = false


func _on_hitbox_area_entered(area):
	if area.is_in_group("enemy"):
		print("Ennemy hit F*ck !!!!")
		

