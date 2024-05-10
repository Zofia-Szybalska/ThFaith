extends MarginContainer

#@onready var midgard_area: Area2D = $WholeMap/MidgardArea
@onready var whole_map = $WholeMap
@onready var midgard_map = %MidgardMap
@onready var yggdrasil_map = $YggdrasilMap
@onready var helheim_map = $HelheimMap
@onready var alfheim_map = $AlfheimMap
@onready var vanaheim_map = $VanaheimMap
@onready var asgard_map = $AsgardMap
@onready var yotunheim_map = $YotunheimMap
@onready var muspelheim_map = $MuspelheimMap
@onready var svartalheim_map = $SvartalheimMap
@onready var nilfheim_map = $NilfheimMap

@export var max_zoom: Vector2 = Vector2(4, 4)
@export var zoom_speed: float = 1.1
@export var drag_sensitivity: float = 1

var zoom_factor = 1.1
var panning = false
var curr_world: worlds = worlds.WHOLE
@onready var curr_shown_world: TextureRect = whole_map
var nested_map = false
enum worlds {WHOLE, MIDGARD, YGGDRASIL, HELHEIM, ALFHEIM, VANAHEIM, ASGARD, YOTUNHEIM, MUSPELHEIM, SVARTALHEIM, NILFHEIM}


func _unhandled_input(event):
	if event is InputEventMouse:
		if event.is_pressed() and not event.is_echo():
			var mouse_position = event.position
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				_zoom_at_point(zoom_speed, mouse_position)
			elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				_zoom_at_point(1 / zoom_speed, mouse_position)
	if event.is_action_pressed("pan_with_mouse"):
		panning = true
	elif event.is_action_released("pan_with_mouse"):
		panning = false
	if event is InputEventMouseMotion and panning == true:
		var new_position = global_position + event.relative * drag_sensitivity / scale
		global_position = check_position(new_position)
		#global_position += event.relative * drag_sensitivity / scale

func check_position(new_position: Vector2):
	return new_position

func _ready():
	print("Rozmiar: " + str(size))

func _zoom_at_point(zoom_change, mouse_position):
	var new_scale = scale * zoom_change
	if new_scale <= Vector2.ONE:
		if nested_map:
			nested_map = false
			show_world()
		return
	if new_scale >= max_zoom:
		if not nested_map and not curr_world == worlds.WHOLE:
			nested_map = true
			show_world()
		return
	scale = new_scale
	var delta_x = (mouse_position.x - global_position.x) * (zoom_change - 1)
	var delta_y = (mouse_position.y - global_position.y) * (zoom_change - 1)
	global_position.x = global_position.x - delta_x
	global_position.y = global_position.y - delta_y

func show_world():
	scale = Vector2.ONE
	print("Zmiana na " + str(curr_world))
	curr_shown_world.hide()
	global_position = Vector2.ZERO
	match curr_world:
		worlds.WHOLE:
			whole_map.show()
			curr_shown_world = whole_map
			return
		worlds.MIDGARD:
			midgard_map.show()
			curr_shown_world = midgard_map
		worlds.YGGDRASIL:
			yggdrasil_map.show()
			curr_shown_world = yggdrasil_map
		worlds.HELHEIM:
			helheim_map.show()
			curr_shown_world = helheim_map
		worlds.ALFHEIM:
			alfheim_map.show()
			curr_shown_world = alfheim_map
		worlds.VANAHEIM:
			vanaheim_map.show()
			curr_shown_world = vanaheim_map
		worlds.ASGARD:
			asgard_map.show()
			curr_shown_world = asgard_map
		worlds.YOTUNHEIM:
			yotunheim_map.show()
			curr_shown_world = yotunheim_map
		worlds.MUSPELHEIM:
			muspelheim_map.show()
			curr_shown_world = muspelheim_map
		worlds.SVARTALHEIM:
			svartalheim_map.show()
			curr_shown_world = svartalheim_map
		worlds.NILFHEIM:
			nilfheim_map.show()
			curr_shown_world = nilfheim_map
	curr_world = worlds.WHOLE

func _on_midgard_mouse_entered():
	curr_world = worlds.MIDGARD
	print("Midgard")

func _on_world_mouse_exited():
	curr_world = worlds.WHOLE
	print("Poza światami")

func _on_yggdrasil_area_mouse_entered():
	curr_world = worlds.YGGDRASIL
	print("Yggdrasil")

func _on_helheim_area_mouse_entered():
	curr_world = worlds.HELHEIM
	print("Helheim")

func _on_alfheim_area_mouse_entered():
	curr_world = worlds.ALFHEIM
	print("Alfheim")

func _on_vanaheim_area_mouse_entered():
	curr_world = worlds.VANAHEIM
	print("Vanaheim")

func _on_asgard_area_mouse_entered():
	curr_world = worlds.ASGARD
	print("Asgard")

func _on_yotunheim_area_mouse_entered():
	curr_world = worlds.YOTUNHEIM
	print("Yotunheim")

func _on_svartalheim_area_mouse_entered():
	curr_world = worlds.SVARTALHEIM
	print("Svartalheim")

func _on_nilfheim_area_mouse_entered():
	curr_world = worlds.NILFHEIM
	print("Nilfheim")

func _on_muspelheim_area_mouse_entered():
	curr_world = worlds.MUSPELHEIM
	print("Muspelheim")

func _on_midgard_1_pressed():
	get_tree().paused = false
	var point = FastTravelPoints.get_point("Midgard1")
	get_tree().change_scene_to_file("res://scenes/levels/"+point.scene_name+".tscn")
