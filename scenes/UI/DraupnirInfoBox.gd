extends VBoxContainer

@onready var icon = $Icon
@onready var draupnir_name = $Name
@onready var description = $Description
@onready var locked_icon  = preload("res://icon.svg")
@export var locked_name: String = "Locked"
@export var locked_description: String = "It's not unlocked yet"
@onready var cost = $Cost

func load_draupnir(draupnir_resource: DraupnirStats):
	if draupnir_resource.is_unlocked:
		icon.texture = draupnir_resource.icon
		icon.modulate = Color.WHITE
		draupnir_name.text = draupnir_resource.name
		description.text = draupnir_resource.description
		cost.text = "Koszt: " + str(draupnir_resource.cost)
	else:
		icon.texture = locked_icon
		icon.modulate = Color(0.431, 0.431, 0.431, 0.937)
		draupnir_name.text = locked_name
		description.text = locked_description
		cost.text = "Koszt: " + "???"
