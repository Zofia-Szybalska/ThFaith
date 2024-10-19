extends CharacterBody2D
class_name Player


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
@onready var animation_tree = $AnimationTree

var can_double_jump: bool = true
var can_dash: bool = true
var can_be_damaged: bool = true: 
	set(new_value):
		can_be_damaged = new_value
		$PartsSKeletonContainer/Parts.material.set_shader_parameter("hurt", !can_be_damaged)
var direction = -1
var sword_direction = -1
var is_idle = false
var is_running = false
var is_attacking = false
var is_jumping = false
var is_dashing = false
var is_falling = false
var is_dead = false

func update_animation_parameters():
	animation_tree["parameters/conditions/is_idle"] = is_idle
	animation_tree["parameters/conditions/is_jumping"] = is_jumping
	animation_tree["parameters/conditions/is_dashing"] = is_dashing
	animation_tree["parameters/conditions/is_falling"] = is_falling
	animation_tree["parameters/conditions/is_running"] = is_running
	animation_tree["parameters/conditions/is_dead"] = is_dead
	animation_tree["parameters/conditions/is_attacking"] = is_attacking
	
	#if is_attacking:
		#animation_tree["parameters/Idle/Blend idle attack/blend_amount"] = 1
		#animation_tree["parameters/Run/Blend run attack/blend_amount"] = 1
		#animation_tree["parameters/Dash/Blend dash attack/blend_amount"] = 1
		#animation_tree["parameters/Fall/Blend2/blend_amount"] = 1
		#animation_tree["parameters/Jump/Blend jump attack/blend_amount"] = 1
		#animation_tree["parameters/Idle/BlendSpace1D/blend_position"] = 1
		#animation_tree["parameters/Idle/Add2/add_amount"] = 1
	#else:
		#animation_tree["parameters/Idle/Blend idle attack/blend_amount"] = 0
		#animation_tree["parameters/Run/Blend run attack/blend_amount"] = 0
		#animation_tree["parameters/Dash/Blend dash attack/blend_amount"] = 0
		#animation_tree["parameters/Fall/Blend2/blend_amount"] = 0
		#animation_tree["parameters/Jump/Blend jump attack/blend_amount"] = 0
		#animation_tree["parameters/Idle/BlendSpace1D/blend_position"] = 0
		#animation_tree["parameters/Idle/Add2/add_amount"] = 0
	
	if not direction == 0:
		animation_tree["parameters/Idle/Blend attack/blend_position"] = direction
		animation_tree["parameters/Idle/Blend idle/blend_position"] = direction
		animation_tree["parameters/Run/Blend attack/blend_position"] = direction
		animation_tree["parameters/Run/Blend run/blend_position"] = direction
		animation_tree["parameters/Dash/blend attack/blend_position"] = direction
		animation_tree["parameters/Dash/blend dash/blend_position"] = direction
		animation_tree["parameters/Fall/blend attack/blend_position"] = direction
		animation_tree["parameters/Fall/blend fall/blend_position"] = direction
		animation_tree["parameters/Jump/blend attack/blend_position"] = direction
		animation_tree["parameters/Jump/blend jump/blend_position"] = direction
		animation_tree["parameters/Attack/blend_position"] = direction
		animation_tree["parameters/Death/blend_position"] = direction

func _unhandled_input(event):
	if event.is_action_pressed("inventory"):
		get_viewport().set_input_as_handled()
		UI.show_inventory()

func _ready():
	can_be_damaged = true
	if PlayerVariables.player_spawn_pos != Vector2.ZERO:
		position = PlayerVariables.player_spawn_pos
	PlayerVariables.player = self
	if PlayerVariables.fast_travel_points.curr_fast_travel_point:
		global_position = PlayerVariables.fast_travel_points.curr_fast_travel_point.position

func _process(_delta):
	if PlayerVariables.health == 0:
		dead()
	update_animation_parameters()

func _physics_process(_delta):
	direction = Input.get_axis("left", "right")
	if direction == 1:
		sword.position = sword.right_pos
		sword_direction = 1
	elif direction == -1:
		sword.position = sword.left_pos
		sword_direction = -1
	move_and_slide()
	if Input.is_action_just_pressed("test_hit"):
		change_health(-1)
	if Input.is_action_just_pressed("test_heal"):
		change_health(1)

func change_sword_size(amount: int = 0):
	sword.change_sword_length(amount)

func reset_sword_size():
	sword.reset_sword_length()

func hit(damage: int, node: Node2D):
	if can_be_damaged:
		var random = RandomNumberGenerator.new()
		random.randomize()
		if random.randf_range(0, 1.0) < PlayerVariables.dodge_chance:
			dodge()
			return
		can_be_damaged = false
		var knockback_direction = global_position - node.global_position
		var  knockback_direction_sign = sign(knockback_direction)
		$StateMachine.transition_to("Hit", {direction_sign = knockback_direction_sign})
		change_health(-damage * PlayerVariables.damage_taken_multiplayer)

func dodge():
	print("Dodged!")

func heal(amount: int):
	change_health(amount)

func change_health(amount: int):
	PlayerVariables.health = clamp(PlayerVariables.health + amount, 0, PlayerVariables.max_health)

func dead():
	can_be_damaged = false
	is_dead = true
	is_idle = false
	is_running = false
	is_attacking = false
	is_jumping = false
	is_dashing = false
	is_falling = false
