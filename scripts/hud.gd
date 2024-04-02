extends Control

@onready var hp_label = $HBoxContainer/HPLabel

func _ready():
	PlayerVariables.health_changed.connect(update_health)
	update_health()

func update_health():
	hp_label.text ="%s/%s" % [PlayerVariables.health, PlayerVariables.max_health]
	
