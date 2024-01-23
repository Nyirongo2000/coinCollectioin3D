extends CharacterBody3D
@export var SPEED = 16.0
@export var jump_strength = 20
@onready var camera_mount_node_3d = $"Camera_Mount Node3D"
@onready var animation_player = $Node3D_pivot_visuals/gobot/AnimationPlayer
@export var sensing_horizontal_mvmet = 0.4
@export var sensing_vetical_mvmet = 0.4
var target_velocity = Vector3.ZERO
@onready var node_3d_pivot_visuals = $Node3D_pivot_visuals
@onready var texture_progress_bar = $TextureProgressBar
@onready var jumpsound : AudioStreamPlayer = $jump

@onready var footstep : AudioStreamPlayer = $footstep
var step_count = 0
const JUMP_VELOCITY = 9.5
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@export var health = 100
@export var maxHealth = 100
func _ready():
	animation_player.play("Idle")

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * sensing_horizontal_mvmet))
		var xRotate = clamp(rotation.x - event.relative.y/1000 * sensing_horizontal_mvmet, -0.25, 0.25)
		var yRotate = rotation.x - event.relative.y/1000 * sensing_vetical_mvmet
		camera_mount_node_3d.rotation = Vector3(xRotate,yRotate, 0)
		
func _on_attaking_health_area_entered(area):
	if "attackingArea" in area.name : 
		health = health-10
		texture_progress_bar.onupdateValue()
		if health == 0:
			get_tree().change_scene_to_file("res://game_over.tscn")
				
func _physics_process(delta):
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("move_jump") and is_on_floor():
		jumpsound.play()
		velocity.y = JUMP_VELOCITY
		
	
	if is_on_floor() and direction:
		animation_player.play("Walk")
#		footstep sound
		step_count += 1
		if step_count % 20 == 0:
			footstep.pitch_scale =  randfn(1.2, 0.1)
			footstep.play()
	else:
		animation_player.play("Idle")
#
	if not is_on_floor() and velocity.y >0:
		animation_player.play("Jump")
		
	if direction:
		node_3d_pivot_visuals.look_at(position - direction, Vector3.UP)
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		

	move_and_slide()


#refefence 
#camera and third person concept
#https://www.youtube.com/watch?v=EP5AYllgHy8&t=551s
