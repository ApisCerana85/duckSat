class_name Controller

extends Node3D

#class Visual:
	#extends Node
	#@onready var cansat = $cansat
	#func update(state: SimState):
		#cansat.transform

var simulation: PhysicsSim
var state: SimState

@onready var hud = $Camera3D/HUD

const START_POSITION := Vector3(0.0, 2000.0, 0.0)

func _init() -> void:
	simulation = PhysicsSim.new()
	state = SimState.new()
	state.position = START_POSITION
	self.position = state.position

var accumulator := 0.0
func _process(delta):
	accumulator += delta
	
	while accumulator >= PhysicsSim.DT:
		simulation.step(state)
		accumulator -= PhysicsSim.DT
	self.position = state.position
	hud.update_data(state.position.y, state.atmo_pressure, state.velocity.length())
