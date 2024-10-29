extends Area2D

@onready var cutscene_animation_player = $CutsceneAnimationPlayer


func _on_body_entered(body):
	if body is Player:
		cutscene_animation_player.play("cutscene")
