// Hi PixelSane here, FYI everything here is functional
// There are no assertions or type safeties implemented (among params)
// So, double check your arguments

// General Helpers
clamp = function(x, min, max)
	if x < min then
		return min 
	else if x > max then
		return max
	else
		return x
	end if
end function

saturate = function(x)
	return clamp(x, 0, 1)
end function

snap = function(x, step)
	if step == 0 then
		return x
	end if
	return round(x / step) * step
end function

snapDown = function(x, step)
	return floor(x / step) * step
end function

snapUp = function(x, step)
	return ceil(x / step) * steph
end function

bias = function(t, b)
	return t / ((1 / b - 2) * (1 - t) + 1)
end function

gain = function(t, g)
	if t < 0.5 then
		return bias(t * 2, g) / 2
	else
		return 1 - bias(2 - 2 * t, g) / 2
	end if
end function

min = function(a, b)
	if a < b then
		return a
	else
		return b
	end if
end function

// Ease Functions
easeInQuad = function(t)
	return t * t	
end function

easeOutBounce = function(tempT)
	// Robert penner's easing equation
	// Emulates a bouncing ball
	t = tempT + 0.0
	if t < 1 / 2.75 then
		return 7.5625 * t * t
	else if t < 2 / 2.75 then
		t -= 1.5 / 2.75
		return 7.5625 * t * t + 0.75
	else if t < 2.5 / 2.75 then
		t -= 2.25 / 2.75
		return 7.5625 * t * t + 0.9375
	else
		t -= 2.625 / 2.75
		return 7.5625 * t * t + 0.984375
	end if
end function

easeInExpo = function(t)
	if t == 0 then
		return 0
	else
		return 2 ^ (10 * (t - 1))
	end if
end function

easeOutExpo = function(t)
	if t == 1 then
		return 1
	else
		return 1 - (2 ^ (-10 * t))
	end if
end function

easeInCirc = function(t)
	return 1 - sqrt(1 - t * t)
end function

easeOutCirc = function(t)
	t = t - 1
	return sqrt(1 - t * t)
end function

easeInBack = function(t)
	s = 1.70158
	return t * t * ((s + 1) * t - s)
end function

easeOutBack = function(t)
	s = 1.70158
	t = t - 1
	return t * t * ((s + 1) * t + s) + 1
end function

// args: num, num, num, num, num, function(t)
remapWithEasing = function(value, inMin, inMax, outMin, outMax, easing)
	t = clamp((value - inMin) / (inMax - inMin), 0.0, 1.0)
	e = easing(t)
	return outMin + (outMax - outMin) * e
end function


// INTERPOLATE returns a function that applies easing before interpolating
// pass an easing function on `ease` with a t param!
// pass an interpolation function on `interp` with a,b,t params!
// args: function(t), function(a,b,t)
interpolate = function(ease, interp)
	newFunc = function(a, b, t)
		return interp(a, b, ease(t))
	end function
	
	return @newFunc
end function


// Interpolation Functions
linear = function(a, b, t)
	return a + (b - a) * t
end function


// args: a, b, t
smoothLinear = interpolate(@easeInQuad, @linear)

inverseLinear = function(a, b, v)
	return (v - a) / (b - a)
end function

bezier3 = function(a, b, c, t)
	u = 1 - t
	return u * u * a + 2 * u * t * b + t * t * c
end function

bezier4 = function(a, b, c, d, t)
	u = 1 - t
	tt = t * t
	uu = u * u
	uuu = uu * u
	ttt = tt * t
	return uuu * a + 3 * uu * t * b + 3 * u * tt * c + ttt * d
end function


// n-point bezier (DC): interpolates between points, so remember to pass a list!
bezierN = function(points, t)
	if points.len == 1 then
		return points[0]
	else
		next = []
		for i in range(0, points.len - 2)
			next.push linear(points[i], points[i+1], t)
		end for	
		return bezierN(next, t)
	end if
end function

smoothStep = function(a, b, t)
	x = clamp((t - a) / (b - a), 0.0, 1.0)
	return x * x * (3 - 2 * x)
end function

smootherStep = function(a, b, t)
	x = clamp((t - a) / (b - a), 0.0, 1.0)
	return x * x * x * (x * (x * 6 - 15) + 10)
end function

hermite = function(p0, p1, t0, t1, t)
	t2 = t * t
	t3 = t2 * t
	h00 = 2 * t3 - 3 * t2 + 1
	h10 = t3 - 2 * t2 + t
	h01 = -2 * t3 + 3 * t2
	h11 = t3 - t2
	return h00 * p0 + h10 * t0 + h01 * p1 + h11 * t1
end function

// Angle Interpolation
linearAngle = function(a, b, t)
	diff = b - a
	if abs(diff) > 180 then
		if diff > 0 then
			diff = diff - 360
		else
			diff = diff + 360
		end if
	end if
	return a + diff * t
end function

angleDistance = function(a, b)
	diff = abs(b - a)
	return min(diff, 360 - diff)
end function

// Spline
catmullRom = function(p0, p1, p2, p3, t)
	t2 = t * t
	t3 = t2 * t
	return 0.5 * ((2 * p1) + 
	  (-p0 + p2) * t + 
	  (2*p0 - 5*p1 + 4*p2 - p3) * t2 + 
	  (-p0 + 3*p1 - 3*p2 + p3) * t3)
end function


// Tween Helpers
makeTween = function(a, b, e) 
	// e has to be a function
	return {"from": a, "to": b, "easing": @e}
end function

at = function(tween, t)
	return linear(tween.from, tween.to, tween.easing(t))
end function

// Aliases
smoothlerp = @smoothLinear
slerp = @smoothLinear
bezier1 = @linear
bez1 = @linear
bez3 = @bezier3
bez4 = @bezier4
bezn = @bezierN
herm = @hermite
ssstep = @smootherStep
sstep = @smoothStep
qerp = @bezier3
invlerp = @inverseLinear
lerp = @linear
mix = @linear
lerpangle = @linearAngle
angledistance = @angleDistance
catmull = @catmullRom
crom = @catmullRom

aliasToGlobals = function
	globals.smoothlerp = @smoothLinear
	globals.slerp = @smoothLinear
	globals.bezier1 = @linear
	globals.bez1 = @linear
	globals.bez3 = @bezier3
	globals.bez4 = @bezier4
	globals.bezn = @bezierN
	globals.herm = @hermite
	globals.ssstep = @smootherStep
	globals.sstep = @smoothStep
	globals.qerp = @bezier3
	globals.invlerp = @inverseLinear
	globals.lerp = @linear
	globals.lerpangle = @linearAngle
	globals.angledistance = @angleDistance
	globals.catmull = @catmullRom
	globals.crom = @catmullRom 
	globals.mix = @linear
end function