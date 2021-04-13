extends Button

onready var record_but = get_parent().get_node("Record_Button")
onready var time_line = owner.get_node("Division/Time_Line/Table")
onready var amount_scales = time_line.get_child_count()-1

func _on_Play_Button_toggled(button_pressed):
	record_but.disabled = !record_but.disabled
	Global.playing = !Global.playing
	if button_pressed:
		start_music()

func start_music():
	for i in amount_scales:
		var current_scale = time_line.get_child(i)
		current_scale.modulate = Color(0.21,0.87,0.83,0.7)
		for key in current_scale.get_children():
			key.start_to_play()
			if Global.playing == false:
				current_scale.modulate = Color(1,1,1,1)
				return
		yield(get_tree().create_timer(Global.compass),"timeout")
		current_scale.modulate = Color(1,1,1,1)
	start_music()
