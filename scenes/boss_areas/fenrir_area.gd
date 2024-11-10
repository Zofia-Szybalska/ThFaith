extends Node2D

@onready var fenrir = $Fenrir
var battle_started = false
@onready var parts = $Fenrir/Parts

func _ready():
	PlayerVariables.current_scene = "FenrirArea"
	PlayerVariables.current_scene_path = scene_file_path

func _on_battle_trigger_area_body_entered(body):
	if body is Player:
		fenrir.start_battle()
		if not PlayerVariables.seen_fenrir_at_least_once:
			PlayerVariables.seen_fenrir_at_least_once = true
			Analytics.add_event("Boss battle start", { "boss name": "Fenrir", "start time": Time.get_time_string_from_system()})
		$BattleTriggerArea.queue_free()
