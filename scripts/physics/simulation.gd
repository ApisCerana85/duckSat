## here all of the simulation comes together

class_name Physic

const DT := 0.005 # 200hz (1/200s) # delta time
const GRAVITY := Vector3.DOWN * 9.80665

var atmo := Atmoshpere.new()
var Cdpar := 1.3
var vel_gut := 10

func step(state: SimState):
	var real_time = DT * state.timewarp
	
	state.atmo_density = atmo.density(state.position.y)
	state.atmo_pressure = atmo.pressure(state.position.y)
	var S = (2 * atmo.mass * 9.81) / (Cdpar * atmo.SEA_LEVEL_DENSITY * vel_gut)
	
	if (state.position).y > 0:
		var fdrag = (atmo.drag_coefficient * state.cd * atmo.density(state.position.y) * S)/2*0.350
		var fdrag_vec = -state.velocity.normalized() * fdrag
		var acc = GRAVITY + (fdrag_vec / atmo.mass)
		state.velocity += acc * DT
	else:
		state.velocity=Vector3.ZERO
		return
	state.position += state.velocity * real_time
	
		
	
	#print("velocity: ", state.velocity)
	#print("position: ", state.position)
