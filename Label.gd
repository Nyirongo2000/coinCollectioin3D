extends Label
var score  = 0
@onready var popup = $"../Window"
signal score_changed
# Called when the node enters the scene tree for the first time.
func _ready():
	text ="Score: " + str(score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_goldcoin_7_glab_coin():
	score =score + 1
	_ready()
	emit_signal("score_changed", score)  # Emit signal with new score
#Set remaining coins when score reaches minimum
#    if score == min_score:
#		"$"../coins remaining".remaining_coins = min_score
	
	if score == 1:
		popup.show()
#		get_tree().change_scene_to_file("res://win.tscn")
	
	


func _on_window_close_requested():
	popup.hide()
