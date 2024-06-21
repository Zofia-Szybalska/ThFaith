extends Control

@onready var texture_button = $TextureButton

signal clicked(draupnir_resource: DraupnirStats)
signal equiped(draupnir_resource: DraupnirStats)

@export var draupnir_resource: DraupnirStats
var times_clicked: int = 0

func _ready():
	if draupnir_resource:
		load_draupnir_resource(draupnir_resource)

func load_draupnir_resource(draupnir: DraupnirStats):
		draupnir_resource = draupnir
		if draupnir.is_unlocked:
			print("Grafika update")
			texture_button.texture_normal = draupnir.icon
			texture_button.modulate = Color.WHITE
		else:
			texture_button.texture_normal = draupnir.locked_icon
			texture_button.modulate = Color(0.431, 0.431, 0.431, 0.937)

func _on_texture_button_pressed():
	times_clicked += 1
	if times_clicked == 1:
		clicked.emit(draupnir_resource)
	elif times_clicked >= 2 and draupnir_resource.is_unlocked:
		equiped.emit(draupnir_resource)
		times_clicked = 1

func _on_texture_button_focus_exited():
	times_clicked = 0
