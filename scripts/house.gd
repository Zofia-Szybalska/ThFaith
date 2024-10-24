extends Node2D


func _ready():
	TransitionScreen.transition_finished.connect(_on_screen_blacked_out)
	Dialogic.start("res://Dialogic_timelines/prolog.dtl").process_mode = Node.PROCESS_MODE_ALWAYS
	Dialogic.process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().paused = true
	Dialogic.signal_event.connect(_on_dialogic_signal)
	if Dialogic.current_timeline != null:
		return
	Dialogic.start('prolog')

func _on_screen_blacked_out():
	Globals.next_scene = "res://scenes/levels/midgard.tscn"
	get_tree().paused = false
	get_tree().change_scene_to_packed(Globals.loading_screen)

func _on_dialogic_signal(argument:String):
	if argument == "prolog_ended":
		TransitionScreen.transition_to_black()
