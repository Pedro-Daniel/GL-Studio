extends HSlider

func _on_Compass_Control_value_changed(value):
	Global.compass = stepify(60/value, 0.0001)
	get_parent().get_node("BPMs").text = str(value)+" BPMs"
