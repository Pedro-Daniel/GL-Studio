from godot import exposed, export
from godot import *
from sympy import *
from sympy.abc import x
from math import fmod

@exposed
class Audio_Generator(AudioStreamPlayer):
	
	def fourier(self,value):
#		f = x
#		s = fourier_series(f,(x,-pi,pi)).truncate(n = 50)
#		r = s.subs(x,value)
#		return float(r)
		return float(sin(value)) # os comentarios e essa linha sao so pra ir mais rapido
