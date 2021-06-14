extends Node2D


func _draw():
	var icon = preload("res://assets/sprites/blop_blue1.png")
	for i in range(16):
		var angle = deg2rad( i * 360/16)
		var dir = Vector2(cos(angle), sin(angle))
		
		draw_set_transform(Vector2(200, 200), angle, Vector2(1, 1))
		draw_texture(icon, Vector2(20, 20))
