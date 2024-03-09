extends CharacterBody2D

@export var speed : int = 200
@export var jump_force : int = 200
@export var gravity : int = 900

@onready var sprite = $Sprite2D

@onready var fsm := $StateMachine

func _physics_process(_delta):
	var direction = Input.get_axis("left", "right")
	if direction == 1:
		sprite.flip_h = false
	elif direction == -1:
		sprite.flip_h = true
	move_and_slide()
