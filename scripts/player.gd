extends CharacterBody2D

@export var SPEED : int = 150
@export var JUMP_FORCE : int = 255
@export var GRAVITY : int = 900

@onready var sprite = $Sprite2D

func _physics_process(delta):
	var direction = Input.get_axis("left","right")
	if direction:
		velocity.x = SPEED * direction
	else:
		velocity.x = 0
	
	#Direction
	if direction == 1:
		sprite.flip_h = false
	elif direction == -1:
		sprite.flip_h = true
	
	# Gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	
	# Jump
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			velocity.y -= JUMP_FORCE
	
	move_and_slide()
