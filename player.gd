extends CharacterBody3D



@export var SPEED = 16.0
@export var jump_strength  =20
#@export var fall_acceleration = 75
@onready var camera_mount_node_3d = $"Camera_Mount Node3D"
@onready var animation_player = $Node3D_pivot_visuals/gobot/AnimationPlayer
#for rotation
@export var sensing_horizontal_mvmet =0.4
@export var sensing_vetical_mvmet =0.4
var target_velocity = Vector3.ZERO
@onready var node_3d_pivot_visuals = $Node3D_pivot_visuals


const JUMP_VELOCITY = 9.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
#var gravity = 0
#when player is ready
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED	

#getting mouse motion
#
func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * sensing_horizontal_mvmet))
		#node_3d_pivot_visuals.rotate_y(deg_to_rad(event.relative.x * sensing_horizontal_mvmet))
		camera_mount_node_3d.rotate_x(deg_to_rad(-event.relative.y * sensing_vetical_mvmet))

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("move_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animation_player.play("Jump")
			
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		#walking animation
		if animation_player.current_animation != "Walk":
			animation_player.play("Walk")
		#to rotate the pivot in walking direction respectivly 
		#negate direction fix
		node_3d_pivot_visuals.look_at(position - direction, Vector3.UP)
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		#idle animation
		if animation_player.current_animation != "Idle":
			animation_player.play("Idle")
		
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
