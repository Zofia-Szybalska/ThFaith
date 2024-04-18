extends Node

class_name Damageable

@export var health = 30
@export var char_state_machine: StateMachine
@export var knockback = 100
var can_be_damaged = true
signal on_hit(node: Node, damage_taken: int, knockback_direction: Vector2)

func _on_hit(damage: int, knockback_direction: Vector2):
	if can_be_damaged:
		can_be_damaged = false
		health -= damage
		if health <= 0:
			get_parent().queue_free()
		char_state_machine.transition_to("Hit")
		on_hit.emit(get_parent(), damage, knockback_direction)


