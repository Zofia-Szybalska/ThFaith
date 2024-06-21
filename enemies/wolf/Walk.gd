extends State

@onready var animation_player = $"../../AnimationPlayer"

func enter(_msg := {}) -> void:
	if owner.walk_direction == 1:
		animation_player.play("walk_right")
	else: 
		animation_player.play("walk_left")
	owner.velocity = Vector2.ZERO

func physics_update(delta: float) -> void:
	if owner.walk_direction == 1:
		animation_player.play("walk_right")
	else: 
		animation_player.play("walk_left")
	if owner.player_detecting_ray_cast.is_colliding():
		owner.player = owner.player_detecting_ray_cast.get_collider()
		state_machine.transition_to("Attack")
		owner.velocity.x = 0
		return
	if not owner.is_on_floor():
		owner.velocity.y += owner.gravity * delta
	owner.velocity.x = owner.walk_direction * owner.speed
