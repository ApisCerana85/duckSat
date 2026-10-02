extends CanvasLayer

var state: SimState

@onready var altitude_label: Label = $PanelContainer/MarginContainer/VBoxContainer/AltitudeValue
@onready var altitude_bar: ProgressBar = $PanelContainer/MarginContainer/VBoxContainer/AltitudeBar
@onready var pressure_label: Label = $PanelContainer/MarginContainer/VBoxContainer/PressureValue

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func update_data(altitude: float, pressure: float, speed: float) -> void:
	altitude_label.text = "altitude: %.1f m | speed %.1f m/s" %[altitude, speed]
	altitude_bar.value = clampf(altitude, 0.0, 2000.0)
	pressure_label.text = "pressure: %.2f kPa" % (pressure/1000.0)
