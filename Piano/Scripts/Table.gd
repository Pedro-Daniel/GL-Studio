extends HBoxContainer

onready var play_button = get_parent().get_parent().get_node("Sets/Div/Play_Button")

func _on_Add_Button_pressed():
	var scale = load("res://Piano/Scenes/Scale.tscn")
	var new_scale = scale.instance()
	add_child(new_scale)
	move_child(new_scale,get_child_count()-2)
	play_button.amount_scales += 1
	var parent = get_parent()
	if parent is ScrollContainer:
		yield(get_tree(),"idle_frame")
		parent.scroll_horizontal = 60000
