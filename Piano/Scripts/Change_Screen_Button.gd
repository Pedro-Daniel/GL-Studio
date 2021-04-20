extends Button

func _on_Change_Screen_Button_pressed():
	get_tree().call_group("Main","show_mixer")
