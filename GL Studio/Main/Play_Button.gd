extends Button

onready var record_but = get_parent().get_node("Record_Button")

func _on_Play_Button_toggled(button_pressed):
	record_but.disabled = !record_but.disabled
	Global.playing = !Global.playing
	if button_pressed:
		Global.start_music()
