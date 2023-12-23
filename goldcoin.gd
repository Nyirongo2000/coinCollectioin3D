extends Area3D

const ROTATION_SPEED = 4
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate_y(deg_to_rad(ROTATION_SPEED))
	
func _on_body_entered(body):
	print("Body entered!")
	queue_free()