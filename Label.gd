extends Label
var score  = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	text = str(score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_goldcoin_7_glab_coin():
	score =score + 1
	_ready()
	
	#if score == 6:
		
