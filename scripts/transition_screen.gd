extends CanvasLayer

signal transition_finished
@onready var color_rect = $ColorRect
@onready var animation_player = $AnimationPlayer

func _ready():
	color_rect.visible = false

func transition_to_black():
	animation_player.play("fade_to_black")

func transition_from_black():
	animation_player.play("fade_from_black")

func _on_animation_player_animation_finished(_anim_name):
	transition_finished.emit()
