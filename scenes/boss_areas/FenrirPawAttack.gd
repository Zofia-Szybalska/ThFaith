extends State


@onready var animation_player = $"../../AnimationPlayer"
var attacking = false
var times_attacked = 0

func enter(_msg := {}) -> void:
	animation_player.play("PawAttack_start")
	attacking = true

func attack():
	if times_attacked < owner.phase:
		animation_player.play("PawAttack_middle")
	else:
		animation_player.play("PawAttack_end")

func _on_area_2d_body_entered(body):
	if body is Player:
		body.hit(1, get_parent().get_parent())


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "PawAttack_middle":
		times_attacked += 1
		attack()
	if attacking and anim_name == "PawAttack_end":
		attacking = false
		state_machine.transition_to("Attack")
