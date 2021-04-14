extends Button

onready var record_but = get_parent().get_node("Record_Button")
onready var time_line = owner.get_node("Division/Time_Line/Table")
onready var amount_scales = time_line.get_child_count()-1
var current_scale_index = 0

func _on_Play_Button_toggled(button_pressed):
	record_but.disabled = !record_but.disabled
	Global.playing = !Global.playing
	if button_pressed:
		$Timer.start(0.005)
	else:
		get_tree().call_group("Scale","clear")
		current_scale_index = 0
		$Timer.stop()

func _on_Timer_timeout():
	var current_scale = time_line.get_child(current_scale_index)
	
	if time_line.get_child(current_scale_index-1) != null:
		time_line.get_child(current_scale_index-1).modulate = Color(1,1,1,1)
	
	current_scale.modulate = Color(0.21,0.87,0.83,0.7)
	for key in current_scale.get_children():
		key.start_to_play()
	
	current_scale_index += 1
	if current_scale_index > amount_scales:
		current_scale_index = 0
		
	$Timer.start(Global.compass)
