extends Button

var path = ""
var file

onready var filedialog = get_parent().get_parent().get_parent().get_parent().get_node("FileDialog")
onready var play_but = get_parent().get_node("Play_Button")
onready var compass_cont = get_parent().get_node("Compass_Control")
onready var instrum_select = get_parent().get_node("Instrument_Selection")

func _on_Record_Button_pressed():
	var record = AudioServer.get_bus_effect(0,0) as AudioEffectRecord
	
	Global.playing = true
	play_but.disabled = true
	compass_cont.editable = false
	instrum_select.disabled = true
	disabled = true
	play_but.start_music()
	
	record.set_recording_active(true)
	yield(get_tree().create_timer(play_but.amount_scales*Global.compass),"timeout")
	record.set_recording_active(false)
	
	Global.playing = false
	play_but.disabled = false
	compass_cont.editable = true
	instrum_select.disabled = false
	disabled = false
	
	filedialog.show()
	file = record.get_recording()

func _on_FileDialog_confirmed():
	path = filedialog.current_path
	file.save_to_wav(path)
