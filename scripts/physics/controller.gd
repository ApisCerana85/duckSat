class_name Controller

extends Node3D

#class Visual:
	#extends Node
	#@onready var cansat = $cansat
	#func update(state: SimState):
		#cansat.transform

var instruments: VirtualInstruments

@onready var hud = $Camera3D/HUD

const START_POSITION := Vector3(0.0, 2000.0, 0.0)

func _init() -> void:
	self.instruments = VirtualInstruments.new()
	instruments.set_position(START_POSITION)
	self.position = instruments.get_position()

var accumulator := 0.0
func _process(delta):
	accumulator += delta
	
	while accumulator >= instruments.ACCEL_FREQ:
		instruments.update_accel(accumulator)
		accumulator -= instruments.ACCEL_FREQ
	self.position = instruments.get_position()
	hud.update_data(instruments.get_position().y, instruments.get_atmo_pressure(), instruments.get_speed())
