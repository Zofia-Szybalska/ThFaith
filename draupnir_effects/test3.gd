extends DraupnirEffect

func activate():
	PlayerVariables.player.change_sword_size(50)

func deactivate():
	PlayerVariables.player.reset_sword_size()
