extends DraupnirEffect

func activate():
	PlayerVariables.change_coin_nodes("change_area_radius", 100)

func deactivate():
	PlayerVariables.change_coin_nodes("reset_area_radius")
