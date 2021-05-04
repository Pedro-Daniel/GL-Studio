extends Button

const root12 = 1.05946309436

var trigger = false

var amount_plays = 0.8
var my_color = ""
var my_pitch

### {"Nome instrumento":[track mutada?, deve ser tocada na track?]}
var all_instruments = {"Piano":[false,false],"Flauta":[false,false],
"Prog":[false,false],"Quadrada":[false,false],"Senoidal":[false,false],
"Serra":[false,false],"Triangular":[false,false]}

onready var my_scale = self.get_parent().get_index()
onready var my_position_in_scale = self.get_index()
onready var inst_selec = get_parent().get_parent().owner.get_node("Division/Sets/Div/Instrument_Selection")
onready var mute = get_parent().get_parent().owner.get_node("Division/Sets/Div/Mute")
onready var current_instrument = ""
onready var audioserver = AudioServer

func _ready():
	yield(get_tree(),"idle_frame")
	set_my_color()
	set_my_sound()
	set_my_pitch()

func set_my_color():
	# Intervalo das notas pretas
	var excep = [1,3,5,8,10]
	
	# Notas pretas para qualquer tamanho de teclado
	if my_position_in_scale > excep.max():
		for i in range(5):
			excep[i] += 12 * int(my_position_in_scale/12)
	
	# Diz se uma tecla deve ser preta ou branca
	if  my_position_in_scale in excep:
		get("custom_styles/normal").set("bg_color",Color.black)
		my_color = "black"
	else:
		get("custom_styles/normal").set("bg_color",Color.whitesmoke)
		my_color = "white"

func set_my_sound():
	# Recebe o instrumento atual que ira ser tocado no piano
	current_instrument = inst_selec.current
	
	# Configura para que as teclas toquem instrumentos diferentes
	pressed = all_instruments[current_instrument][1]
	
	# Atribui o som especifico ao node especifico e gera o stream
	var sound = "res://Assets/Samples/Pianos/"+current_instrument+".ogg"
	get_node(current_instrument).stream = load(sound)

# Verifica quais tracks podem emitir som e quais não podem
func set_muted():
	var a = mute.tracks_muted
	var count = 0
	for i in all_instruments:
		all_instruments[i][0] = a[count]
		count += 1

func set_my_pitch():
	my_pitch = pow(root12,((4+2*11) - my_position_in_scale)) # 3+2*11 Significa duas escalas pra tras, começando por Do
#	for i in get_children():
#		i.pitch_scale = my_pitch

func start_to_play():
	# Global chama a funcao fazendo as notas tocarem num determinado tempo
	if Global.playing == true:
		for i in all_instruments:
			if all_instruments[i][0] == false and all_instruments[i][1] == true:
				get_node(i).play()
				yield(get_tree().create_timer(1.0),"timeout")

# Configura onion skin no teclado
func set_color_in_other_track():
	if amount_plays != 0.8:
		get("custom_styles/normal").set("bg_color", Color(amount_plays,amount_plays,amount_plays))

func _on_Key_pressed():
	onion_skin(pressed)
	
	# Testar qual nota corresponde ao botao
	if all_instruments[current_instrument][1] == true and Global.playing == false:
		audioserver.set_bus_layout(load("res://default_bus_layout.tres"))
		audioserver.add_bus(1)
		audioserver.add_bus_effect(1, AudioEffectPitchShift.new())
		audioserver.get_bus_effect(1,0).set("pitch_scale", my_pitch)
		get_node(current_instrument).bus = "New Bus"
		get_node(current_instrument).play()
		yield(get_tree().create_timer(Global.compass),"timeout")
		audioserver.remove_bus(1)

# Configura a onion skin no teclado
func onion_skin(param):
	if param:
		amount_plays -= 0.1
	else:
		amount_plays += 0.1
		if amount_plays == 0.8:
			if my_color == "white":
				get("custom_styles/normal").set("bg_color", Color.whitesmoke)
			else:
				get("custom_styles/normal").set("bg_color", Color.black)
		else:
			set_color_in_other_track()
	
	# Diz se esta e' uma nota que deve ser tocada em sua track
	all_instruments[current_instrument][1] = !all_instruments[current_instrument][1]

func _input(event):
	# Selecao de teclas multiplas
	if event.is_action_pressed("ui_mouse_right"):
		trigger = !trigger
	
	# Deletar todas as teclas da track
	elif event.is_action_pressed("ui_delete"):
		if pressed:
			pressed = false
			onion_skin(false)
			all_instruments[current_instrument][1] = false

# Selecao de teclas multiplas
func _on_Key_mouse_entered():
	if trigger:
		pressed = !pressed
		onion_skin(pressed)
