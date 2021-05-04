extends Control

const NUM = 1.05946309436

var audioserver = AudioServer
var e = 0
func _input(event):
	if event.is_action_pressed("ui_accept"):
		e += 1
		$Label.text = str(e)
#		audioserver.set_bus_layout(load("res://default_bus_layout.tres"))
		audioserver.get_bus_effect(1,0).set("pitch_scale", pow(NUM,e))
		$AudioStreamPlayer.bus = "Teste"
		$AudioStreamPlayer.play()
