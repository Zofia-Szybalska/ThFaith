extends CharacterBody2D

@export var speed : int = 200
@export var jump_force : int = 175
@export var gravity : int = 900
@export var dash_speed : int = 500

@onready var sprite = $Sprite2D

@onready var fsm := $StateMachine

@onready var state_label = $StateLabel
@onready var ray_cast_2d = $RayCast2D

var can_double_jump: bool = true
var can_dash: bool = true
var direction = 1


func _physics_process(_delta):
	direction = Input.get_axis("left", "right")
	if direction == 1:
		sprite.flip_h = false
		ray_cast_2d.target_position *= direction
	elif direction == -1:
		sprite.flip_h = true
		ray_cast_2d.target_position *= direction
	move_and_slide()
