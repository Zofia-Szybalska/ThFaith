extends Area2D

@onready var cutscene_animation_player = $CutsceneAnimationPlayer
@export var player: Player

func _on_body_entered(body):
	if body is Player:
		cutscene_animation_player.play("cutscene")
		set_collision_mask_value(2, false)

func play_timeline(timeline_name: String):
	Dialogic.start("res://Dialogic_timelines/" + timeline_name + ".dtl").process_mode = Node.PROCESS_MODE_ALWAYS
	Dialogic.process_mode = Node.PROCESS_MODE_ALWAYS
	#get_tree().paused = true
	Dialogic.signal_event.connect(_on_dialogic_signal)
	if Dialogic.current_timeline != null:
		return
	Dialogic.start(timeline_name)

func pause_tree():
	get_tree().paused = true

func _on_dialogic_signal(argument:String):
	if argument == "timeline_ended":
		#get_tree().paused = false
		player.can_be_controled = true
