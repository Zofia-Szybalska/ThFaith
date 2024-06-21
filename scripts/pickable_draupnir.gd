extends Area2D

@export var draupnir_resource: DraupnirStats
@onready var sprite_2d = $Sprite2D

func _ready():
	sprite_2d.texture = draupnir_resource.icon

func pick():
	PlayerVariables.draupnirs.unlock_draupnir(draupnir_resource.name)
	queue_free()

func _on_body_entered(_body):
	pick()
