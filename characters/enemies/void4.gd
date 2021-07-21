extends "enemy.gd"


# for the love of god please do not connect the BossMove tween on the
# _on_Move_tween_all_completed() of the base enemy script

const num_explosions : int = 20
var exploded : int = 0
const explosion_interval : float = 0.15


const move_pos = [
	48, # 7.5
	0,  # 15
	-48,# 22.5
	48, # 30
	0,  # 37.5
	0,  # 45
	0,  # 45
	0,  # 45
	0,  # 45
	0,  # 45
	0,  # 45
]

const move_interval = 7.5
const move_time = 1
var current_pos_id = 0

func _ready():
	$ExplosionInterval.wait_time = explosion_interval
	$MoveTimer.wait_time = move_interval

func move():
	current_pos_id += 1
	if current_pos_id >= len(move_pos):
		current_pos_id = 0
	var current_pos = move_pos[current_pos_id]
	
	$BossMove.interpolate_property(self, "position:x",
		self.position.x,
		current_pos,
		move_time,
		Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	$BossMove.start()


func die(spawn_drops : bool):
	if is_dead:
		return
	_on_ExplosionInterval_timeout()
	$ExplosionInterval.start()
	$BossMove.stop_all()
	$MoveTimer.stop()
	$Hitbox.queue_free()
	is_dead = true
	kill_generators()
	SfxPlayer.play_music_anim("MusicBoss", "fade_out")
#	.die(spawn_drops)


func _on_MoveTimer_timeout():
	move()


# will spawn explosion 'num_explosions' with the
# 'explosion_interval' interval, then stop
func _on_ExplosionInterval_timeout():
	exploded += 1
	# generates random position for explosion
	var offset = Vector2((randi() % 40) - 20,(randi() % 80) - 40)
	var scale = Vector2(.5,.5)
	if exploded == num_explosions:
		offset = Vector2.ZERO
		scale = Vector2(1.6,1.6)
	# spawns explosion, with sound
	spawn_explosion(offset, scale, true)
	if exploded >= num_explosions:
		$ExplosionInterval.stop()
		spawn_drops()
		queue_free()
