extends Node3D

@onready var camera = $Camera3D

const LOOK_SPEED = 0.01
const ZOOM_SPEED = 0.01

var rot_x = 0.0
var rot_y = 0.0
# var dragging_left := false
var dragging_right := false
var zoom := 0.5
func _input(event) -> void:
	# if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
	# 	if not dragging_left and event.pressed: dragging_left=true
	# 	if dragging_left and not event.pressed: dragging_left=false

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
		if not dragging_right and event.pressed: dragging_right=true
		if dragging_right and not event.pressed: dragging_right=false

	if event is InputEventMouseMotion and dragging_right:
		rot_x -= event.screen_relative.x * LOOK_SPEED
		var new_rot_y = rot_y - event.screen_relative.y * LOOK_SPEED
		if not new_rot_y > 1.5 and not new_rot_y < -1.5:
			rot_y = new_rot_y

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
		zoom += zoom*ZOOM_SPEED
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_WHEEL_UP:
		zoom -= zoom*ZOOM_SPEED
	
	transform.basis = Basis()

	camera.position.z = zoom

	self.rotate_object_local(Vector3(0, 1, 0), rot_x)
	self.rotate_object_local(Vector3(1, 0, 0), rot_y)
	#print(rot_x, rot_y)
