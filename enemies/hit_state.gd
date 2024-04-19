extends State
class_name HitState

@export var damagable: Damageable 
@export var knockback_velocity = 200


func _ready():
	damagable.connect("on_hit", on_dameable_hit)

func enter(_msg := {}) -> void:
	damagable.can_be_damaged = false
	$Timer.start()

func on_dameable_hit(_node: Node, damage: int, knockback_direction: Vector2):
	owner.velocity = knockback_direction * knockback_velocity
	print("Oberwał za " + str(damage))

func physics_update(_delta: float) -> void:
	owner.velocity.x = lerp(owner.velocity.x, 0.0, 0.1)

func _on_timer_timeout():
	damagable.can_be_damaged = true
	if owner.player_detecting_ray_cast.is_colliding():
		owner.player = owner.player_detecting_ray_cast.get_collider()
		state_machine.transition_to("Attack")
		owner.velocity.x = 0
		return
	else:
		state_machine.transition_to("Walk")

func exit(_msg := {}) -> void:
	damagable.can_be_damaged = true
