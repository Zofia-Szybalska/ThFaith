extends State


@onready var animation_player = $"../../AnimationPlayer"
var attacking = false

func enter(_msg := {}) -> void:
	animation_player.play("PawAttack")
	attacking = true


func _on_area_2d_body_entered(body):
	if body is Player:
		body.hit(1, get_parent())


func _on_animation_player_animation_finished(_anim_name):
	if attacking:
		attacking = false
		state_machine.transition_to("Attack")
