extends Area3D
signal  glabCoin
const ROTATION_SPEED = 6
#@onready var coin_collected: AudioStreamPlayer3D  = $coinCollected
#@onready var coin_colect_sound : AudioStreamPlayer  = $coinColectSound

func _ready():
	pass



func _process(delta):
	rotate_y(deg_to_rad(ROTATION_SPEED))
	
func _on_body_entered(body):
	if body.name == "Player":
		print("Body entered!")
		emit_signal("glabCoin")
#		coin_collected.play()
#		coin_colect_sound.play()
#		print("coin sound")
	queue_free()
	#ADD A COUNTER on how many coins have been collected

#reference 
#Godot 4 3D Platformer Lesson #6- Collectable Coin concept 
#https://www.youtube.com/watch?v=8XygvGbNTA8&t=40s
