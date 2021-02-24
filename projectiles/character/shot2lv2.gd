extends "../base_shot.gd"


func _ready():
	$Projectile.position.y -= 10
	for tween in $Tweens.get_children():
		var proj = get_node("Projectile"+tween.name)
		var offset = -12
		if "3" in tween.get_name():
			offset = 12
		tween.interpolate_property(proj, "position:x",
		proj.position.x,
		proj.position.x + offset,
		.1,
		Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
		tween.start()
