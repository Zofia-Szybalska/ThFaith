extends Node


@export var health: int = 5 : set = _set_health
@export var max_health: int = 5
@export var draupnir_max_cost: int = 5
@export var draupnirs: Array[DraupnirStats]
@export var equiped_draupnirs: Array[DraupnirStats]
@export var draupnirs_folder_path: String = "res://draupnirs"
signal health_changed

func _set_health(new_value: int) -> void:
	health = new_value
	health_changed.emit()

func _ready():
	load_draupnirs(draupnirs_folder_path)

func load_draupnirs(path):
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if not dir.current_is_dir():
				draupnirs.append(load(path + "/" + file_name))
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
