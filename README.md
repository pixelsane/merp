# a Miniscript Interpolation Library

Mathematical interpolation and easing functions for smooth value transitions.

## Available Functions
• aliasToGlobals
• interpolate 
• clamp • saturate • snap • snapDown • snapUp • bias • gain
• remapWithEasing • easeInQuad • easeOutBounce • easeInExpo • easeOutExpo • easeInCirc • easeOutCirc • easeInBack • easeOutBack
• linear • smoothLinear • inverseLinear
• bezier3 • bezier4 • bezierN • smoothStep • smootherStep • hermite
• linearAngle • angleDistance
• catmullRom
• makeTween • at • mix 

**Aliases:** smoothlerp • slerp • bezier1 • bez1 • bez3 • bez4 • bezn • herm • ssstep • sstep • qerp • invlerp • lerp • mix • lerpangle • angledistance • catmull • crom

## Basic Usage
```javascript
// Use aliases globally (optional)
merp.aliasToGlobals         // Makes lerp, slerp, etc. available as globals

lerp(0, 100, 0.5)        // Returns 50 (linear interpolation)
smoothLinear(0, 100, 0.5) // Returns 25 (with easing)
clamp(150, 0, 100)       // Returns 100 (bounded)
```

The `t` parameter (0-1) represents animation progress: 0% to 100%.

## Common Use Cases
```javascript
// Smooth camera follow
cameraX = lerp(cameraX, playerX, 0.1)

// UI fade effects  
opacity = lerp(0, 1, fadeProgress)
```

Browse the code for more functions: easing curves, Bézier interpolation, utilities, and aliases.
