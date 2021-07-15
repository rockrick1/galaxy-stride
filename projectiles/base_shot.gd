extends Node2D

onready var env_settings = preload("res://projectiles/enemy/glow_env.tres")

func _ready():
	var env = WorldEnvironment.new()
	env.set_environment(env_settings)
	add_child(env)

func _process(_delta):
	if $Sprite != null:
		$Sprite.set_modulate(Color(1.1,1.1,1.1,1))


func set_vars(pos, shooter, dir):
	position = pos
	for node in get_children():
		if "Projectile" in node.get_name():
			node.set_rotation(dir.angle())
			node.set_vars(shooter, dir, true)
