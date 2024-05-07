extends VBoxContainer

@onready var icon = $Icon
@onready var draupnir_name = $Name
@onready var description = $Description
@onready var locked_icon  = preload("res://icon.svg")
@export var locked_name: String = "Locked"
@export var locked_description: String = "It's not unlocked yet"

func load_draupnir(draupnir_resource: DraupnirStats):
	if draupnir_resource.is_unlocked:
		icon = draupnir_resource.icon
		draupnir_name.text = draupnir_resource.name
		description.text = draupnir_resource.description
	else:
		icon = locked_icon
		draupnir_name.text = locked_name
		description.text = locked_description
