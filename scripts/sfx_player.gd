extends Node


func play(sfx_name):
	match sfx_name:
		"CharDrop":
			var pitch = 0.95 + (randf() / 10)
			$CharDrop.set_pitch_scale(pitch)
		"EnemyDeath":
			var pitch = 0.75 + (randf() / 2)
			$EnemyDeath.set_pitch_scale(pitch)
	get_node(sfx_name).play()
