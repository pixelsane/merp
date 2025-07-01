// Mainly hermite and linearAngle demonstration -- adding comments soon

import "merp"
clear
rocketImg =  file.loadImage("./examples/assets/rocket.png")
enableTrail = true

rocket = new Sprite
rocket.init = function
	self.x = 100
	self.y = 100
	self.vx = 50
	self.vy = 100
	self.scale = 0.2
	self.image = rocketImg
	self.trail = []
end function

landingpoint = new Sprite
landingpoint.init = function
	self.x = 200 * (rnd * 4.25)
	self.y = 200 * (rnd * 3)
end function

display(4).sprites.push rocket

deg = function(n)
	return n * 180 / pi
end function

drawTrail = function(rkt)
	for i in range(0, rkt.trail.len - 1)
		pos = rkt.trail[i]
		display(5).fillRect pos["x"], pos["y"], 10, 10, color.rgba(255,225,0,100)
	end for
end function

simulate = function
	landingpoint.init
	rocket.init
	
	landingTime = 1 + (rnd * 9)
	currentTime = 0.0
	
	startX = rocket.x
	startY = rocket.y
	endX = landingpoint.x
	endY = landingpoint.y
	startVx = rocket.vx
	startVy = rocket.vy
	endVx = 0
	endVy = 0
	
	lastTime = time
	
	while currentTime < landingTime
		dt = time - lastTime
		lastTime = time
		currentTime += dt
		
		t = currentTime / landingTime
		t = clamp(t, 0, 1)
		
		prevX = rocket.x
		prevY = rocket.y
		
		rocket.x = merp.hermite(startX, endX, startVx, endVx, t)
		rocket.y = merp.hermite(startY, endY, startVy, endVy, t)
		
		dx = rocket.x - prevX
		dy = rocket.y - prevY
		
		prevAngle = rocket.rotation
		targetAngle = deg(atan(dy, dx)) - 90
		rocket.rotation = merp.linearAngle(prevAngle, targetAngle, 0.1)
		rocket.trail.push {"x": prevX, "y": prevY}
		
		display(5).clear
		display(5).fillRect landingpoint.x, landingpoint.y, 42, 42, color.white
		display(5).print "Time/Target: " + currentTime + " -> " + landingTime + " | POS: " + round(rocket.x) + ":" + round(rocket.y)
		
		if enableTrail then
			drawTrail rocket
		end if	
		
		yield
	end while
	
	rocket.x = startX
	rocket.y = startY
	rocket.vx = startVx
	rocket.vy = startVy
	rocket.rotation = 0
	currentTime = 0
end function

while not key.pressed("escape")
	simulate
end while