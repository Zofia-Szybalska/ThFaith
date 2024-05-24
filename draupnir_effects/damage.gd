extends DraupnirEffect

func activate():
	PlayerVariables.damage_multiplayer = 3
	PlayerVariables.damage_taken_multiplayer = 3

func deactivate():
	PlayerVariables.damage_multiplayer = 1
	PlayerVariables.damage_taken_multiplayer = 1
