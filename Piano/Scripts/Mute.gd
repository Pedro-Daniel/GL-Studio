extends CheckBox

var tracks_muted = [false,false,false,false,false,false,false]

onready var inst_selec = get_parent().get_node("Instrument_Selection")

func _on_Mute_pressed():
	tracks_muted[inst_selec.num] = !tracks_muted[inst_selec.num]
	get_tree().call_group("Key","set_muted")
