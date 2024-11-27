extends Control


func _input(event):
	var current = get_viewport().gui_get_focus_owner()
	if not current:
		return
	if event is InputEventJoypadButton:
		if event.button_index == JOY_BUTTON_A and event.pressed:
			if current is Button or current is TextureButton:
				current.emit_signal("pressed")

func on_show():
	$MarginContainer/PanelContainer/VBoxContainer/MarginContainer/HBoxContainer/RestartButton.grab_focus()


func _on_button_pressed():
	hide()
	PlayerVariables.health = PlayerVariables.max_health
	PlayerVariables.player_spawn_pos = PlayerVariables.last_camp_pos
	Globals.next_scene = PlayerVariables.current_scene_path
	get_tree().paused = false
	var error = get_tree().change_scene_to_packed(Globals.loading_screen)
	print(error)


func _on_quit_button_pressed():
	await Analytics.handle_exit()
	get_tree().quit()
