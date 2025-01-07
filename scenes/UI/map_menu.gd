extends MarginContainer
@onready var button = %Midgard1


func assaign_focus():
	if button:
		button.grab_focus()
