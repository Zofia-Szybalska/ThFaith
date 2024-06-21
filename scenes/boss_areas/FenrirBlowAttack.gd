extends State

@onready var animation_player = $"../../AnimationPlayer"
var attacking = false
var player_in_range = false
var player: Player = null

func enter(_msg := {}) -> void:
	animation_player.play("BlowAttack")
	attacking = true

func physics_update(_delta: float) -> void:
	if player_in_range:
		player.velocity -= Vector2(100,0)

func _on_area_2d_body_entered(body):
	if body is Player:
		player = body
		player_in_range = true
		body.velocity -= Vector2(200,0)


func _on_animation_player_animation_finished(_anim_name):
	if attacking:
		attacking = false
		state_machine.transition_to("Attack")



func _on_area_2d_body_exited(body):
		if body is Player:
			player_in_range = false
			body.velocity += Vector2(0,0)
