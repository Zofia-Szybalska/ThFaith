extends Node2D

@onready var attack = $StateMachine/Attack
@onready var demo_end = $"../UI/DemoEnd"
@onready var ui = $"../UI"

func kill():
	demo_end.visible = true
	get_tree().paused = true
	ui.has_demo_ended = true
	queue_free()

func start_battle():
	attack.timer.start()
	attack.battle_started = true

func _on_body_entered(body):
	if body is Player:
		body.hit(1, self)
