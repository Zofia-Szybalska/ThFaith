extends CharacterBody2D

@export var speed : int = 200
@export var jump_force : int = 600
@export var gravity : int = 900
@export var dash_speed : int = 500
@export var wall_jump_pushback : int = 500
@export var knockack_velocity: int = 300
@export var UI: CanvasLayer

@onready var fsm := $StateMachine
@onready var sword = $Sword
@onready var state_label = $StateLabel
@onready var animation_player = $AnimationPlayer

var can_double_jump: bool = true
var can_dash: bool = true
var can_be_damaged: bool = true
var direction = 1

func _unhandled_input(event):
	if event.is_action_pressed("inventory"):
		get_viewport().set_input_as_handled()
		UI.show_inventory()

func _ready():
	if FastTravelPoints.curr_fast_travel_point:
		global_position = FastTravelPoints.curr_fast_travel_point.position
		#$Camera2D.offset = Vector2.ZERO

func _physics_process(_delta):
	direction = Input.get_axis("left", "right")
	if direction == 1:
		sword.position = sword.right_pos
	elif direction == -1:
		sword.position = sword.left_pos
	move_and_slide()
	if Input.is_action_just_pressed("test_hit"):
		change_health(-1)
	if Input.is_action_just_pressed("test_heal"):
		change_health(1)

func hit(damage: int, node: Node2D):
	if can_be_damaged:
		can_be_damaged = false
		var knockback_direction = global_position - node.global_position
		var  knockback_direction_sign = sign(knockback_direction)
		$StateMachine.transition_to("Hit", {direction_sign = knockback_direction_sign})
		change_health(-damage)

func heal(amount: int):
	change_health(amount)

func change_health(amount: int):
	PlayerVariables.health = clamp(PlayerVariables.health + amount, 0, PlayerVariables.max_health)
