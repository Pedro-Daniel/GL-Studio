extends OptionButton

var num = 0

onready var current = get_item_text(0)
onready var mute_control = get_parent().get_node("Mute")

func _on_Instrument_Selection_item_selected(id):
	num = id
	current = get_item_text(id)
	# Configura a onion skin do teclado
	get_tree().call_group("Key","set_color_in_other_track")
	# Configura os instrumento nas teclas
	get_tree().call_group("Key","set_my_sound")
	# Configura a checkbox
	mute_control.pressed = mute_control.tracks_muted[id]
