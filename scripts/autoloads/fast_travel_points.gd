extends Node

@export var unlocked_points: Array[FastTravelPoint]
@export var locked_points: Array[FastTravelPoint]
@export var curr_fast_travel_point: FastTravelPoint

func get_point(point_name: String):
	for point in unlocked_points:
		if point.point_name == point_name:
			curr_fast_travel_point = point
			return point
	return null

func lock_point(point: FastTravelPoint):
	unlocked_points.erase(point)
	locked_points.append(point)

func unlock_point(point: FastTravelPoint):
	unlocked_points.append(point)
	locked_points.erase(point)
