extends CharacterBody2D

@onready var ground_detecting_ray_cast: RayCast2D = $GroundDetectingRayCast
@onready var player_detecting_ray_cast = $PlayerDetectingRayCast
@onready var state_machine = $StateMachine
@onready var direction_change_timer = $DirectionChangeTimer

@export var speed = 150.0
@export var max_health = 30.0

var health = max_health:  set = _set_health
var player
var can_change_direction: bool = true
var player_in_area

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var walk_direction = -1

func _set_health(value):
	health = value
	if health <= 0:
		kill()

func kill():
	queue_free()

func take_demage():
	health -= 10.0

func _physics_process(_delta):
	if player_in_area:
		player_in_area.hit(1, self)
	if !ground_detecting_ray_cast.is_colliding() and not state_machine.state.name == "Attack":
		change_direction()
	if is_on_wall() and is_on_floor() and not state_machine.state.name == "Attack":
		change_direction()
	if walk_direction == 1:
		pass
	else:
		pass
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
