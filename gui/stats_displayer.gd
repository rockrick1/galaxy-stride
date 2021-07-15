extends MarginContainer


func update_bullets(n_bullets):
	$Stats/a.set_text("bullets on screen: "+str(n_bullets))


func update_wave(wave):
	$Stats/b.set_text("wave: "+str(wave))


func _process(delta):
	$Stats/c.set_text("fps: "+str(Engine.get_frames_per_second()))


func update_lives(lives):
	$Stats/d2.set_text("lives: "+str(lives))


func update_diff(acc_diff, overall_diff):
	$Stats/e.set_text("acc diff: "+str(acc_diff))
	$Stats/f.set_text("overall diff: "+str(floor(overall_diff)))


func update_hit_free_time(time):
	$Stats/d.set_text("time without hits: "+str(time))


func update_power(power):
	$Stats/g.set_text("power: "+str(power))


func set_debug_1(msg):
	$Stats/h.set_text(str(msg))


func update_bars(character):
	$Stats/LivesBar.set_max(character.LIFE_CHARGE_MAX)
	$Stats/PowerBar.set_max(character.POWER_MAX)
	$Stats/BombsBar.set_max(character.BOMB_CHARGE_MAX)

	$Stats/LivesBar.value = character.LIFE_CHARGE
	$Stats/LivesLabel.set_text('Lives: '+str(character.LIVES))

	$Stats/PowerBar.value = character.POWER
	$Stats/PowerLabel.set_text('Power: '+str(character.shot_lv))

	$Stats/BombsBar.value = character.BOMB_CHARGE
	$Stats/BombsLabel.set_text('Bombs: '+str(character.BOMBS))
