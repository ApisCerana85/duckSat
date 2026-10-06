class_name Controller

extends Node3D

#class Visual:
	#extends Node
	#@onready var cansat = $cansat
	#func update(state: SimState):
		#cansat.transform

var instruments: VirtualInstruments
@onready var predict = $Predictor

@onready var hud = $CameraPivot/Camera3D/HUD

const START_POSITION := Vector3(0.0, 2000.0, 0.0)

func _init() -> void:
	self.instruments = VirtualInstruments.new()
	instruments.set_position(START_POSITION)
	self.position = instruments.get_position()

	self.predict = Predictor.new()

var accumulator := 0.0
var positions: Array[Vector3] = [START_POSITION]
func _process(delta):
	accumulator += delta
	
	while accumulator >= instruments.ACCEL_FREQ:
		instruments.update_accel(accumulator)
		if instruments.get_update_count() == 4:
			positions.append(instruments.get_position())
			predict.draw(predict.predict(positions, 20))
		accumulator -= instruments.ACCEL_FREQ
	
	self.position = instruments.get_position()
	hud.update_data(instruments.get_position().y, instruments.get_atmo_pressure(), instruments.get_speed())
