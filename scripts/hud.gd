extends Control

@onready var hp_label = %HPLabel
@onready var currency_label = %CurrencyLabel
@onready var currency_changed_lable = %CurrencyChangedLable
@onready var dead_screen = $DeadScreen

@export var time_showing_new_items: float = 5.0
var dead = false

func _ready():
	PlayerVariables.health_changed.connect(update_health)
	PlayerVariables.currency_changed.connect(update_currency)
	update_health()
	update_currency()

func update_health():
	hp_label.text ="%s/%s" % [PlayerVariables.health, PlayerVariables.max_health]
	if PlayerVariables.health == 0:
		get_tree().paused = true
		dead = true
		dead_screen.show()

func update_currency(amount_changed: int = 0):
	currency_label.text = str(PlayerVariables.currency)
	currency_changed_lable.modulate = Color(1, 1, 1, 1)
	if not amount_changed == 0:
		currency_changed_lable.text = ""
		if amount_changed > 0:
			currency_changed_lable.text = "+ "
		currency_changed_lable.text += str(amount_changed)
		var tween = get_tree().create_tween()
		tween.tween_property(currency_changed_lable, "modulate", Color(1, 1, 1, 0), time_showing_new_items)

func _on_button_pressed():
	dead_screen.hide()
	PlayerVariables.health = PlayerVariables.max_health
	get_tree().paused = false
	dead = false
	get_tree().change_scene_to_file("res://scenes/levels/midgard.tscn")
