extends Area3D
signal  glabCoin
const ROTATION_SPEED = 6
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate_y(deg_to_rad(ROTATION_SPEED))
	
func _on_body_entered(body):
	if body.name == "Player":
		emit_signal("glabCoin")
			
	print("completed")
	queue_free()
	get_tree().change_scene_to_file("res://win.tscn")
	#ADD A COUNTER on how many coins have been collected
