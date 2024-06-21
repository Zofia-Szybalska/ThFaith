extends ColorRect

func _on_start_game_button_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/midgard.tscn")


func _on_load_game_button_pressed():
	$MarginContainer/SaveMenu.show()
	$MarginContainer/VBoxContainer.hide()
