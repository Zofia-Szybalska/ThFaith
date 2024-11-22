extends PanelContainer

signal save_slot_selected
@export var save_data: SaveGame = SaveGame.new(): set = set_save_data
@onready var button = $TextureRect



func _input(event):
	var current = get_viewport().gui_get_focus_owner()
	if not current:
		return
	if event is InputEventJoypadButton:
		if event.button_index == JOY_BUTTON_A and event.pressed:
			if current is Button:
				current.emit_signal("pressed")

func _on_texture_rect_pressed():
	print(save_data.level_path)
	save_slot_selected.emit(save_data)

func set_save_data(value: SaveGame):
	$TextureRect/VBoxContainer/Label5.text = value.level_path
	$TextureRect/VBoxContainer/Label4.text = str(value.currency)
	save_data = value
