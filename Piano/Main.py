from godot import exposed, export
from godot import *
from sympy import *
from sympy.abc import x

@exposed
class Main(Node):
	def fourier(f = x**2, value = pi):
		s = fourier_series(f,(x,-pi,pi)).truncate(n = 3)
		r = s.subs(x,value)
		return r

