extends Node2D

@onready var fenrir = $Fenrir
var battle_started = false

func _on_battle_trigger_area_body_entered(body):
	if body is Player:
		fenrir.start_battle()
		$BattleTriggerArea.queue_free()
