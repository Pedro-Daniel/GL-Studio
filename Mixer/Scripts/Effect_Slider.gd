extends VSlider

export var minV = 0.0
export var maxV = 100.0
export var initial_value = 0.0
export var effect_index = 0
export var parameter_to_set = ""

func _ready():
	min_value = minV
	max_value = maxV
	value = initial_value

func _on_Effect_Slider_value_changed(value):
	AudioServer.get_bus_effect(0,effect_index).set(parameter_to_set,value)
