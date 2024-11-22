extends CanvasLayer

@onready var save_menu = $Menues/SaveMenu
@onready var hud = $HUD
@onready var menues = $Menues
@onready var map: MarginContainer = $Menues/Map
@onready var draupnir_menu: MarginContainer = $Menues/DraupnirMenu
@onready var curr_window = draupnir_menu
@onready var next_window = map
@onready var prev_window = save_menu

var is_menu_shown = false
var has_demo_ended = false

func _ready():
	draupnir_menu.equiped_draupnirs_changed.connect(_on_equiped_draupnirs_chaged)

func _on_equiped_draupnirs_chaged():
	hud._on_equiped_draupnirs_chaged()

func _unhandled_input(event):
	if has_demo_ended:
		return
	if event.is_action_pressed("left"):
		curr_window.hide()
		curr_window = get_node(NodePath("Menues/" + curr_window.focus_neighbor_left.get_name(1)))
		curr_window.show()
		if curr_window.has_method("assaign_focus"):
			curr_window.assaign_focus()
	elif event.is_action_pressed("right"):
		curr_window.hide()
		curr_window = get_node(NodePath("Menues/" + curr_window.focus_neighbor_right.get_name(1)))
		curr_window.show()
		if curr_window.has_method("assaign_focus"):
			curr_window.assaign_focus()
	if event.is_action_pressed("inventory") or event.is_action_pressed("ui_cancel") and menues.visible:
		hide_inventory()

func hide_all_menues():
	$Menues.hide()
	for menu in menues.get_children():
		menu.hide()

func show_inventory():
	menues.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	get_tree().paused = true
	menues.show()
	draupnir_menu.load_draupnirs()
	curr_window.show()
	if curr_window.has_method("assaign_focus"):
		curr_window.assaign_focus()

func hide_inventory():
	menues.process_mode = Node.PROCESS_MODE_DISABLED
	get_tree().paused = false
	menues.hide()
	hide_all_menues()
	
