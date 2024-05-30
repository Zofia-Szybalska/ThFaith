extends Node


@export var health: int = 5 : set = _set_health
@export var max_health: int = 5
@export var currency: int = 0 : set = _set_currency
@export var draupnirs: Draupnirs = Draupnirs.new()
@export var draupnir_max_cost: int = 5
@export var player: Player = null
@export var coin_area_radius: int = 15
@export var enemies_detection_range: int = 600
@export var player_speed: int = 700
@export var damage_multiplayer: int = 1
@export var damage_taken_multiplayer: int = 1
@export var dodge_chance: float = 0.0
@export var currency_dropped_multiplayer: float = 1.0
signal health_changed
signal currency_changed


func update_enemy_nodes():
	get_tree().call_group("Enemies","update_enemy")

func change_enemy_nodes(func_name: String, detection_range = null):
	if detection_range:
		get_tree().call_group("Enemies",func_name,detection_range)
		enemies_detection_range = detection_range
	else:
		get_tree().call_group("Enemies",func_name)

func change_coin_nodes(func_name: String, radius = null):
	if radius:
		get_tree().call_group("Coins",func_name,radius)
		coin_area_radius = radius
	else:
		get_tree().call_group("Coins",func_name)

func _set_health(new_value: int) -> void:
	health = new_value
	health_changed.emit()

func _set_currency(new_value: int) -> void:
	var amount_changed = new_value - currency
	currency = new_value
	currency_changed.emit(amount_changed)

func _ready():
	draupnirs.load_draupnirs()
