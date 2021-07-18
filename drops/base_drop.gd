extends Area2D


export (Vector2) var dir = Vector2(0,35)

var character
var follow = false
var spawn_offset : Vector2 = Vector2(0,0)
var spawning : bool = true

var color_mat

export (Color) var color_state = Color(0,0,0,0)


func _ready():
	character = MainNodes.get_character()
	color_mat = $Sprite.get_material()
	
	var tweenX = $SpawnMoveX
	var tweenY = $SpawnMoveY
	print("oieoieoeieoie ", spawn_offset)
	tweenX.interpolate_property(self, "position:x",
		position.x, position.x + spawn_offset.x, .15,
		Tween.TRANS_QUAD, Tween.EASE_OUT)
	tweenX.interpolate_property(self, "position:y",
		position.y, position.y + spawn_offset.y, .15,
		Tween.TRANS_QUAD, Tween.EASE_OUT)
	tweenX.start()
	tweenY.start()


func _process(delta):
	if spawning:
		return
	if follow:
		dir = -(get_global_position() - character.get_global_position()).normalized() * 170
	self.position += dir*delta
	if character.is_in_auto_zone:
		follow = true
	color_mat.set_shader_param("color_offset", color_state)


func die():
	queue_free()


func _on_Drop_body_shape_entered(body_id, body, body_shape, area_shape):
	# Collision with the sage border's bottom kills drop
	if area_shape == 1 and body.get_name() == "StageBorder" and body_shape == 3:
		die()
	# Collision of PlayerFollow and Character will move drop to character
	# and run pickup
	elif body.get_name() == "Character":
		# If it's the smaller one, the character picks the drop up
		if area_shape == 1:
			character.gain_drop()
			die()
		# If it's the bigger area entering the character, only follows
		follow = true


func _on_SpawnMoveX_tween_all_completed():
	spawning = false
	print("cabou")


func _on_SpawnMoveX_tween_completed(object, key):
	print(object,key)
