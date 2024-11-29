extends MarginContainer
@onready var button = $PanelContainer/MapMenu/WholeMap/Midgard1


func assaign_focus():
	if button:
		button.grab_focus()
