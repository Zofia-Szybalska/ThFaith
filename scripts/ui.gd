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

func _unhandled_input(event):
	if has_demo_ended or hud.dead:
		return
	if event.is_action_pressed("left"):
		curr_window.hide()
		var temp_window = curr_window
		curr_window = prev_window
		prev_window = next_window
		next_window = temp_window
		curr_window.show()
	elif event.is_action_pressed("right"):
		curr_window.hide()
		var temp_window = prev_window
		prev_window = curr_window
		curr_window = next_window
		next_window = temp_window
		curr_window.show()
	if event.is_action_pressed("inventory") or event.is_action_pressed("ui_cancel") and menues.visible:
		hide_inventory()

func hide_all_menues():
	$Menues.hide()
	for menu in menues.get_children():
		menu.hide()

func show_inventory():
	get_tree().paused = true
	menues.show()
	draupnir_menu.load_draupnirs()
	curr_window.show()

func hide_inventory():
	get_tree().paused = false
	menues.hide()
	hide_all_menues()
	
