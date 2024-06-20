extends Node
class_name SaverLoader

func save_game():
	var saved_game := SaveGame.new()
	
	saved_game.draupnirs = PlayerVariables.draupnirs
	saved_game.fast_travel_points = PlayerVariables.fast_travel_points
	saved_game.abilities = PlayerVariables.abilities
	saved_game.level_path = PlayerVariables.current_scene_path
	saved_game.currency = PlayerVariables.currency
	saved_game.last_camp_position = PlayerVariables.player.position
	
	ResourceSaver.save(saved_game, "user://savegame.tres")

func load_game(saved_game: SaveGame):
	if saved_game == null:
		return
	PlayerVariables.player_spawn_pos = saved_game.last_camp_position
	PlayerVariables.currency = saved_game.currency
	PlayerVariables.draupnirs = saved_game.draupnirs
	PlayerVariables.fast_travel_points = saved_game.fast_travel_points
	PlayerVariables.abilities = saved_game.abilities
	PlayerVariables.current_scene_path = saved_game.level_path
	get_tree().paused = false
	var error = get_tree().change_scene_to_file(saved_game.level_path)
	print(error)
