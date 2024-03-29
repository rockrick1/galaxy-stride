extends Node2D

const drop1 = preload("res://drops/drop1.tscn")

var stage
var num_drops
var spawned_drops
var auto_follow : bool = false

func _ready():
	$Timer.wait_time = .5 / num_drops

func spawn_drop():
	var instance
	if spawned_drops < num_drops:
		instance = drop1.instance()
		var offset = Vector2(randf() - .5,randf() - .8).normalized() * 20
		instance.spawn_offset = offset
		instance.global_position = self.get_global_position()
		instance.follow = auto_follow
		stage.get_node("Drops").add_child(instance)
		spawned_drops += 1
	else:
		queue_free()


func _on_Timer_timeout():
	spawn_drop()
