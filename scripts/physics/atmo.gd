class_name Atmoshpere

const SEA_LEVEL_DENSITY := 1.255 #kg/m^3
const DENSITY_SCALE_HEIGHT := 8500.0 # frankly i still dont know what is it

const SEA_LEVEL_PRESSURE := 101325.0
const PRESSURE_SCALE_HEIGHT := 8434.0

func density(altitude: float) -> float:
	return SEA_LEVEL_DENSITY * exp(-altitude / DENSITY_SCALE_HEIGHT)
	
func pressure(altitude: float) -> float:
	return SEA_LEVEL_PRESSURE * exp(-altitude / PRESSURE_SCALE_HEIGHT)

var mass := 0.3 # kg
var drag_coefficient := 0.5
var area := 0.01

func drag_force(velocity: Vector3, wind: Vector3, air_density: float) -> Vector3:
	var relative_velocity = velocity-wind # the wind should get the fuck out i think but ok :D
	var speed := relative_velocity.length()
	
	if speed==0.0: return Vector3.ZERO
	return -0.5 * air_density * drag_coefficient * area * speed * relative_velocity
