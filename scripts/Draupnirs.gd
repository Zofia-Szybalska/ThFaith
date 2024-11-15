extends Resource
class_name Draupnirs

@export var all_draupnirs: Array[DraupnirStats] = []
@export var equiped_draupnirs: Array[DraupnirStats] = []
@export var curr_equiped_draupnirs: Array[DraupnirStats] = []
@export var draupnirs_folder_path: String = "res://draupnirs"

func unlock_draupnir(draupnir_name: String):
	for draupnir in all_draupnirs:
		if draupnir.name == draupnir_name:
			Analytics.add_event("Draupnir unlocked", { "name": draupnir.name})
			draupnir.is_unlocked = true

func lock_draupnir(draupnir_name: String):
	for draupnir in all_draupnirs:
		if draupnir.name == draupnir_name:
			draupnir.is_unlocked = false

func send_equiped_draupnirs_data():
	for draupnir in curr_equiped_draupnirs:
		if not equiped_draupnirs.has(draupnir):
			curr_equiped_draupnirs.erase(draupnir)
	for draupnir in equiped_draupnirs:
		if not curr_equiped_draupnirs.has(draupnir):
			curr_equiped_draupnirs.append(draupnir)
			Analytics.add_event("Draupnir equiped", { "name": draupnir.name})

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
		Analytics.add_event("Draupnir equiped", { "name": draupnir.name})
		draupnir.activate()

func deactivate_draupnirs():
	for draupnir in equiped_draupnirs:
		draupnir.deactivate()
