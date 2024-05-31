extends Node2D

var fast_travel_point: FastTravelPoint
@export var point_name: String = ""
@export var is_unlocked: bool = false

func _ready():
	fast_travel_point = FastTravelPoint.new()
	fast_travel_point.point_name = point_name
	fast_travel_point.position = $Marker2D.global_position
	fast_travel_point.scene_name = get_tree().get_current_scene().get_name()
	if not PlayerVariables.fast_travel_points.locked_points.has(fast_travel_point) and not PlayerVariables.fast_travel_points.unlocked_points.has(fast_travel_point):
		if is_unlocked:
			PlayerVariables.fast_travel_points.unlocked_points.append(fast_travel_point)
		else:
			PlayerVariables.fast_travel_points.locked_points.append(fast_travel_point)

func _on_area_2d_body_entered(body):
	if body is Player:
		is_unlocked = true
		PlayerVariables.fast_travel_points.unlock_point(fast_travel_point)
