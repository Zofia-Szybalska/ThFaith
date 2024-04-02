extends CharacterBody2D

@export var speed : int = 200
@export var jump_force : int = 175
@export var gravity : int = 900
@export var dash_speed : int = 500
@export var wall_jump_pushback : int = 500

@onready var sprite = $Sprite2D

@onready var fsm := $StateMachine

@onready var state_label = $StateLabel

var can_double_jump: bool = true
var can_dash: bool = true
var direction = 1


func _physics_process(_delta):
	direction = Input.get_axis("left", "right")
	if direction == 1:
		sprite.flip_h = false
	elif direction == -1:
		sprite.flip_h = true
	move_and_slide()
