extends State

@onready var charge_preparation_timer = $ChargePreparationTimer
@onready var charge_timer = $ChargeTimer
@onready var attac_buffer = $AttacBuffer
var direction
var charging_anticipation: bool = false
var charging: bool = false
var can_attack: bool = true
var on_edge: bool = false
@export var charge_distance: int = 200 
@export var charge_end_distance: int = 125
@export var attack_distance: int = 25
@export var to_close_distance: int = 5
@onready var animation_player = $"../../AnimationPlayer"
var player_in_range: bool = false


func _ready():
	state_name = "Attack"

func enter(_msg := {}) -> void:
	player_in_range = true
	owner.is_walking = true

func physics_update(delta: float) -> void:
	if owner.is_idle:
		state_machine.transition_to("Idle")
	if can_attack:
		if direction and direction.x > 0:
			owner.is_attacking = false
			owner.is_walking = true
	if not owner.is_on_floor():
		owner.velocity.y += owner.gravity * delta
	if not owner.player_detecting_ray_cast.is_colliding():
		set_player_to_null()
	if !owner.ground_detecting_ray_cast.is_colliding():
		on_edge = true
	else:
		on_edge = false
	if charging_anticipation:
		owner.velocity.x = -direction.x * owner.speed * 0.2
		owner.move_and_slide()
		return
	if charging:
		owner.velocity.x = direction.x * owner.speed
		owner.move_and_slide()
		return
	
	if owner.player != null and player_in_range:
		var player_position = owner.player.position
		direction = player_position - owner.position
		var distance = direction.length()
		direction = direction.normalized()
		if charging and distance <= attack_distance:
			charging = false
		if distance > charge_distance or ((distance <= charge_end_distance and distance > attack_distance) and not charging):
			owner.velocity.x = direction.x * owner.speed
		
		if (distance <= charge_distance and distance > charge_end_distance) and not charging:
			charge()
		
		if distance <= attack_distance and not charging and distance > to_close_distance:
			owner.velocity.x = Vector2.ZERO.x
			if can_attack:
				attack()
		
		if distance <= to_close_distance:
			owner.velocity.x = -direction.x * owner.speed * 0.8
		if on_edge and owner.is_on_floor():
			owner.velocity = Vector2.ZERO
		owner.move_and_slide()
	else:
		state_machine.transition_to("Search")

func charge():
	owner.is_attacking = false
	owner.is_walking = true
	charging_anticipation = true
	owner.animation_tree["parameters/Walk/TimeScale/scale"] = -0.8
	owner.velocity.x = -direction.x * owner.speed * 0.2
	charge_preparation_timer.start()

func attack():
	owner.is_attacking = true
	owner.is_walking = false
	can_attack = false
	#owner.player.hit(1, owner)
	attac_buffer.start()

func try_attacking():
	if owner.player != null and player_in_range:
		var distance = (owner.player.position - owner.position).length()
		if distance <= 100 and can_attack:
			attack()

func set_player_to_null():
	player_in_range = false
	#owner.player = null

func _on_charge_preparation_timer_timeout():
	owner.animation_tree["parameters/Walk/TimeScale/scale"] = 2
	owner.velocity.x = direction.x * owner.speed * 5
	charging_anticipation = false
	charging = true
	charge_timer.start()

func _on_charge_timer_timeout():
	owner.animation_tree["parameters/Walk/TimeScale/scale"] = 1
	charging = false
	try_attacking()

func _on_attac_buffer_timeout():
	#owner.is_attacking = false
	#owner.is_walking = true
	can_attack = true

func exit(_msg := {}) -> void:
	owner.animation_tree["parameters/Walk/TimeScale/scale"] = 1
	set_player_to_null()
	owner.is_walking = true
	owner.is_attacking = false
