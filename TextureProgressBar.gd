extends TextureProgressBar

@onready var player = $".."

# Called when the node enters the scene tree for the first time.
func _ready():
	value = player.health * 100 / player.maxHealth
#	print("health "+str(value))
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func onupdateValue():
	_ready()
