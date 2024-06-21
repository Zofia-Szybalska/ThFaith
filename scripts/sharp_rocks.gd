extends Area2D

var player = null

func _on_body_entered(body):
	if body is Player:
		player = body
		body.hit(1, self)

func _process(delta):
	if player:
		player.hit(1, self)

func _on_body_exited(body):
	if body is Player:
		player = null
