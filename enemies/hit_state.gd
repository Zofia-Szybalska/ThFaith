extends State
class_name HitState

@export var damagable: Damageable 
@export var knockback_velocity = 200


func _ready():
	damagable.connect("on_hit", on_dameable_hit)

func enter(_msg := {}) -> void:
	damagable.can_be_damaged = false
	damagable.start_timer()

func on_dameable_hit(_node: Node, _damage: int, knockback_direction: Vector2):
	if knockback_velocity > 0:
		owner.velocity = knockback_direction * knockback_velocity

func physics_update(_delta: float) -> void:
	owner.velocity.x = lerp(owner.velocity.x, 0.0, 0.1)

func exit(_msg := {}) -> void:
	damagable.can_be_damaged = true
