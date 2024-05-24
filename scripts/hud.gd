extends Control

@onready var hp_label = $VBoxContainer/Health/HPLabel
@onready var currency_label = $VBoxContainer/Currency/CurrencyLabel
@onready var currency_changed_lable = $VBoxContainer/Currency/CurrencyChangedLable

@export var time_showing_new_items: float = 5.0

func _ready():
	PlayerVariables.health_changed.connect(update_health)
	PlayerVariables.currency_changed.connect(update_currency)
	update_health()
	update_currency()

func update_health():
	hp_label.text ="%s/%s" % [PlayerVariables.health, PlayerVariables.max_health]

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
