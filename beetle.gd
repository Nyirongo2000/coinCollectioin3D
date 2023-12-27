extends CharacterBody3D


const SPEED = 9.0
var attackPlayer = false
var chasePlayer = false
@onready var mesh = get_node("beetle_bot_fused")
@onready var animation_player = $beetle_bot_fused/AnimationPlayer


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var direction
var health

func _physics_process(delta):
	direction = Vector2.ZERO
#	incase, the beetle is trying to fall off from something
#	if not is_on_floor():
#		velocity = gravity * delta
	
	var player = get_node("../../character/Player")
	if player:
		direction = (player.position - position).normalized()
	if chasePlayer:
		if direction:
			mesh.rotation.y = lerp_angle(mesh.rotation.y, atan2(direction.x, direction.z), delta*10)
		animation_player.play("walk")
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
			
	elif attackPlayer:
		if direction:
			mesh.rotation.y = lerp_angle(mesh.rotation.y, atan2(direction.x, direction.z), delta*10)
			animation_player.play("headbutt")
			velocity.x = 0
			velocity.z = 0
	else:
		animation_player.play("idle")
		velocity.x = 0
		velocity.z = 0
	move_and_slide()

func _on_attacking_area_body_entered(body):
	if "Player" in body.name:
		attackPlayer = true
		#no need to chase the player when the player is being attacked
		chasePlayer = false


func _on_chasing_area_body_entered(body):
	if "Player" in body.name:
		chasePlayer = true


func _on_attacking_area_body_exited(body):
	if "Player" in body.name:
		attackPlayer =false
		chasePlayer = true


func _on_chasing_area_body_exited(body):
	if "Player" in body.name:
		chasePlayer = false
