extends Node2D
@onready var gpu_particles_2d = $GPUParticles2D


func _process(_delta):
	var canvas = get_canvas_transform()
	var top_left = -canvas.origin / canvas.get_scale()
	var size = get_viewport_rect().size / canvas.get_scale()
	
	gpu_particles_2d.global_position.x = top_left.x + size.x/2
	gpu_particles_2d.global_position.y = top_left.y - 50
	gpu_particles_2d.process_material.set_emission_box_extents(Vector3(size.x, 50, 1))
