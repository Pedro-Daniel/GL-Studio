extends Control

func show_piano():
	$Union.hide()
	$Piano.show()

func show_mixer():
	$Piano.hide()
	$Union.show()
