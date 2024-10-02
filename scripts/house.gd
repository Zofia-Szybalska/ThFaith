extends Node2D


func _ready():
	Dialogic.start("res://Dialogic_timelines/prolog.dtl").process_mode = Node.PROCESS_MODE_ALWAYS
	Dialogic.process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().paused = true
	Dialogic.signal_event.connect(_on_dialogic_signal)
	if Dialogic.current_timeline != null:
		return
	Dialogic.start('prolog')

func _on_dialogic_signal(argument:String):
	get_tree().paused = false
	if argument == "prolog_ended":
		get_tree().change_scene_to_file("res://scenes/levels/midgard.tscn")
