extends MarginContainer


var waves
var deaths
var diff

var messages = [
	"My First Message",
	"Second Message For You"
]

func _ready():
	waves = $VBoxContainer/HBoxContainer/Stats/Waves
	deaths = $VBoxContainer/HBoxContainer/Stats/Deaths
	diff = $VBoxContainer/HBoxContainer/Stats/Diff
	margin_right = 512
	margin_bottom = 300


func set_waves(w : int):
	waves.set_text(str(w))

func set_deaths(d : int):
	deaths.set_text(str(d))

func set_diff(d : int):
	diff.set_text(str(d))


func _on_Button_pressed():
	get_tree().change_scene("res://menus/main_menu.tscn")

var typing_speed = .1
var read_time = 2

var current_message = 0
var display = ""
var current_char = 0

func start_dialogue():
	current_message = 0
	display = ""
	current_char = 0
	
	$next_char.set_wait_time(typing_speed)
	$next_char.start()

func stop_dialogue():
	# get_parent().remove_child(self)
	queue_free()

func _on_next_char_timeout():
	if (current_char < len(messages[current_message])):
		var next_char = messages[current_message][current_char]
		display += next_char
		
		$Label.text = display
		current_char += 1
	else:
		$next_char.stop()
		$next_message.one_shot = true
		$next_message.set_wait_time(read_time)
		$next_message.start()

func _on_next_message_timeout():
	if (current_message == len(messages) - 1):
		stop_dialogue()
	else: 
		current_message += 1
		display = ""
		current_char = 0
		$next_char.start()

