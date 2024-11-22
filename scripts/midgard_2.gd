extends Node2D
@export var saver_loader: SaverLoader

func _ready():
	PlayerVariables.current_scene = "Midgard2"
	PlayerVariables.current_scene_path = scene_file_path
	if saver_loader:
		saver_loader.auto_save()
