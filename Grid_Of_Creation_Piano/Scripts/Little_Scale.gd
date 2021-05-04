extends VBoxContainer

func _ready():
	OS.open_midi_inputs()

func _unhandled_input(event):
	if event is InputEventMIDI:
		if event.pitch > 0:
			var value = event.pitch - 21
			if value <= get_child_count():
				var note = get_child(value)
				if event.message == MIDI_MESSAGE_NOTE_ON:
					note.toggle_mode = true
					note.pressed = true
					note._on_Key_pressed()
				elif event.message == MIDI_MESSAGE_NOTE_OFF:
					note.pressed = false
					note.toggle_mode = false
			else:
				print("note out of range")
