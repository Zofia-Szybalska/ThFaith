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
@export var button: Node = null
var prev_draupnir

func _ready():
	load_draupnirs()
	load_equiped_draupnirs()
	DisplayServer.window_get_size()
	load_space_indicators()

func _input(event):
	var current = get_viewport().gui_get_focus_owner()
	if not current:
		return
	if event is InputEventJoypadButton:
		if event.button_index == JOY_BUTTON_A and event.pressed:
			if current is Button:
				current.emit_signal("pressed")

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
	prev_draupnir = null
	var first_draupnir = null
	for draupnir in PlayerVariables.draupnirs.equiped_draupnirs:
		equipped_draupnirs_cost += draupnir.cost
		var draupnir_cell = create_draupnir_cell(draupnir, false)
		equiped_draupnirs.add_child(draupnir_cell)
		if prev_draupnir:
			draupnir_cell.texture_button.set_focus_neighbor(SIDE_LEFT, prev_draupnir.texture_button.get_path())
			prev_draupnir.texture_button.set_focus_neighbor(SIDE_RIGHT, draupnir_cell.texture_button.get_path())
		prev_draupnir = draupnir_cell
		if not first_draupnir:
			first_draupnir = draupnir_cell
	if first_draupnir:
		first_draupnir.texture_button.set_focus_neighbor(SIDE_LEFT, prev_draupnir.texture_button.get_path())
		prev_draupnir.texture_button.set_focus_neighbor(SIDE_RIGHT, first_draupnir.texture_button.get_path())
	prev_draupnir = null
	load_space_indicators()

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
	prev_draupnir = null
	var first_draupnir = null
	var first_unlocked_draupnir = null
	for draupnir in PlayerVariables.draupnirs.all_draupnirs:
		var draupnir_cell = create_draupnir_cell(draupnir)
		draupnirs_icons_grid.add_child(draupnir_cell)
		if prev_draupnir:
			draupnir_cell.texture_button.set_focus_neighbor(SIDE_LEFT, prev_draupnir.texture_button.get_path())
			prev_draupnir.texture_button.set_focus_neighbor(SIDE_RIGHT, draupnir_cell.texture_button.get_path())
		prev_draupnir = draupnir_cell
		if draupnir.is_unlocked and not first_unlocked_draupnir:
			button = draupnir_cell.texture_button
		if not first_draupnir:
			first_draupnir = draupnir_cell
	if first_draupnir:
		first_draupnir.texture_button.set_focus_neighbor(SIDE_LEFT, prev_draupnir.texture_button.get_path())
		prev_draupnir.texture_button.set_focus_neighbor(SIDE_RIGHT, first_draupnir.texture_button.get_path())
		first_draupnir = null
	prev_draupnir = null

func assaign_focus():
	if button:
		button.grab_focus()

func _on_draupnir_equiped(draupnir_resource: DraupnirStats):
	if PlayerVariables.draupnirs.equiped_draupnirs.has(draupnir_resource):
		PlayerVariables.draupnirs.equiped_draupnirs.erase(draupnir_resource)
		equipped_draupnirs_cost -= draupnir_resource.cost
		if PlayerVariables.draupnirs.equiped_draupnirs.is_empty():
			assaign_focus()
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
	PlayerVariables.draupnirs.send_equiped_draupnirs_data()

func _on_draw():
	equiped_draupnirs_changed.emit()
	PlayerVariables.draupnirs.deactivate_draupnirs()
