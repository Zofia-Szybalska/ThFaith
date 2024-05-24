extends RigidBody2D

@export var amount: int = 5
@onready var collision_shape_2d = $Area2D/CollisionShape2D
@export var base_area_radius: int = 15
@export var curr_area_radius: int = base_area_radius

func _ready():
	collision_shape_2d.shape.radius = PlayerVariables.coin_area_radius

func reset_area_radius():
	collision_shape_2d.shape.radius = base_area_radius
	curr_area_radius = base_area_radius
	PlayerVariables.coin_area_radius = base_area_radius

func change_area_radius(radius: int):
	collision_shape_2d.shape.radius = radius
	curr_area_radius = radius

func _on_body_entered(body):
	if body is Player:
		PlayerVariables.currency += amount
		queue_free()

func _on_area_2d_body_entered(body):
	if body is Player:
		PlayerVariables.currency += amount
		queue_free()
