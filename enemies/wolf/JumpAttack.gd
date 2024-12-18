extends State
@onready var jump_start_timer = $JumpStartTimer
@onready var jump_timer = $JumpTimer
@export var attack_distance: int = 50
var is_in_the_air:bool = false
var landed:bool = false
var distance

func _ready():
	state_name = "JumpAttack"

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	if landed and owner.player:
		var player_position = owner.player.position
		var direction = player_position - owner.position
		distance = direction.length()
		direction = direction.normalized()
	if is_in_the_air:
		owner.velocity.x = owner.walk_direction * owner.speed * 5
	else:
		owner.velocity.x = 0

func enter(_msg := {}) -> void:
	owner.is_jump_attacking = true
	jump_start_timer.start()

func exit() -> void:
	owner.is_jump_attacking = false

func attack():
	if distance <= attack_distance:
		owner.hit_player()

func _on_anim_end():
	state_machine.transition_to("Attack")

func _on_jump_start_timer_timeout():
	is_in_the_air = true
	jump_timer.start()

func _on_jump_timer_timeout():
	landed = true
	is_in_the_air = false
