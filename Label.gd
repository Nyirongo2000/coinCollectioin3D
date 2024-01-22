extends Label
var score  = 0
@onready var popup = $"../Window"
signal score_changed

func _ready():
	text ="Score: " + str(score)

func _process(delta):
	pass

func _on_goldcoin_7_glab_coin():
	score =score + 1
	emit_signal("score_changed")  
	_ready()
	
	if score == 6:
		popup.show()
#		get_tree().change_scene_to_file("res://win.tscn")
	
func _on_window_close_requested():
	popup.hide()

