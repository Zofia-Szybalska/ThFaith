extends State

@onready var animation_player = $"../../AnimationPlayer"

func enter(_msg := {}) -> void:
	owner.can_attack = false
	animation_player.play("death")


