extends MarginContainer

@onready var whole_map = $WholeMap

@export var max_zoom: Vector2 = Vector2(4, 4)
@export var zoom_speed: float = 1.1
@export var drag_sensitivity: float = 1

var zoom_factor = 1.1
var panning = false
var drag_start_position := Vector2()
@onready var curr_shown_world: TextureRect = whole_map


func _input(event):
	if event.is_action_pressed("pan_with_mouse"):
		panning = true
	elif event.is_action_released("pan_with_mouse"):
		panning = false 
	if event is InputEventMouseMotion and panning == true:
		var new_position = global_position + event.relative * drag_sensitivity / scale
		global_position = check_position(new_position)
		global_position += event.relative * drag_sensitivity / scale

func _unhandled_input(event):
	if event is InputEventMouse:
		if event.is_pressed() and not event.is_echo():
			var mouse_position = event.position
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				_zoom_at_point(zoom_speed, mouse_position)
			elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				_zoom_at_point(1 / zoom_speed, mouse_position)

func _process(_delta):
	whole_map.position.x = clamp(whole_map.position.x, -whole_map.size.x, 0)
	whole_map.position.y = clamp(whole_map.position.y, -whole_map.size.y, 0)

func check_position(new_position: Vector2):
	return new_position

func _ready():
	pass

func _zoom_at_point(zoom_change, mouse_position):
	var new_scale = scale * zoom_change
	if new_scale <= Vector2.ONE:
		return
	if new_scale >= max_zoom:
		return
	scale = new_scale
	var delta_x = (mouse_position.x - global_position.x) * (zoom_change - 1)
	var delta_y = (mouse_position.y - global_position.y) * (zoom_change - 1)
	global_position.x = global_position.x - delta_x
	global_position.y = global_position.y - delta_y

func _on_midgard_1_pressed():
	var point = PlayerVariables.fast_travel_points.get_point("Midgard1")
	if point:
		print("Znaleziono")
		get_tree().paused = false
		get_tree().change_scene_to_file("res://scenes/levels/"+point.scene_name+".tscn")

