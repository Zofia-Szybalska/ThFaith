extends Node


@export var unlocked_points: Array[FastTravelPoint]
@export var locked_points: Array[FastTravelPoint]
@export var curr_fast_travel_point: FastTravelPoint

func get_point(point_name: String):
	print("Szukanie w " + str(unlocked_points))
	for point in unlocked_points:
		print("Szukamy " + point.point_name)
		if point.point_name == point_name:
			curr_fast_travel_point = point
			return point
	return null

func lock_point(point: FastTravelPoint):
	unlocked_points.erase(point)
	locked_points.append(point)

func unlock_point(point: FastTravelPoint):
	unlocked_points.append(point)
	print("Odblokowany")
	locked_points.erase(point)
