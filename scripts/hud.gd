extends Control

@onready var hp_label = %HPLabel
@onready var currency_label = %CurrencyLabel
@onready var currency_changed_lable = %CurrencyChangedLable
@onready var dead_screen = $DeadScreen
@onready var currency_lable = %CurrencyLable
@onready var currency_changed_label = %CurrencyChangedLabel
@onready var draupnir_icons = %DraupnirIcons
@onready var HP_array
signal player_died
@export var time_showing_new_items: float = 5.0
@export var saver_loader: SaverLoader

func _ready():
	HP_array = $VBoxContainer/HP/VBoxContainer/Bar/HPs.get_children()
	PlayerVariables.health_changed.connect(update_health)
	PlayerVariables.currency_changed.connect(update_currency)
	update_health()
	update_currency()

func _input(event):
	var current = get_viewport().gui_get_focus_owner()
	if not current:
		return
	if event is InputEventJoypadButton:
		if event.button_index == JOY_BUTTON_A and event.pressed:
			if current is Button or current is TextureButton:
				current.emit_signal("pressed")

func update_health():
	hp_label.text ="%s/%s" % [PlayerVariables.health, PlayerVariables.max_health]
	for HP in HP_array:
		HP.visible = false
	for index in PlayerVariables.health:
		HP_array[index].visible = true
	if PlayerVariables.health == 0:
		if PlayerVariables.fighting_Fenrir:
			PlayerVariables.deaths_at_Fenrir += 1
		player_died.emit()
		#Analytics.add_event("Player died")
		#get_tree().paused = true
		dead_screen.show()
		$DeadScreen/PanelContainer/MarginContainer/Button.grab_focus()

func update_currency(amount_changed: int = 0):
	currency_label.text = str(PlayerVariables.currency)
	currency_lable.text = str(PlayerVariables.currency)
	currency_changed_lable.modulate = Color(1, 1, 1, 1)
	currency_changed_label.modulate = Color(1, 1, 1, 1)
	if not amount_changed == 0:
		currency_changed_lable.text = ""
		currency_changed_label.text = ""
		if amount_changed > 0:
			currency_changed_lable.text = "+ "
			currency_changed_label.text = "+ "
		currency_changed_lable.text += str(amount_changed)
		currency_changed_label.text += str(amount_changed)
		var tween = get_tree().create_tween()
		tween.tween_property(currency_changed_label, "modulate", Color(1, 1, 1, 0), time_showing_new_items)
		tween.tween_property(currency_changed_lable, "modulate", Color(1, 1, 1, 0), time_showing_new_items)

func redraw_draupnirs_icons():
	for child in draupnir_icons.get_children():
		child.queue_free()
	for draupnir in PlayerVariables.draupnirs.equiped_draupnirs:
		draw_draupnir_icon(draupnir.HUD_icon)

func draw_draupnir_icon(icon: Texture2D):
	var new_icon = TextureRect.new()
	new_icon.texture = icon
	new_icon.scale = Vector2(0.5, 0.5)
	draupnir_icons.add_child(new_icon)

func _on_equiped_draupnirs_chaged():
	redraw_draupnirs_icons()

func _on_button_pressed():
	dead_screen.hide()
	PlayerVariables.health = PlayerVariables.max_health
	PlayerVariables.player_spawn_pos = PlayerVariables.last_camp_pos
	Globals.next_scene = PlayerVariables.current_scene_path
	get_tree().paused = false
	var error = get_tree().change_scene_to_packed(Globals.loading_screen)
	print(error)
