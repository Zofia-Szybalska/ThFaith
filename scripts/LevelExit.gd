extends Area2D

@export var next_scene: String = ""
@export var player_pos: Vector2 = Vector2.ZERO

func _on_body_entered(body):
	if body is Player:
		Globals.next_scene = next_scene
		get_tree().paused = false
		PlayerVariables.player_spawn_pos = player_pos
		get_tree().change_scene_to_packed(Globals.loading_screen)
