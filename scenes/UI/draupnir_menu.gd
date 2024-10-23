extends Control
@onready var space: HBoxContainer = %Space
@onready var draupnirs_icons_grid = %DraupnirsIconsGrid
@onready var draupnir_cell_scene: PackedScene = preload("res://scenes/UI/draupnir_cell.tscn")
@onready var draupnir_info_box = %DraupnirInfoBox
@onready var equiped_draupnirs = %EquipedDraupnirs
const DOT = preload("res://assets/dot.png")
const WHITE_DOT = preload("res://assets/whiteDot.png")
var equipped_draupnirs_cost: int = 0
var window_size
signal equiped_draupnirs_changed

func _ready():
	load_draupnirs()
	load_equiped_draupnirs()
	DisplayServer.window_get_size()
	load_space_indicators()
	#window_size = get_viewport().get_visible_rect().size
	#draupnir_info_box.custom_minimum_size.x = (window_size.x - 100)/3
	#draupnirs_icons_grid.custom_minimum_size.x = 2*((window_size.x - 100)/3)
	#draupnirs_icons_grid.custom_minimum_size.y = 2*((window_size.y - 100)/3)

func load_space_indicators():
	for child in space.get_children():
		child.queue_free()
	var used_spaces = equipped_draupnirs_cost
	while used_spaces > 0:
		space.add_child(create_space_idicator(true))
		used_spaces -= 1
	var not_used_spaces = PlayerVariables.draupnir_max_cost - equipped_draupnirs_cost
	while not_used_spaces > 0:
		space.add_child(create_space_idicator())
		not_used_spaces -= 1

func load_equiped_draupnirs():
	equipped_draupnirs_cost = 0
	for draupnir_cell in equiped_draupnirs.get_children():
		draupnir_cell.queue_free()
	for draupnir in PlayerVariables.draupnirs.equiped_draupnirs: 
		equipped_draupnirs_cost += draupnir.cost
		equiped_draupnirs.add_child(create_draupnir_cell(draupnir, false))
		load_space_indicators()
	#if equipped_draupnirs_cost < PlayerVariables.draupnir_max_cost:
		#var empty_spaces = PlayerVariables.draupnir_max_cost - equipped_draupnirs_cost
		#while empty_spaces > 0:
			#equiped_draupnirs.add_child(create_space_idicator())
			#empty_spaces -= 1

func create_space_idicator(white: bool = false) -> TextureRect:
	var texture_rect = TextureRect.new()
	if white:
		texture_rect.texture = WHITE_DOT
	else:
		texture_rect.texture = DOT
	texture_rect.stretch_mode = TextureRect.STRETCH_KEEP_CENTERED
	return texture_rect

func load_draupnirs():
	for draupnir_cell in draupnirs_icons_grid.get_children():
		draupnir_cell.queue_free()
	for draupnir in PlayerVariables.draupnirs.all_draupnirs:
		draupnirs_icons_grid.add_child(create_draupnir_cell(draupnir))

func _on_draupnir_equiped(draupnir_resource: DraupnirStats):
	if PlayerVariables.draupnirs.equiped_draupnirs.has(draupnir_resource):
		PlayerVariables.draupnirs.equiped_draupnirs.erase(draupnir_resource)
		equipped_draupnirs_cost -= draupnir_resource.cost
		load_equiped_draupnirs()
		return
	if (equipped_draupnirs_cost + draupnir_resource.cost <= PlayerVariables.draupnir_max_cost) and not PlayerVariables.draupnirs.equiped_draupnirs.has(draupnir_resource):
		PlayerVariables.draupnirs.equiped_draupnirs.append(draupnir_resource)
		load_equiped_draupnirs()
	elif not PlayerVariables.draupnirs.equiped_draupnirs.has(draupnir_resource):
		print("This Draupnir costs too much!")

func _on_draupnir_cell_clicked(draupnir_resource: DraupnirStats):
	draupnir_info_box.load_draupnir(draupnir_resource)

func create_draupnir_cell(draupnir: DraupnirStats, with_frame: bool = true):
	var draupnir_cell = draupnir_cell_scene.instantiate()
	draupnir_cell.draupnir_resource = draupnir
	draupnir_cell.clicked.connect(_on_draupnir_cell_clicked)
	draupnir_cell.equiped.connect(_on_draupnir_equiped)
	draupnir_cell.with_frame = with_frame
	return draupnir_cell

func _on_hidden():
	equiped_draupnirs_changed.emit()
	PlayerVariables.draupnirs.activate_draupnirs()

func _on_draw():
	equiped_draupnirs_changed.emit()
	PlayerVariables.draupnirs.deactivate_draupnirs()
