extends Resource
class_name FastTravelPoint

@export var point_name: String
@export var position: Vector2 = Vector2.ZERO
@export var map_position: Vector2 = Vector2.ZERO
@export var scene_name: String = ""
@export var is_unlocked: bool = false

func _init(_point_name = "", point_position = Vector2.ZERO, point_map_position = Vector2.ZERO, point_scene_name = "", _is_unlocked = false):
	point_name = _point_name
	position = point_position
	map_position = point_map_position
	scene_name = point_scene_name
	is_unlocked = _is_unlocked
