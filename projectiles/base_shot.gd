extends Node2D

var mod_set = false

func _process(_delta):
	if $Sprite != null and not mod_set:
		$Sprite.set_modulate(Color(1.3,1.3,1.3,1))
		mod_set = true


func set_vars(pos, shooter, dir):
	position = pos
	for node in get_children():
		if "Projectile" in node.get_name():
			node.set_rotation(dir.angle())
			node.set_vars(shooter, dir, true)
