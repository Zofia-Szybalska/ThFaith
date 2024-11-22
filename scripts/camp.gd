extends Node2D

var player_near: bool = false
var player_sitting: bool = false
@export var saver_loader_node: Node
@onready var save_button = $SaveButton
@onready var back_button = $BackButton
@export var camp_name = "camp"


func _unhandled_input(event):
	if event.is_action_pressed("interaction") and player_sitting :
		_on_back_button_pressed()
	elif event.is_action_pressed("interaction") and player_near and not player_sitting:
		$Label.hide()
		player_sitting = true
		save_button.show()
		save_button.grab_focus()
		back_button.show()
		get_tree().paused = true

func _on_area_2d_body_entered(body):
	if body is Player:
		$Label.show()
		player_near = true

func _on_area_2d_body_exited(body):
	if body is Player:
		$Label.hide()
		player_near = false

func _on_save_button_pressed():
	Analytics.add_event("Game save", {"camp name": camp_name})
	saver_loader_node.save_game()

func _input(event):
	var current = get_viewport().gui_get_focus_owner()
	if not current:
		return
	if event is InputEventJoypadButton:
		if event.button_index == JOY_BUTTON_A and event.pressed:
			if current is Button:
				current.emit_signal("pressed")

func _on_back_button_pressed():
	$Label.show()
	save_button.hide()
	back_button.hide()
	get_tree().paused = false
	player_sitting = false

