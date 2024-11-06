extends State


func _ready():
	state_name = "Idle"

func enter(_msg := {}) -> void:
	owner.is_attacking = false
	owner.is_walking = false
	#owner.velocity = Vector2.ZERO

func physics_update(_delta: float) -> void:
	if owner.is_idle:
		owner.velocity = Vector2.ZERO
	if not owner.is_idle and not owner.is_walking:
		owner.is_walking = true
		state_machine.transition_to("Walk")
