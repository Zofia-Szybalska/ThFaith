extends Resource
class_name DraupnirStats

@export var name: String
@export var cost: int = 1
@export_multiline var description: String
@export var icon: Texture2D
@export var locked_icon: Texture2D
@export var is_unlocked: bool = false
@export_file("*.gd")  var effect: String
@export var effect_script: GDScript
@export var HUD_icon: Texture2D

func activate():
	if effect and not effect_script:
		effect_script = load(effect).new()
	if effect_script:
		effect_script.activate()
	else:
		effect_script = DraupnirEffect.new()

func deactivate():
	if effect and not effect_script:
		effect_script = load(effect).new()
	if effect_script:
		effect_script.deactivate()
	else:
		effect_script = DraupnirEffect.new()

func _init(p_name = "Defult", p_cost = 1, p_description = "Defult description", p_icon = Texture2D.new(), p_locked_icon = Texture2D.new(), p_is_unlocked = false, p_effect_path: String = ""):
	name = p_name
	cost = p_cost
	description = p_description
	icon = p_icon
	locked_icon = p_locked_icon
	is_unlocked = p_is_unlocked
	#effect = p_effect_path
	effect = p_effect_path
