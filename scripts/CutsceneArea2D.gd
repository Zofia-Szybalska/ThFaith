extends Area2D

@onready var cutscene_animation_player = $CutsceneAnimationPlayer
@export var player: Player
var wolf_enemy = preload("res://enemies/wolf/wolf.tscn")
var wolfs_killed = false
var cliff_cutscene_played = false


func _ready():
	if PlayerVariables.mom_dying:
		queue_free()

func _on_body_entered(body):
	if body is Player:
		cutscene_animation_player.play("cutscene")
		set_collision_mask_value(2, false)

func _process(_delta):
	if $Enemies.get_child_count() == 0 and not wolfs_killed:
		wolfs_killed = true
		cutscene_animation_player.play("wolfs_killed")

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

func fade_in():
	TransitionScreen.transition_to_black()

func change_to_house():
	PlayerVariables.mom_dying = true
	Globals.next_scene = "res://scenes/house.tscn"
	get_tree().paused = false
	get_tree().change_scene_to_packed(Globals.loading_screen)

func fade_out():
	TransitionScreen.transition_from_black()

func _on_dialogic_signal(argument:String):
	if argument == "house_on_fire":
		change_to_house()
	if argument == "cut_tree":
		cutscene_animation_player.play("cut_tree")
	if argument == "timeline_ended":
		for child in $Enemies.get_children():
			if child is Wolf:
				child.is_idle = false
			else:
				child.queue_free()
		#get_tree().paused = false
		player.can_be_controled = true

func spawn_wolf(wolf_position:Vector2):
	var wolf = wolf_enemy.instantiate()
	wolf.position = wolf_position
	$Enemies.add_child(wolf)

func _on_enemy_1_area_2d_body_entered(body):
	if body is Wolf:
		body.is_idle = true
		$Enemies/Enemy1Area2D.queue_free()

func _on_enemy_2_area_2d_body_entered(body):
	if body is Wolf:
		body.is_idle = true
		$Enemies/Enemy2Area2D.queue_free()

func _on_cliff_body_entered(body):
	if body is Player and not cliff_cutscene_played:
		if PlayerVariables.abilities.double_jump_unlocked:
			play_timeline("cliff_double_jump")
		else:
			play_timeline("cliff")
		cliff_cutscene_played = true


func _on_cliff_body_exited(body):
	if body is Player:
		pass
