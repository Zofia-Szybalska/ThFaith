extends State

@onready var animation_player = $"../../AnimationPlayer"

func enter(_msg := {}) -> void:
	animation_player.play("death")
	print("Here!")


