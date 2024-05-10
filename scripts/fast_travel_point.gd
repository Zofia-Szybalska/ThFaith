extends Resource
class_name FastTravelPoint

@export var point_name: String
@export var position: Vector2 = Vector2.ZERO
@export var scene_name: String = ""

func _init(_point_name = "", point_position = Vector2.ZERO, point_scene_name = ""):
	point_name = _point_name
	position = point_position
	scene_name = point_scene_name
