# a Miniscript Interpolation Library

Mathematical interpolation and easing functions for smooth value transitions.

## Basic Usage
This is an extremely simple usage example! Please head onto the examples to learn more about merp.

```javascript
import "merp"
// Smoothly animate a progress value using exponential ease-in
rawProgress = merp.easeInExpo(0.4) // Returns ~0.028

// Scale it to a range and snap it to nearest 5
scaled = merp.snap(merp.lerp(0, 100, rawProgress), 5) // Returns 0

// Clamp an overshooting value to keep it visible on screen
clamped = merp.clamp(112, 0, 100) // Returns 100

// Remap mouse position (x) to screen brightness using a circular easing out
// notice how we are trying to prevent function calls with @
brightness = merp.remapWithEasing(mouse.x, 0, screen.width, 0, 255, @merp.easeOutCirc)

// Interpolate between two angles, making sure rotation is minimal
angle = merp.linearAngle(player.rotation, target.rotation, 0.2)

// Create a bouncy tween and sample it over time
bounce = merp.makeTween(0, 1, @merp.easeOutBounce)

// Returns value with bounce at 60% of tween
t = merp.at(bounce.to, 0.6)
```

---

### Export to Globals
You can also export all available aliases to globals by using `aliasToGlobals` for ease of access, check above for available aliases:
```javascript
// Use aliases globally (optional)

merp.aliasToGlobals // Makes lerp, slerp, etc. available as globals

lerp 0, 100, 0.5 // Returns 50 (linear interpolation)
herm 10.0, 20.0, 5.0, 0.0, 0.5 // Returns 15.625
```

The `t` parameter (0-1) represents animation progress: 0% to 100%.

---

## Available Functions
### Core Interpolation
linear • smoothLinear • inverseLinear

### Curves & Bezier
bezier3 • bezier4 • bezierN • hermite • catmullRom

### Easing Functions
easeInQuad • easeOutBounce • easeInExpo • easeOutExpo • easeInCirc • easeOutCirc • easeInBack • easeOutBack

### Smooth Transitions
smoothStep • smootherStep • smoothStepRange • smootherStepRange

### Utilities
clamp • saturate • snap • snapDown • snapUp • bias • gain • remapWithEasing

### Angles & Tweens
linearAngle • smoothAngle • angleDistance • meanAngle • angleDiff • makeTween • at

### Advanced
interpolate • aliasToGlobals

**Aliases:**
smoothlerp • slerp • bezier1 • bez1 • bez3 • bez4 • bezn • herm • ssstep • sstep • ssstepr • sstepr • qerp • invlerp • lerp • mix • lerpangle • sangle • slerpangle • angledistance • mangle • anglediff • catmull • crom

---

### Quick Start:
- lerp(a, b, t)           - linear interpolation
- smoothlerp(a, b, t)     - smooth interpolation  
- makeTween(from, to, easingFunc) - create reusable tween

### Common Gotchas:
  - smoothStep(a,b,t): a,b are INPUT range, t is the value to map
  - All angle functions expect degrees, not radians
  - bezierN expects a list/array of points

## Examples
To run examples, boot or copy to your Minimicro directory and then run the example from the /merp/ directory. (Not in the /examples/ directory)
```bash
cd "/usr/merp"
run "examples/rocketlander"
```
---

Browse the code for more functions: easing curves, Bézier interpolation, utilities, and aliases.
