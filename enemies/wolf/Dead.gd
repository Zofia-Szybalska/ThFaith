extends State


func _ready():
	state_name = "Dead"

func enter(_msg := {}) -> void:
	owner.can_change_direction = false
	owner.velocity = Vector2.ZERO

