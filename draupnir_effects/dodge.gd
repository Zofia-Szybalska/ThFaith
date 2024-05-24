extends DraupnirEffect

func activate():
	PlayerVariables.dodge_chance = 0.15

func deactivate():
	PlayerVariables.dodge_chance = 0.0
