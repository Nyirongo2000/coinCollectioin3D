extends Label

var remaining_coins = 0
const min_score = 6

func _ready():
#	connect("score_changed", self, "_on_score_changed")  # Use `self` to refer to the current object
	remaining_coins = min_score
	text = "Remaining Coins: " + str(remaining_coins)

func _on_score_changed(new_score):
	if new_score >= min_score:
		remaining_coins = max(new_score - min_score, 0)
		text = "Remaining Coins: " + str(remaining_coins)
