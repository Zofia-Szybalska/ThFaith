extends DraupnirEffect

func activate():
	PlayerVariables.change_enemy_nodes("change_detection_range", 400)

func deactivate():
	PlayerVariables.change_enemy_nodes("reset_detection_range")
