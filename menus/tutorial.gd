extends Control


var current_page = 1
const num_pages = 5


func _ready():
	$ColorRect/Pages/Labels1.show()
	$ColorRect/Pages/Labels2.hide()
	$ColorRect/Pages/Labels3.hide()
	$ColorRect/Pages/Labels4.hide()
	$ColorRect/Pages/Labels5.hide()
	$ColorRect/Pages.set_animation("1")
	$ColorRect/Num.set_text(str(current_page)+"/"+str(num_pages))


func _on_Next_pressed():
	if current_page == num_pages:
		return
	$ColorRect/Pages.get_node("Labels"+str(current_page)).hide()
	current_page += 1
	$ColorRect/Pages.get_node("Labels"+str(current_page)).show()
	$ColorRect/Pages.set_animation(str(current_page))
	$ColorRect/Num.set_text(str(current_page)+"/"+str(num_pages))

func _on_Prev_pressed():
	if current_page == 1:
		return
	$ColorRect/Pages.get_node("Labels"+str(current_page)).hide()
	current_page -= 1
	$ColorRect/Pages.get_node("Labels"+str(current_page)).show()
	$ColorRect/Pages.set_animation(str(current_page))
	$ColorRect/Num.set_text(str(current_page)+"/"+str(num_pages))


func _on_Close_pressed():
	queue_free()
