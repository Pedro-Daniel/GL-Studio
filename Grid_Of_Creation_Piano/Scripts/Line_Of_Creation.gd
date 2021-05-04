extends VBoxContainer

var trigger = false

func _input(event):
	if event is InputEventMIDI:
		print(event.controller_number)
	if trigger:
		if event.is_action_pressed("ui_mouse_left"):
			var note = load("res://Grid_Of_Creation_Piano/Scenes/Note.tscn")
			var new_note = note.instance()
			owner.add_child(new_note)
			new_note.rect_global_position = get_viewport().get_mouse_position() - new_note.rect_size/2

func _on_ReferenceRect_mouse_entered():
	trigger = true

func _on_ReferenceRect_mouse_exited():
	trigger = false
