extends MarginContainer

@onready var texture_rect = $TextureRect

@export var max_zoom: Vector2 = Vector2(4, 4)
@export var zoom_speed: float = 1.1
@export var drag_sensitivity: float = 1

var zoom_factor = 1.1

func _unhandled_input(event):
	if event is InputEventMouse:
		if event.is_pressed() and not event.is_echo():
			var mouse_position = event.position
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				_zoom_at_point(zoom_speed, mouse_position)
			elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				_zoom_at_point(1 / zoom_speed, mouse_position)


func _zoom_at_point(zoom_change, mouse_position):
	var new_scale = scale * zoom_change
	if new_scale <= Vector2.ONE or new_scale >= max_zoom:
		return
	scale = new_scale
	var delta_x = (mouse_position.x - global_position.x) * (zoom_change - 1)
	var delta_y = (mouse_position.y - global_position.y) * (zoom_change - 1)
	global_position.x = global_position.x - delta_x
	global_position.y = global_position.y - delta_y
