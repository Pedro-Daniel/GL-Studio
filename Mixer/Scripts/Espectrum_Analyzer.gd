extends Control

onready var spectrum = AudioServer.get_bus_effect_instance(0,5)

var definition = 40
var total_w = 400
var total_h = 200
var offset = Vector2(224,200)
var min_freq = 20
var max_freq = 20000

var max_db = -10
var min_db = -50

var acell = 10

var histogram = []

func _ready():
	max_db += $AudioStreamPlayer.volume_db
	min_db += $AudioStreamPlayer.volume_db
	reiniciate()

func reiniciate():
	for _i in range(definition):
		histogram.append(0)

func _physics_process(delta):
	var freq = min_freq
	var interval = (max_freq - min_freq) / definition
	
	for i in range(definition):
		
		var freqrange_low = float(freq - min_freq) / float(max_freq - min_freq)
		freqrange_low = pow(freqrange_low,4)
		freqrange_low = lerp(min_freq, max_freq, freqrange_low)
		
		freq += interval
		
		var freqrange_high = float(freq - min_freq) / float(max_freq - min_freq)
		freqrange_high = pow(freqrange_high,4)
		freqrange_high = lerp(min_freq, max_freq, freqrange_high)
		
		var mag = spectrum.get_magnitude_for_frequency_range(freqrange_low, freqrange_high)
		mag = linear2db(mag.length())
		mag = (mag - min_db) / (max_db - min_db)
		
		mag += 0.3 * (freq - min_freq) / (max_freq - min_freq)
		mag = clamp(mag, 0.05, 1)
		
		histogram[i] = lerp(histogram[i], mag, acell * delta)
	
	update()

func _draw():
	var draw_pos = Vector2(0,0)
	var w_interval = total_w/definition
	
	draw_line(Vector2(0 + offset.x, -total_h + offset.y), Vector2(total_w + offset.x,-total_h + offset.y), Color.black, 2.0, true)
	
	for i in range(definition):
		draw_line(draw_pos + offset, draw_pos + Vector2(0, -histogram[i] * total_h) + offset, Color.crimson.darkened((draw_pos.x / total_w)*0.7), 4.0, true)
		draw_pos.x += w_interval
