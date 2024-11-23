extends Control

@onready var play_button = %PlayButton
@onready var saver_loader = $SaverLoader

func _input(event):
	var current = get_viewport().gui_get_focus_owner()
	if not current:
		return
	if event is InputEventJoypadButton:
		if event.button_index == JOY_BUTTON_A and event.pressed:
			if current is Button or current is TextureButton:
				current.emit_signal("pressed")

func _ready():
	play_button.grab_focus()

func _on_screen_blacked_out():
	Globals.next_scene = "res://scenes/levels/midgard.tscn"
	get_tree().paused = false
	get_tree().change_scene_to_packed(Globals.loading_screen)

func _on_play_button_pressed():
	TransitionScreen.transition_finished.connect(_on_screen_blacked_out)
	TransitionScreen.transition_to_black()
	
