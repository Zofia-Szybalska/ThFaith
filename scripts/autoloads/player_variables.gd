extends Node


@export var health: int = 5 : set = _set_health
@export var max_health:int = 5
signal health_changed

func _set_health(new_value: int) -> void:
	health = new_value
	health_changed.emit()
