extends Label
signal enoughCoins
var remaining_coins = 6


func _ready():
	text = "Remaining Coins: " + str(remaining_coins)


func _on_score_score_changed():
	print("decremented")
	if remaining_coins > 0:
		remaining_coins -= 1
		_ready()
	elif remaining_coins == 0:
		remaining_coins = 0
		emit_signal("enoughCoins")
	
