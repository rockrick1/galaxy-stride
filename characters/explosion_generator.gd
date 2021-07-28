extends Node2D


export (int) var num_explosions = 20
export (float) var explosion_interval = 0.15
export (int) var explosion_range_x
export (int) var explosion_range_y
export (bool) var last_explosion_centered
export (Vector2) var explosion_scale = Vector2(1,1)
export (Vector2) var last_explosion_scale = Vector2(1,1)

const explosion_scene = preload("res://characters/explosion.tscn")

var exploded : int = 0
var parent : Node
var stage : Node

signal finished


func start():
	parent = get_parent()
	stage = parent.stage
	connect("finished", parent, "_on_ExplosionGenerator_finished")
	$Interval.wait_time = explosion_interval
	_on_Interval_timeout()
	$Interval.start()


func spawn_explosion(offset = Vector2(0, 0), scale = Vector2(1, 1), play_sound = false):
	var ex = explosion_scene.instance()
	ex.global_position = parent.global_position + offset
	ex.scale = scale
	stage.add_child_below_node(parent, ex)
	if play_sound:
		SfxPlayer.play("EnemyDeath")


# will spawn explosion 'num_explosions' times with the
# 'explosion_interval' interval, then stop
func _on_Interval_timeout():
	exploded += 1
	# generates random position for explosion
	var offset
	var scale
	if exploded == num_explosions and last_explosion_centered:
		offset = Vector2.ZERO
		scale = last_explosion_scale
	elif explosion_range_x == 0 and explosion_range_y == 0:
		offset = Vector2.ZERO
		scale = explosion_scale
	else:
		offset = Vector2((randi() % explosion_range_x) - (explosion_range_x/2),(randi() % explosion_range_y) - (explosion_range_y/2))
		scale = explosion_scale
	# spawns explosion, with sound
	spawn_explosion(offset, scale, true)
	if exploded >= num_explosions:
		exploded = 0
		$Interval.stop()
		emit_signal("finished")
