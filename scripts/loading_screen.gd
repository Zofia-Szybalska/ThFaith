extends Control
@onready var progress_bar = $MarginContainer/VBoxContainer/ProgressBar


func _ready():
	ResourceLoader.load_threaded_request(Globals.next_scene)

func _process(_delta):
	var progress = []
	ResourceLoader.load_threaded_get_status(Globals.next_scene, progress)
	progress_bar.value = progress[0]*100
	
	if progress[0] == 1:
		var packed_scene = ResourceLoader.load_threaded_get(Globals.next_scene)
		get_tree().change_scene_to_packed(packed_scene)
