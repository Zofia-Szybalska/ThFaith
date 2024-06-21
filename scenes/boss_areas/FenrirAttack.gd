extends State

@onready var animation_player = $"../../AnimationPlayer"
@onready var timer = $Timer
var battle_started = false


func enter(_msg := {}) -> void:
	animation_player.play("RESET")
	if battle_started:
		timer.start()

func draw_attack():
	var random = RandomNumberGenerator.new()
	random.randomize()
	var rand_number = (random.randi_range(1, 3))
	if rand_number == 1:
		state_machine.transition_to("PawAttack")
	elif rand_number == 2:
		state_machine.transition_to("JawAttack")
	elif rand_number == 3:
		state_machine.transition_to("BlowAttack")

func _on_timer_timeout():
	draw_attack()
