extends Control
@onready var draupnirs_icons_grid = %DraupnirsIconsGrid
@onready var draupnir_cell_scene: PackedScene = preload("res://scenes/UI/draupnir_cell.tscn")
@onready var draupnir_info_box = %DraupnirInfoBox
@onready var equiped_draupnirs = %EquipedDraupnirs

var equipped_draupnirs_cost: int = 0
var window_size

func _ready():
	load_draupnirs()
	load_equiped_draupnirs()
	DisplayServer.window_get_size()
	#window_size = get_viewport().get_visible_rect().size
	#draupnir_info_box.custom_minimum_size.x = (window_size.x - 100)/3
	#draupnirs_icons_grid.custom_minimum_size.x = 2*((window_size.x - 100)/3)
	#draupnirs_icons_grid.custom_minimum_size.y = 2*((window_size.y - 100)/3)
	

func load_equiped_draupnirs():
	equipped_draupnirs_cost = 0
	for draupnir_cell in equiped_draupnirs.get_children():
		draupnir_cell.queue_free()
	for draupnir in PlayerVariables.equiped_draupnirs: 
		equipped_draupnirs_cost += draupnir.cost
		equiped_draupnirs.add_child(create_draupnir_cell(draupnir))
	if equipped_draupnirs_cost < PlayerVariables.draupnir_max_cost:
		pass

func load_draupnirs():
	for draupnir in PlayerVariables.draupnirs:
		draupnirs_icons_grid.add_child(create_draupnir_cell(draupnir))

func _on_draupnir_equiped(draupnir_resource: DraupnirStats):
	if PlayerVariables.equiped_draupnirs.has(draupnir_resource):
		PlayerVariables.equiped_draupnirs.erase(draupnir_resource)
		equipped_draupnirs_cost -= draupnir_resource.cost
		load_equiped_draupnirs()
		return
	if (equipped_draupnirs_cost + draupnir_resource.cost <= PlayerVariables.draupnir_max_cost) and not PlayerVariables.equiped_draupnirs.has(draupnir_resource):
		PlayerVariables.equiped_draupnirs.append(draupnir_resource)
		load_equiped_draupnirs()
	elif not PlayerVariables.equiped_draupnirs.has(draupnir_resource):
		print("This Draupnir costs too much!")
		

func _on_draupnir_cell_clicked(draupnir_resource: DraupnirStats):
	draupnir_info_box.load_draupnir(draupnir_resource)

func create_draupnir_cell(draupnir: DraupnirStats):
	var draupnir_cell = draupnir_cell_scene.instantiate()
	draupnir_cell.draupnir_resource = draupnir
	draupnir_cell.clicked.connect(_on_draupnir_cell_clicked)
	draupnir_cell.equiped.connect(_on_draupnir_equiped)
	return draupnir_cell


func _on_item_rect_changed():
	pass # Replace with function body.
