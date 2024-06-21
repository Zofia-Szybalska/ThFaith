extends Resource
class_name FastTravelPoints

@export var unlocked_points: Array[FastTravelPoint]
@export var locked_points: Array[FastTravelPoint]
@export var curr_fast_travel_point: FastTravelPoint
@export var fast_travel_points_folder_path: String = "res://fast_travle_points/"

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

func load_points():
	var dir = DirAccess.open(fast_travel_points_folder_path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if not dir.current_is_dir():
				var fast_travel_point: FastTravelPoint = load(fast_travel_points_folder_path + "/" + file_name)
				if fast_travel_point == null:
					print("Resource wasn't safe!")
				else:
					if fast_travel_point.is_unlocked:
						unlocked_points.append(fast_travel_point)
					else: 
						locked_points.append(fast_travel_point)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
