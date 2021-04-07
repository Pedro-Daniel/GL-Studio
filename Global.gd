extends Node

var playing = false
var compass = 1.0

onready var time_line = get_parent().get_node("Main_Interface/GDiv/Piano/Division/Time_Line/Table")
onready var amount_scales = time_line.get_child_count()-1
onready var wave_spectrum = get_tree().get_nodes_in_group("Spectrum")[0]

func start_music():
	for i in amount_scales:
		var current_scale = time_line.get_child(i)
		current_scale.modulate = Color(0.21,0.87,0.83,0.7)
		for j in current_scale.get_child_count():
			var key = current_scale.get_child(j)
			key.start_to_play()
			if playing == false:
				current_scale.modulate = Color(1,1,1,1)
				wave_spectrum.reiniciate()
				return
		yield(get_tree().create_timer(compass),"timeout")
		current_scale.modulate = Color(1,1,1,1)
	start_music()
