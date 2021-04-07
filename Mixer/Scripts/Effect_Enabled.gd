extends CheckButton

export var effect_index = 0

var my_sliders = []

func _ready():
	var people = get_tree().get_nodes_in_group("Slider")
	for i in people:
		if i.effect_index == effect_index:
			my_sliders.append(i)

func _on_Effect_Enabled_toggled(button_pressed):
	if button_pressed:
		for i in my_sliders:
			i.editable = true
		AudioServer.set_bus_effect_enabled(0,effect_index,true)

	else:
		for i in my_sliders:
			i.editable = false
		AudioServer.set_bus_effect_enabled(0,effect_index,false)
