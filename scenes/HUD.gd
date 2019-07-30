extends CanvasLayer

signal start_game

func start_new_game():
	$MessageLabel.text = "Dodge the Creeps!"
	$MessageLabel.show()
	
	# update_score(0)
	
	yield(get_tree().create_timer(1), "timeout")
	$StartButton.show()
	

func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()

func show_game_over():
	show_message("Game Over")
	yield($MessageTimer, "timeout")
	
	start_new_game()

func update_score(score):
	$ScoreLabel.text = String(score)

func _on_MessageTimer_timeout():
	$MessageLabel.hide()

func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")
