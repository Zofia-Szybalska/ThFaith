extends State
@onready var timer = $Timer
var times_turned = 0
var is_searching = false

func _ready():
	state_name = "Search"

func enter(_msg := {}) -> void:
	is_searching = true
	times_turned = 0
	owner.is_idle = true
	owner.is_walking = false
	timer.start()
	owner.velocity = Vector2.ZERO

func physics_update(_delta: float) -> void:
	owner.velocity = Vector2.ZERO
	if owner.player_detecting_ray_cast.is_colliding():
		state_machine.transition_to("Attack")
	if not owner.is_on_floor():
		state_machine.transition_to("Walk")

func exit(_msg := {}) -> void:
	is_searching = false
	owner.is_idle = false
	times_turned = 0

func _on_timer_timeout():
	if not is_searching:
		return
	times_turned += 1
	if times_turned < 4:
		owner.change_direction()
		timer.start()
	else:
		state_machine.transition_to("Walk")
