extends "enemy.gd"


# for the love of god please do not connect the BossMove tween on the
# _on_Move_tween_all_completed() of the base enemy script

const num_explosions : int = 15
var exploded : int = 0
const explosion_interval : float = 0.3


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


func death_anim():
	_on_ExplosionInterval_timeout()
	$ExplosionInterval.start()


func _on_MoveTimer_timeout():
	move()


# will spawn explosion 'num_explosions' with the
# 'explosion_interval' interval, then stop
func _on_ExplosionInterval_timeout():
	spawn_explosion(Vector2((randi() % 30) - 15,(randi() % 30) - 15))
	exploded += 1
	if exploded >= num_explosions:
		$ExplosionInterval.stop()
