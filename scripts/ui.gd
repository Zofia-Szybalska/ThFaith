extends CanvasLayer

@onready var save_menu = $Menues/SaveMenu
@onready var hud = $HUD
@onready var menues = $Menues
@onready var map: MarginContainer = $Menues/Map
@onready var draupnir_menu: MarginContainer = $Menues/DraupnirMenu
@onready var curr_window = draupnir_menu
@onready var next_window = map
@onready var prev_window = save_menu
@onready var arrows = $Menues/Arrows

var is_menu_shown = false
var has_demo_ended = false

func _ready():
	if not PlayerVariables.first_draupnir_unlocked:
		PlayerVariables.draupnirs.first_draupnir_picked_up.connect(_on_first_draupnir_picked_up)
	draupnir_menu.equiped_draupnirs_changed.connect(_on_equiped_draupnirs_chaged)

func _on_equiped_draupnirs_chaged():
	hud._on_equiped_draupnirs_chaged()

func _on_first_draupnir_picked_up():
	curr_window = draupnir_menu
	show_inventory()

func _unhandled_key_input(event):
	if has_demo_ended:
		return
	if check_close(event):
		return
	if event.is_action_pressed("inventory"):
		if menues.visible:
			curr_window.hide()
			curr_window = draupnir_menu
			curr_window.show()
		else:
			curr_window = draupnir_menu
	if event.is_action_pressed("map"):
		if menues.visible:
			curr_window.hide()
			curr_window = map
			curr_window.show()
		else:
			curr_window = map
	if event.is_action_pressed("save_menu"):
		if menues.visible:
			curr_window.hide()
			curr_window = save_menu
			curr_window.show()
		else:
			curr_window = save_menu
	if event.is_action_pressed("inventory") or event.is_action_pressed("map") or event.is_action_pressed("save_menu"):
		if not menues.visible:
			show_inventory()
		if not PlayerVariables.inventory_oppend_at_least_once:
			PlayerVariables.inventory_oppend_at_least_once = true
			Analytics.add_event("Inventory opened")
	if event.is_action_pressed("menu_left"):
		screen_left()
	elif event.is_action_pressed("menu_right"):
		screen_right()
	#get_viewport().set_input_as_handled()

func check_close(event):
	if event.is_action_pressed("ui_cancel") and menues.visible:
		hide_inventory()
		return true
	if curr_window.visible:

		if event.is_action_pressed("inventory") and curr_window == draupnir_menu:
			hide_inventory()
			return true
		if event.is_action_pressed("map") and curr_window == map:
			hide_inventory()
			return true
		if event.is_action_pressed("save_menu") and curr_window == save_menu:
			hide_inventory()
			return true
	return false

func hide_all_menues():
	$Menues.hide()
	for menu in menues.get_children():
		menu.hide()

func show_inventory():
	arrows.show()
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

func screen_left():
	if menues.visible:
		curr_window.hide()
		curr_window = get_node(NodePath("Menues/" + curr_window.focus_neighbor_left.get_name(1)))
		curr_window.show()
		if curr_window.has_method("assaign_focus"):
			curr_window.assaign_focus()

func screen_right():
	if menues.visible:
		curr_window.hide()
		curr_window = get_node(NodePath("Menues/" + curr_window.focus_neighbor_right.get_name(1)))
		curr_window.show()
		if curr_window.has_method("assaign_focus"):
			curr_window.assaign_focus()

func _on_arrow_left_pressed():
	screen_left()

func _on_arrow_right_pressed():
	screen_right()
