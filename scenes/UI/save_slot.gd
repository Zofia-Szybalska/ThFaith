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
	save_slot_selected.emit(save_data)

func set_save_data(value: SaveGame):
	%SaveName.text = value.get_path().get_file().get_slice(".", 0)
	%Currency.text = str(value.currency)
	save_data = value
