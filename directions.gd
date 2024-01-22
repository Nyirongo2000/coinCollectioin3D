extends Node2D


func _ready():
	pass 



func _process(delta):
	pass

#up
func _on_up_touch_screen_button_pressed():
	Input.action_press("move_up")
func _on_up_touch_screen_button_released():
	Input.action_release("move_up")
	


#down 
func _on_down_touch_screen_button_2_pressed():
	Input.action_press("move_down")
func _on_down_touch_screen_button_2_released():
	Input.action_release("move_down")


#left
func _on_left_touch_screen_button_3_pressed():
	Input.action_press("move_left")
func _on_left_touch_screen_button_3_released():
	Input.action_release("move_left")


#right
func _on_right_touch_screen_button_4_pressed():
	Input.action_press("move_right")
func _on_right_touch_screen_button_4_released():
	Input.action_release("move_right")


#jump
func _on_jump_touch_screen_button_5_pressed():
	Input.action_press("move_jump")
func _on_jump_touch_screen_button_5_released():
	Input.action_release("move_jump")




#camera



func _on_camera_left_touch_screen_button_pressed():
	Input.action_press("move_jump")


func _on_camera_left_touch_screen_button_released():
	pass # Replace with function body.
