extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const DASH_VELOCITY = 30.0
const SPEED_VELOCITY = -10.0
@export var mouse_sensitivity = 0.1
var damage := 30
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var camera := $Neck/Camera3D
@onready var neck := $Neck
@onready var anim_player = $AnimationPlayer
@onready var hitbox = $WeaponSlot/MeshInstance3D2/hitbox
signal hit
var player_health = 100.0
var current_health
var attack := 10
@onready var hp_bar = get_node("HPBar")
var percentage_hp 

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if Input.is_action_just_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	current_health = player_health

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
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


func _on_hitbox_body_entered(body):
	if body.is_in_group("enemy"):
		body.health -= damage
		
func OnHit(damage):
	current_health -= damage
	HPBarUpdate()
	if current_health <= 0:
		OnDeath()
		
func OnDeath():
	get_node("CollisionShape3D").set_deffered("disabled", true)
	get_tree().change_scene_to_file("res://SCENES/game_over.tscn")
	hp_bar.hide()

func HPBarUpdate():
	percentage_hp = int((float(current_health) / player_health) / 100)
	hp_bar.Value = percentage_hp
	if percentage_hp >= 60:
		hp_bar.set_tint_progress("14e114")
	elif percentage_hp <= 60  and percentage_hp >= 25:
		hp_bar.set_tint_progress("e1be32")
	else:
		hp_bar.set_tint_progress("db0000")

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))
		$Neck.rotate_x(deg_to_rad(-event.relative.y * mouse_sensitivity))
		

func _on_player_interactor_area_entered(area):
	print("Fiole !")

func _on_player_interactor_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	print("Fiole !")
