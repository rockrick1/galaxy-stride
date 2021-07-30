extends MarginContainer


var waves_label : Label
var deaths_label : Label
var diff_label : Label

var waves_value_label : Label
var deaths_value_label : Label
var diff_value_label : Label

var waves : int
var deaths : int
var diff : int

var current_label : Label
var messages_dict : Dictionary

var typing_speed = .05
var read_time = .35
var stage : Node
var game_over : bool = false

var current_message = 0
var display = ""
var current_char = 0

var messages = [
	"RESULTS",
	"Waves Cleared:",
	"Deaths:",
	"Final Difficulty:"
]

func _ready():
	waves_label = $VBoxContainer/HBoxContainer/Labels/Waves
	deaths_label = $VBoxContainer/HBoxContainer/Labels/Deaths
	diff_label = $VBoxContainer/HBoxContainer/Labels/Diff
	waves_value_label = $VBoxContainer/HBoxContainer/Stats/Waves
	deaths_value_label = $VBoxContainer/HBoxContainer/Stats/Deaths
	diff_value_label = $VBoxContainer/HBoxContainer/Stats/Diff
	messages_dict[messages[1]] = waves_label
	messages_dict[messages[2]] = deaths_label
	messages_dict[messages[3]] = diff_label
	margin_right = 512
	margin_bottom = 300
	$VBoxContainer/Rerun.visible = not game_over

	if stage:
		set_deaths(stage.deaths)
		set_diff(stage.overall_difficulty)
		# waves cleared = current wave - 1
		set_waves(stage.waves_cleared - 1)

	start_dialogue()


func set_waves(w : int):
	waves = w

func set_deaths(d : int):
	deaths = d

func set_diff(d : int):
	diff = d

func start_dialogue():
	current_message = 0
	display = ""
	current_char = 0
	current_label = $VBoxContainer/Results
	$CharTimer.set_wait_time(typing_speed)
	$CharTimer.start()

func stop_dialogue():
	$CharTimer.stop()
	$LineTimer.stop()

func set_message_value(message_idx : int):
	match message_idx:
		1:
			waves_value_label.set_text(str(waves))
		2:
			deaths_value_label.set_text(str(deaths))
		3:
			diff_value_label.set_text(str(diff))


func _on_CharTimer_timeout():
	SfxPlayer.play("CharShot")
	if (current_char < len(messages[current_message])):
		var next_char = messages[current_message][current_char]
		display += next_char
		current_label.text = display
		current_char += 1
	else:
		$CharTimer.stop()
		$LineTimer.one_shot = true
		$LineTimer.set_wait_time(read_time)
		$LineTimer.start()

func _on_LineTimer_timeout():
	set_message_value(current_message)
	if (current_message == len(messages) - 1):
		stop_dialogue()
	else:
		current_message += 1
		current_label = messages_dict[messages[current_message]]
		display = ""
		current_char = 0
		$ValueTimer.start()
		# $CharTimer.start()

func _on_ValueTimer_timeout():
	$CharTimer.start()

func _on_Button_pressed():
	SfxPlayer.stop_music()
	get_tree().change_scene("res://menus/main_menu.tscn")

func _on_Rerun_pressed():
	if stage:
		stage.rerun()
	queue_free()
