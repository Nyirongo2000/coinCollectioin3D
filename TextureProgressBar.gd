extends TextureProgressBar

@onready var player = $".."

func _ready():
	value = player.health * 100 / player.maxHealth
#	print("health "+str(value))
	

func _process(delta):
	pass
func onupdateValue():
	_ready()

#https://www.youtube.com/watch?v=uvuxAT1XoRs&t=161s
#progress bar
