extends HBoxContainer

var trigger = false
var trigger2 = false
var begin = 0.0
var acell = 30

func _on_R_mouse_entered():
	trigger = true

func _on_R_mouse_exited():
	trigger = false

func _on_Shape_mouse_entered():
	trigger2 = true

func _on_Shape_mouse_exited():
	trigger2 = false

func _physics_process(delta):
	if trigger:
		if Input.is_action_pressed("ui_mouse_left"):
			begin = $R.rect_global_position.x
			var interval = begin - get_viewport().get_mouse_position().x
			if abs(interval) >= 1:
				rect_size.x += -interval
		elif Input.is_action_pressed("ui_mouse_right"):
			queue_free()
	
	elif trigger2:
		if Input.is_action_pressed("ui_mouse_left"):
			rect_global_position = lerp(rect_global_position, get_viewport().get_mouse_position() - rect_size/2, acell*delta)
		elif Input.is_action_pressed("ui_mouse_right"):
			queue_free()
