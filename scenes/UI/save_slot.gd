extends PanelContainer

signal save_slot_selected
@export var save_data: SaveGame = SaveGame.new(): set = set_save_data

func _on_texture_rect_pressed():
	print(save_data.level_path)
	save_slot_selected.emit(save_data)

func set_save_data(value: SaveGame):
	$TextureRect/VBoxContainer/Label5.text = value.level_path
	$TextureRect/VBoxContainer/Label4.text = str(value.currency)
	save_data = value
