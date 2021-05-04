extends Button

const root12 = 1.05946309436

onready var my_position_in_scale = self.get_index()
onready var current_instrument = "Piano"

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
	else:
		get("custom_styles/normal").set("bg_color",Color.whitesmoke)

func set_my_sound():
	# Atribui o som especifico ao node especifico e gera o stream
	var sound = "res://Assets/Samples/Pianos/"+current_instrument+".ogg"
	$Audio.stream = load(sound)

func set_my_pitch():
	$Audio.pitch_scale *= pow(root12,((4 + 2*11) - my_position_in_scale)) # 4 + 2*11 Significa duas escalas pra tras, começando por Do

func _on_Key_pressed():
	$Audio.play()
