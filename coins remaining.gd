extends Label

var remaining_coins = 6


func _ready():
	text = "Remaining Coins: " + str(remaining_coins)


func _on_score_score_changed():
	print("decremented")
	remaining_coins -= 1
	_ready()
