extends Node

class_name Damageable
@onready var timer = $Timer

@export var health = 30
@export var char_state_machine: StateMachine
@export var knockback = 100
var can_be_damaged = true
signal on_hit(node: Node, damage_taken: int, knockback_direction: Vector2)

func _on_hit(damage: int, knockback_direction: Vector2):
	if can_be_damaged:
		print("Przeciwnik oberwał za: " + str(damage))
		can_be_damaged = false
		health -= damage
		if health <= 0:
			if get_parent().has_method("kill"):
				get_parent().kill()
				return
			get_parent().queue_free()
		if char_state_machine:
			char_state_machine.transition_to("Hit")
		on_hit.emit(get_parent(), damage, knockback_direction)
		if timer:
			timer.start()

func _on_timer_timeout():
	can_be_damaged = true
