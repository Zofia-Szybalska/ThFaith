extends Control

@onready var draupnirs_icons_grid = $PanelContainer/HBoxContainer/VBoxContainer/DraupnirsIconsGrid
@onready var draupnir_cell_scene: PackedScene = preload("res://scenes/UI/draupnir_cell.tscn")
@onready var draupnir_info_box = $PanelContainer/HBoxContainer/DraupnirInfoBox

func _ready():
	load_draupnirs()

func load_draupnirs():
	for draupnir in PlayerVariables.draupnirs:
		var draupnir_cell = draupnir_cell_scene.instantiate()
		draupnir_cell.draupnir_resource = draupnir
		draupnir_cell.clicked.connect(_on_draupnir_cell_clicked)
		draupnir_cell.equiped.connect(_on_draupnir_equiped)
		draupnirs_icons_grid.add_child(draupnir_cell)

func _on_draupnir_equiped(draupnir_resource: DraupnirStats):
	if draupnir_resource.is_unlocked:
		draupnir_info_box.load_draupnir(draupnir_resource)

func _on_draupnir_cell_clicked(draupnir_resource: DraupnirStats):
	draupnir_info_box.load_draupnir(draupnir_resource)
