extends Node2D

@onready var attack = $StateMachine/Attack

func kill():
	queue_free()

func start_battle():
	attack.timer.start()
	attack.battle_started = true

func _on_body_entered(body):
	if body is Player:
		body.hit(1, self)
