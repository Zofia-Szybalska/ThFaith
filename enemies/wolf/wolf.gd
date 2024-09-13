extends CharacterBody2D

@onready var ground_detecting_ray_cast: RayCast2D = $GroundDetectingRayCast
@onready var player_detecting_ray_cast = $PlayerDetectingRayCast
@onready var state_machine = $StateMachine
@onready var direction_change_timer = $DirectionChangeTimer
@onready var animation_player = $AnimationPlayer
@onready var animation_tree = $AnimationTree

@export var speed = 150.0
@export var max_health = 30.0
@export var base_currency_dropped: int = 10
@export var base_detection_range: int = 600

var currency_scene: PackedScene = preload("res://scenes/currency.tscn")
var health = max_health:  set = _set_health
var player
var can_change_direction: bool = true
var player_in_area
var curr_detection_range: int = base_detection_range

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var walk_direction = -1
var is_walking = true
var is_attacking = false

func update_animation_parameters():
	animation_tree["parameters/conditions/is_attacking"] = is_attacking
	animation_tree["parameters/conditions/is_walking"] = is_walking
	animation_tree["parameters/Attack/blend_position"] = walk_direction
	animation_tree["parameters/Walk/blend_position"] = walk_direction

func update_enemy():
	pass

func _set_health(value):
	health = value
	if health <= 0:
		kill()

func change_detection_range(new_detection_range: int):
	player_detecting_ray_cast.target_position.y = new_detection_range * -walk_direction
	curr_detection_range = new_detection_range * -walk_direction

func reset_detection_range():
	player_detecting_ray_cast.target_position.y = base_detection_range * -walk_direction
	PlayerVariables.enemies_detection_range = base_detection_range

func kill():
	drop_currency()
	queue_free()

func drop_currency():
	var currency_instanced = currency_scene.instantiate()
	currency_instanced.amount = base_currency_dropped * PlayerVariables.currency_dropped_multiplayer
	get_parent().call_deferred("add_child", currency_instanced)
	currency_instanced.position = position

func take_demage():
	health -= 10.0

func _physics_process(_delta):
	update_animation_parameters()
	if player_in_area:
		player_in_area.hit(1, self)
	if !ground_detecting_ray_cast.is_colliding() and not state_machine.state.name == "Attack":
		change_direction()
	if is_on_wall() and is_on_floor() and not state_machine.state.name == "Attack":
		change_direction()
	move_and_slide()

func change_direction():
	if can_change_direction:
		direction_change_timer.start()
		can_change_direction = false
		walk_direction *= -1
		ground_detecting_ray_cast.position *= -1
		player_detecting_ray_cast.target_position *= -1

func _on_direction_change_timer_timeout():
	can_change_direction = true

func _on_area_2d_body_entered(body):
	player_in_area = body
	if body.has_method("hit"):
		body.hit(1, self)

func _on_area_2d_body_exited(_body):
	player_in_area = null
