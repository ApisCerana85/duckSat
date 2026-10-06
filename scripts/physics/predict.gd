class_name Predictor

extends Node

@onready var prediction_line: MeshInstance3D = $PredictionLine

func predict(positions: Array[Vector3], i: int) -> Array[Vector3]:
	var result: Array[Vector3] = []

	# seperate x, y and z becouse we'll be calculating coefficients for each axis
	var x_positions: Array[float] = []
	var y_positions: Array[float] = []
	var z_positions: Array[float] = []
	for position in positions:
		x_positions.append(position.x)
		y_positions.append(position.y)
		z_positions.append(position.z)

	return positions

func draw(positions: Array[Vector3]):
	#print("drawing prediction_line")
	prediction_line.mesh.clear_surfaces()

	if positions.size() < 2:
		return
	
	prediction_line.mesh.surface_begin(Mesh.PRIMITIVE_LINE_STRIP)
	
	for position in positions:
		prediction_line.mesh.surface_add_vertex(position)
	prediction_line.mesh.surface_end()