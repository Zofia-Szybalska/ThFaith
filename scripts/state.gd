# Virtual base class for all states.
class_name State
extends Node

var state_machine = null


func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	owner.velocity.y += owner.gravity * delta

# Called by the state machine upon changing the active state.
# The `msg` parameter is a dictionary with arbitrary data the state can use to initialize itself.
func enter(_msg := {}) -> void:
	pass

func exit() -> void:
	pass
