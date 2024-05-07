extends Control

@onready var texture_button = $TextureButton

signal clicked(draupnir_resource: DraupnirStats)
signal equiped(draupnir_resource: DraupnirStats)

@export var draupnir_resource: DraupnirStats
var times_clicked: int = 0

func _ready():
	if draupnir_resource:
		load_draupnir_resource(draupnir_resource)

func load_draupnir_resource(draupnir_resource: DraupnirStats):
	self.draupnir_resource = draupnir_resource
	if draupnir_resource.is_unlocked:
		texture_button.texture_normal = draupnir_resource.icon
		texture_button.modulate = Color.WHITE
	else:
		texture_button.texture_normal = draupnir_resource.locked_icon
		texture_button.modulate = Color.RED

func _on_texture_button_pressed():
	times_clicked += 1
	if times_clicked == 1:
		clicked.emit(draupnir_resource)
	elif times_clicked >= 2:
		equiped.emit(draupnir_resource)
		times_clicked = 1

func _on_texture_button_focus_exited():
	times_clicked = 0
