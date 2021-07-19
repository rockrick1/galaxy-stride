extends Node


func play(sfx_name : String):
	match sfx_name:
		"CharDrop":
			var pitch = 0.95 + (randf() / 10)
			$CharDrop.set_pitch_scale(pitch)
		"EnemyDeath":
			var pitch = 0.75 + (randf() / 2)
			$EnemyDeath.set_pitch_scale(pitch)
	get_node(sfx_name).play()


func play_music(name : String):
	stop_music()
	print("name music ",name)
	get_node(name).play()


func stop_music():
	for node in get_children():
		if "Music" in node.name:
			node.stop()

func play_music_anim(name, anim_name : String):
	var node = get_node(name)
	if node.has_node("Animation"):
		node.get_node("Animation").play(anim_name)
