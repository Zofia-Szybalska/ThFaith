extends DraupnirEffect

func activate():
	PlayerVariables.currency_dropped_multiplayer = 1.5

func deactivate():
	PlayerVariables.currency_dropped_multiplayer = 1.0
