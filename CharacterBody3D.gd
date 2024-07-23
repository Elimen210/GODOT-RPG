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

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if Input.is_action_just_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	$Area3D.body_entered.connect(start_dialog)
	
func _unhandled_input(event):
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			neck.rotate_y(-event.relative.x * 0.05)
			camera.rotate_x(-event.relative.x * 0.05)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-60), deg_to_rad(60))
			
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_up", "ui_down", "ui_right", "ui_left")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		#dash
		if Input.is_action_just_pressed("insert"):
			velocity.x *= DASH_VELOCITY
		#sprint
		if Input.is_action_just_pressed("sprint"):
			velocity.x = SPEED_VELOCITY
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
func start_dialog(_body):
	var scene := preload("res://INTERAGIR.tscn")
	var dialog = scene.instantiate()
	add_child(dialog)
	

	move_and_slide()
