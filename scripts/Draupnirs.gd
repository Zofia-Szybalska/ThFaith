extends Resource
class_name Draupnirs

@export var all_draupnirs: Array[DraupnirStats] = []
@export var equiped_draupnirs: Array[DraupnirStats] = []
@export var draupnirs_folder_path: String = "res://draupnirs"

func unlock_draupnri(draupnir_name: String):
	for draupnir in all_draupnirs:
		if draupnir.name == draupnir_name:
			draupnir.is_unlocked = true

func lock_draupnri(draupnir_name: String):
	for draupnir in all_draupnirs:
		if draupnir.name == draupnir_name:
			draupnir.is_unlocked = false

func load_draupnirs():
	var dir = DirAccess.open(draupnirs_folder_path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if not dir.current_is_dir():
				var draupnir: DraupnirStats = load(draupnirs_folder_path + "/" + file_name)
				if draupnir == null:
					print("Resource wasn't safe!")
				else:
					all_draupnirs.append(draupnir)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")

func activate_draupnirs():
	for draupnir in equiped_draupnirs:
		draupnir.activate()

func deactivate_draupnirs():
	for draupnir in equiped_draupnirs:
		draupnir.deactivate()
