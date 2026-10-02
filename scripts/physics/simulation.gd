## here all of the simulation comes together

class_name PhysicsSim

const DT := 0.005 # 200hz (1/200s) # delta time
const GRAVITY := Vector3.DOWN * 9.80665

var atmo := Atmoshpere.new()

func step(state: SimState):
	var real_time = DT * state.timewarp
	
	state.atmo_density = atmo.density(state.position.y)
	state.atmo_pressure = atmo.pressure(state.position.y)
	
	var drag_force: Vector3 = atmo.drag_force(state.velocity, Vector3(0.1, 0.0, 3.0), state.atmo_density)
	state.velocity = GRAVITY * atmo.mass + drag_force
	if (state.position+state.velocity*real_time).y <= 0:
		state.velocity=Vector3.ZERO
		return
	
	state.position += state.velocity * real_time
	
	#print("velocity: ", state.velocity)
	#print("position: ", state.position)
