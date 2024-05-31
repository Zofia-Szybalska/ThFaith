extends Node2D

var player_near: bool = false
var player_sitting: bool = false
@export var saver_loader_node: Node
@onready var save_button = $SaveButton
@onready var back_button = $BackButton


func _unhandled_input(event):
	if event.is_action_pressed("interaction") and player_sitting :
		_on_back_button_pressed()
	elif event.is_action_pressed("interaction") and player_near and not player_sitting:
		$Label.hide()
		player_sitting = true
		save_button.show()
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
	print("Próba zapisania")
	saver_loader_node.save_game()

func _on_back_button_pressed():
	$Label.show()
	save_button.hide()
	back_button.hide()
	get_tree().paused = false
	player_sitting = false

