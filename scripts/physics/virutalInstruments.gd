extends Node

class_name VirtualInstruments

class SimState:
	var position := Vector3.ZERO
	var velocity := Vector3.ZERO
	var atmo_density := 0.0
	var atmo_pressure := 0.0
	var timewarp := 1.0
	
	var update_count: int = 0

class Atmo:
	const SEA_LEVEL_DENSITY := 1.255 #kg/m^3
	const DENSITY_SCALE_HEIGHT := 8500.0 # frankly i still dont know what is it
	const SEA_LEVEL_PRESSURE := 101325.0
	const PRESSURE_SCALE_HEIGHT := 8434.0
	const MASS := 0.3 # kg
	const DRAG_COEFFICIENT := 0.82
	const AREA := PI * (0.033**2)
	func density(altitude: float) -> float:
		return Atmo.SEA_LEVEL_DENSITY * exp(-altitude / Atmo.DENSITY_SCALE_HEIGHT)
		
	func pressure(altitude: float) -> float:
		return Atmo.SEA_LEVEL_PRESSURE * exp(-altitude / Atmo.PRESSURE_SCALE_HEIGHT)
		
	func drag_force(velocity: Vector3, wind: Vector3, air_density: float) -> Vector3:
		var relative_velocity = velocity-wind # the wind should get the fuck out i think but ok :D
		var speed := relative_velocity.length()

		#something new... i dont know if its correct and if it even should be here
		#var relative_velocity_max = sqrt(relative_velocity.x**2 + relative_velocity.y**2 + relative_velocity.z**2)
		
		if speed==0.0: return Vector3.ZERO
		return -0.5 * air_density * DRAG_COEFFICIENT * AREA * speed * relative_velocity

var state: SimState
var atmo: Atmo

const GRAVITY := Vector3.DOWN * 9.80665

# frequencies that each instrument should be updated at
const GPS_FREQ := 1.0 # 1hz
const ACCEL_FREQ := 1.0/200.0 #200hz
const GYRO_FREQ := 1.0/100.0 #100hz

const ACCEL_ERROR := 0.01

# Called when the node enters the scene tree for the first time.
func _init() -> void:
	self.state = SimState.new()
	self.atmo = Atmo.new()

func update_accel(delta: float):
	#delta means "delta time" so the same as DT in previous versions
	#REMEMBER TO MULTIPLY TIMES delta WHERE THERES A second AS A UNIT

	#just save the current atmospheric data so it can be read in other places (not important for calculating acceleration)
	state.atmo_density = atmo.density(state.position.y)
	state.atmo_pressure = atmo.pressure(state.position.y)
	
	var wind: Vector3 = Vector3(0.1, 0.0, 3.0) # TODO: make variable as altitude gets lower

	var drag_force: Vector3 = atmo.drag_force(state.velocity, wind, state.atmo_density)

	#calculates the velocity
	state.velocity += (GRAVITY * atmo.MASS + drag_force) * delta # TODO: add random error so it becomes realistic
	
	var v_term = sqrt((atmo.MASS * GRAVITY.y)* 2 / drag_force.y ) # terminal velocity
	print(v_term)  ##if you want to check max velocity

	#just checks if we'll hit the floor and stops if neccessary
	if (state.position+state.velocity*delta).y <= 0:
		state.velocity=Vector3.ZERO
		return
	

	state.position += state.velocity * delta
	
	if state.update_count < 4: state.update_count+=1 # use for counting the updates
	#print("velocity: ", state.velocity)
	#print("position: ", state.position)

func update_gps():
	self.position = get_position() # TODO: add error

func get_position() -> Vector3:
	return self.state.position
func get_velocity() -> Vector3:
	return self.state.velocity
func get_speed() -> float:
	return self.state.velocity.length()
func get_atmo_pressure() -> float:
	return self.state.atmo_pressure

func set_position(position: Vector3):
	self.state.position=position
