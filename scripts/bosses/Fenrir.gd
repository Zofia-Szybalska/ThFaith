extends Node2D

@onready var attack = $StateMachine/Attack
@onready var demo_end = $"../UI/DemoEnd"
@onready var ui = $"../UI"
@onready var animation_player = $AnimationPlayer
@onready var player = $"../Player"
@onready var damageable = $Damageable
var phase = 1

func _process(delta):
	
	if phase == 1 and damageable.health <= damageable.max_health * 2/3:
		owner.phase = 2
		phase = 2
	if phase == 2 and damageable.health <= damageable.max_health * 1/3:
		owner.phase = 3
		phase = 3


func kill():
	demo_end.visible = true
	ui.has_demo_ended = true
	player.can_be_controled = false
	Analytics.add_event("Boss battle end", { "boss name": "Fenrir", "player deaths": PlayerVariables.deaths_at_Fenrir})
	animation_player.play("death")

func start_battle():
	attack.timer.start()
	attack.battle_started = true

func _on_body_entered(body):
	if body is Player:
		body.hit(1, self)
