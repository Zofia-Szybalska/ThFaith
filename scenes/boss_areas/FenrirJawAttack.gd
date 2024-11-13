extends State

@onready var animation_player = $"../../AnimationPlayer"
var attacking = false
var times_attacked = 0

func enter(_msg := {}) -> void:
	times_attacked = 0
	animation_player.play("JawAttack_start")
	attacking = true

func attack():
	if times_attacked < owner.phase:
		animation_player.play("JawAttack_middle")
	else:
		animation_player.play("JawAttack_end")

func _on_area_2d_body_entered(body):
	if body is Player:
		body.hit(1, get_parent().get_parent())

func end_attack():
	attacking = false
	state_machine.transition_to("Attack")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "JawAttack_middle":
		times_attacked += 1
		attack()
	if attacking and anim_name == "JawAttack_end":
		attacking = false
		state_machine.transition_to("Attack")

func exit(_msg := {}) -> void:
	times_attacked = 0
