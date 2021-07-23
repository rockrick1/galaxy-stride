extends MarginContainer


var waves
var deaths
var diff

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
