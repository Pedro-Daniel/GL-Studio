extends Button

export var my_name = ""
export var my_audio = ""
export var my_key = ""

func _ready():
	$Name.text = my_name
#	$Audio.stream = load(my_audio)

func _input(event):
	if event is InputEventKey:
		if OS.get_scancode_string(event.scancode) == my_key:
			if event.pressed == true:
				toggle_mode = true
				pressed = true
				_on_Drum_Pad_Key_pressed()
			else:
				pressed = false
				toggle_mode = false

func _on_Drum_Pad_Key_pressed():
	$Audio.play()
