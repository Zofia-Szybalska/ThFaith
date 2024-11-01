extends State


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process_update(delta):
	if owner is CharacterBody2D:
		owner.velocity.y += owner.gravity * delta
