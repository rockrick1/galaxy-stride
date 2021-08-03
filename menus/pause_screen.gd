extends MarginContainer

var paused : bool = false


func _ready():
	hide()


func _process(event):
	if Input.is_action_just_pressed("ui_esc"):
		toggle_pause()


func pause():
	show()
	paused = true
	get_tree().set_pause(true)


func unpause():
	hide()
	paused = false
	get_tree().set_pause(false)


func toggle_pause():
	paused = not paused
	visible = paused
	get_tree().set_pause(paused)


func _on_Continue_pressed():
	unpause()


func _on_Menu_pressed():
	SfxPlayer.stop_music()
	unpause()
	get_tree().change_scene("res://menus/main_menu.tscn")
