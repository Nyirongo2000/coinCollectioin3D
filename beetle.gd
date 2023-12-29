extends CharacterBody3D

var is_attacking = false   # Renamed attackPlayer for readability
var is_chasing = false     # Renamed chasePlayer for consistency

const movement_speed =9 # Renamed SPEED for clarity
@onready var character_mesh = get_node("beetle_bot_fused")  # Renamed mesh for specificity
@onready var animation_controller = $beetle_bot_fused/AnimationPlayer # Renamed for consistency
@onready var agent = $NavigationAgent3D
# Get gravity from project settings
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var target_direction = Vector2.ZERO  # Renamed direction for clarity
var randomNG = RandomNumberGenerator.new()

func _ready():
	randomNG.randomize()
	target_direction = Vector3(randf_range(-40,40), 0, randf_range(-45, 45))
	updateTargetLocation(target_direction)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	# Handle movement based on state
	if is_chasing:
		_handle_chasing_movement(delta)
	elif is_attacking:
		_handle_attacking_behavior(delta)
	else:
		_handle_idle_state(delta)

	move_and_slide()

func _handle_chasing_movement(delta):
	# Get player then get its direction
	var player = get_node("../../character/Player")
	if player:
		target_direction = (player.position - position).normalized()

	# Rotate towards player and move
	if target_direction:
		character_mesh.rotation.y = lerp_angle(
			character_mesh.rotation.y, atan2(target_direction.x, target_direction.z), delta * 10
		)

		animation_controller.play("walk")
		velocity.x = target_direction.x * movement_speed
		velocity.z = target_direction.z * movement_speed

func _handle_attacking_behavior(delta):
	# Rotate towards player and play attack animation
	if target_direction:
		character_mesh.rotation.y = lerp_angle(
			character_mesh.rotation.y, atan2(target_direction.x, target_direction.z), delta * 10
		)
		animation_controller.play("headbutt")
		velocity.x = 0  # Stop movement during attack
		velocity.z = 0

func _handle_idle_state(delta):
	# Use NavigationAgent3D for wander behavior
	if position.distance_to(agent.target_position) >1.5:
		var next_location = agent.get_next_path_position()
		var direction = (next_location - global_position).normalized()
		character_mesh.rotation.y = lerp_angle(character_mesh.rotation.y, atan2(direction.x, direction.z), delta * 10)
		

		
		velocity.x = direction.x * movement_speed
		velocity.z = direction.z * movement_speed
		animation_controller.play("walk")

	else:
		randomNG.randomize()
		target_direction = Vector3(randf_range(-45, 45), 0, randf_range(-45, 45))
		updateTargetLocation(target_direction)


func updateTargetLocation(targLoc):
	agent.set_target_position(targLoc)


func _on_chasing_area_body_entered(body):
	if "Player" in body.name:
#\player chase entered
		is_chasing = true


func _on_attacking_area_body_entered(body):
	if "Player" in body.name:
		is_attacking = true
		is_chasing = false


func _on_chasing_area_body_exited(body):
	if "Player" in body.name:
		is_chasing = false


func _on_attacking_area_body_exited(body):
	if "Player" in body.name:
		is_attacking = false
		is_chasing = true
		
