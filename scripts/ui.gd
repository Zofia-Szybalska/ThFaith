extends CanvasLayer

@onready var hud = $HUD
@onready var menues = $Menues
@onready var map: MarginContainer = $Menues/Map
@onready var draupnir_menu: MarginContainer = $Menues/DraupnirMenu
@onready var curr_window = draupnir_menu

var is_menu_shown = false

func _unhandled_input(event):
	if event.is_action_pressed("left"):
		curr_window.hide()
		curr_window = map
		curr_window.show()
	elif event.is_action_pressed("right"):
		curr_window.hide()
		curr_window = draupnir_menu
		curr_window.show()
	if event.is_action_pressed("inventory") or event.is_action_pressed("ui_cancel") and menues.visibile:
		hide_inventory()

func hide_all_menues():
	for menu in menues.get_children():
		menu.hide()

func show_inventory():
	get_tree().paused = true
	menues.show()

func hide_inventory():
	get_tree().paused = false
	menues.hide()
