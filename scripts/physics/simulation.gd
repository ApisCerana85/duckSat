## here all of the simulation comes together

class_name PhysicsSim

const DT := 0.005 # 200hz (1/200s) # delta time
const GRAVITY := Vector3.DOWN * 9.80665

var atmo := Atmoshpere.new()
var S := PI * (0.033 ** 2 )


func step(state: SimState):
	var real_time = DT * state.timewarp
	var Cr = atmo.drag_coefficient * state.cd * atmo.density(state.position.y) * S
	var v_term = sqrt((atmo.mass * state.g) / Cr )
	#print(v_term)  ##if you want to check max velocity
	
	state.atmo_density = atmo.density(state.position.y)
	state.atmo_pressure = atmo.pressure(state.position.y)
	
	if (state.position).y > 0:
		var fdrag = atmo.drag_coefficient * state.cd * state.atmo_density * S * state.velocity.length_squared()
		var fdrag_vec = -state.velocity.normalized() * fdrag
		var acc = GRAVITY + (fdrag_vec / atmo.mass)
		state.velocity += acc * DT
	else:
		state.velocity=Vector3.ZERO
		return
	state.position += state.velocity * real_time
	
	
		
	
	#print("velocity: ", state.velocity)
	#print("position: ", state.position)
