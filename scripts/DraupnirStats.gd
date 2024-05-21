extends Resource
class_name DraupnirStats

@export var name: String
@export var cost: int = 1
@export_multiline var description: String
@export var icon: Texture2D
@export var locked_icon: Texture2D
@export var is_unlocked: bool = false
@export var effect: Script


func _init(p_name = "Defult", p_cost = 1, p_description = "Defult description", p_icon = Texture2D.new(), p_locked_icon = Texture2D.new(), p_is_unlocked = false, p_effect = null):
	name = p_name
	cost = p_cost
	description = p_description
	icon = p_icon
	locked_icon = p_locked_icon
	is_unlocked = p_is_unlocked
	effect = p_effect
