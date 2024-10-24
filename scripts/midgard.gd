extends Node2D

func _ready():
	TransitionScreen.transition_from_black()
	TransitionScreen.transition_finished.connect(_on_trnsition_ended)

func _on_trnsition_ended():
	pass
