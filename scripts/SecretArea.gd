extends Area2D

@onready var midgard_tile_map = $MidgardTileMap
@export var animation_time: float = 0.5

func _on_body_entered(body):
	if body is Player:
		var tween = get_tree().create_tween()
		tween.tween_property(midgard_tile_map, "modulate", Color(1, 1, 1, 0), animation_time)


func _on_body_exited(body):
	if body is Player:
		var tween = get_tree().create_tween()
		tween.tween_property(midgard_tile_map, "modulate", Color(1, 1, 1, 1), animation_time)
