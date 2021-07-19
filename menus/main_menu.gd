extends Control

# Load resources
# var play = preload("res://menus/resources/play.png")
# var settings = preload("res://menus/resources/settings.png")
# var credits = preload("res://menus/resources/credits.png")
# var quit = preload("res://menus/resources/quit.png")

# var play_glow = preload("res://menus/resources/play_glow.png")
# var settings_glow = preload("res://menus/resources/settings_glow.png")
# var credits_glow = preload("res://menus/resources/credits_glow.png")
# var quit_glow = preload("res://menus/resources/quit_glow.png")

var hovering = 0 # which button is being hovered

const tutorial_screen = preload("res://menus/tutorial.tscn")

const credits_screen = preload("res://menus/credits.tscn")


func _ready():
	set_process(true)
	SfxPlayer.play_music("MusicMenu")


func check_null():
	if hovering == 0:
		hovering = 1
		change_button(0, 1)
		return true
	return false


func _input(event):
	var prev = 0

	if Input.is_action_just_pressed("ui_up"):
		if check_null():
			return
		prev = hovering
		hovering -= 1
		if hovering <= 0:
			hovering = 4
		change_button(prev, hovering)

	elif Input.is_action_just_pressed("ui_down"):
		if check_null():
			return
		prev = hovering
		hovering += 1
		if hovering >= 5:
			hovering = 1
		change_button(prev, hovering)

	# settings and credits to be added here
	elif Input.is_action_just_pressed("ui_accept"):
		if check_null():
			return
		match hovering:
			1:
				pass
			4:
				_on_Quit_pressed()

# unhovers the prev button and hovers the new
func change_button(prev, new):
	match prev:
		1:
			_on_play_mouse_exited()
		2:
			_on_settings_mouse_exited()
		3:
			_on_credits_mouse_exited()
		4:
			_on_quit_mouse_exited()
	match new:
		1:
			_on_play_mouse_entered()
		2:
			_on_settings_mouse_entered()
		3:
			_on_credits_mouse_entered()
		4:
			_on_quit_mouse_entered()


func play_scene():
	get_tree().change_scene("res://menus/css.tscn")


func _on_Quit_pressed():
	get_tree().quit()


# button functions #


func _on_play_mouse_entered():
	# $Buttons/Play.texture_normal = play_glow
	$MenuItems/Buttons/NewGame/AnimationPlayer.play("hover")

func _on_settings_mouse_entered():
	hovering = 2
	# $Buttons/Settings.texture_normal = settings_glow
	$MenuItems/Buttons/Settings/AnimationPlayer.play("hover")

func _on_credits_mouse_entered():
	hovering = 3
	# $Buttons/Credits.texture_normal = credits_glow
	$MenuItems/Buttons/Credits/AnimationPlayer.play("hover")

func _on_quit_mouse_entered():
	hovering = 4
	# $Buttons/Quit.texture_normal = quit_glow
	$MenuItems/Buttons/Quit/AnimationPlayer.play("hover")


func _on_play_mouse_exited():
	hovering = 0
	# $Buttons/Play.texture_normal = play
	$MenuItems/Buttons/NewGame/AnimationPlayer.play("unhover")


func _on_settings_mouse_exited():
	hovering = 0
	# $Buttons/Settings.texture_normal = settings
	$MenuItems/Buttons/Settings/AnimationPlayer.play("unhover")


func _on_credits_mouse_exited():
	hovering = 0
	# $Buttons/Credits.texture_normal = credits
	$MenuItems/Buttons/Credits/AnimationPlayer.play("unhover")


func _on_quit_mouse_exited():
	hovering = 0
	# $Buttons/Quit.texture_normal = quit
	$MenuItems/Buttons/Quit/AnimationPlayer.play("unhover")


func _on_tutorial_pressed():
	var tutorial_inst = tutorial_screen.instance()
	add_child(tutorial_inst)


func _on_tutorial_mouse_entered():
	hovering = 3
	# $Buttons/Credits.texture_normal = credits_glow
	$MenuItems/Buttons/Tutorial/AnimationPlayer.play("hover")


func _on_tutorial_mouse_exited():
	hovering = 0
	# $Buttons/Credits.texture_normal = credits_glow
	$MenuItems/Buttons/Tutorial/AnimationPlayer.play("unhover")


func _on_settings_pressed():
	pass # Replace with function body.


func _on_quit_pressed():
	get_tree().quit()


func _on_demo_pressed():
	get_tree().change_scene("res://stages/generator_demo.tscn")
	SfxPlayer.stop_music()


func _on_demo_mouse_entered():
	hovering = 3
	# $Buttons/Credits.texture_normal = credits_glow
	$MenuItems/Buttons/Demo/AnimationPlayer.play("hover")


func _on_demo_mouse_exited():
	hovering = 0
	# $Buttons/Credits.texture_normal = credits_glow
	$MenuItems/Buttons/Demo/AnimationPlayer.play("unhover")


func _on_newgame_pressed():
	if not $fade.is_playing():
		SfxPlayer.play_music_anim("MusicMenu", "fade_out")
		$fade.play("fade_out")
	set_process(false)


func _on_Credits_pressed():
	var credits_inst = credits_screen.instance()
	add_child(credits_inst)
	pass


func _on_Credits_mouse_entered():
	hovering = 3
	# $Buttons/Credits.texture_normal = credits_glow
	$MenuItems/Buttons/Credits/AnimationPlayer.play("hover")


func _on_Credits_mouse_exited():
	hovering = 0
	# $Buttons/Credits.texture_normal = credits_glow
	$MenuItems/Buttons/Credits/AnimationPlayer.play("unhover")
