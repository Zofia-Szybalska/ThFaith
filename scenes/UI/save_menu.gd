extends MarginContainer

@export var saver_loader: SaverLoader
@onready var saves_container = $PanelContainer/MarginContainer/VBoxContainer/Saves/SavesContainer
@onready var save_slot: PackedScene = preload("res://scenes/UI/save_slot.tscn")
var saves_path = "user://"
var selected_save: SaveGame

func _ready():
	anchors_preset = PRESET_FULL_RECT
	load_saves()

func load_saves():
	for child in saves_container.get_children():
		child.queue_free()
	var dir = DirAccess.open(saves_path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if not dir.current_is_dir():
				var save: SaveGame = load(saves_path + "/" + file_name) as SaveGame
				if save == null:
					print("Resource wasn't safe!")
				else:
					var new_save_slot = save_slot.instantiate()
					new_save_slot.save_data = save
					new_save_slot.save_slot_selected.connect(_on_save_slot_pressed)
					saves_container.add_child(new_save_slot)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")

func _on_save_slot_pressed(save_data: SaveGame):
	selected_save = save_data

func _on_save_button_pressed():
	saver_loader.load_game(selected_save)

func _on_erase_button_pressed():
	pass # Replace with function body.


func _on_back_button_pressed():
	pass # Replace with function body.


func _on_visibility_changed():
	if visible ==  true:
		load_saves()
