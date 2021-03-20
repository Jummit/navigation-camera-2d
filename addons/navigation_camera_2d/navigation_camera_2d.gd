extends Camera2D
class_name NavigationCamera2D, "navigation_camera_2d_icon.svg"

"""
A camera that can be controlled with the mouse and the keyboard

Can be moved by dragging with the middle mouse button pressed or with the WASD keys.
"""

export var SPEED := 20.0
export var min_camera_zoom := .3
export var max_camera_zoom := 2.5

func _ready() -> void:
	set_process(InputMap.has_action("camera_up"))


func _process(_delta):
	var movement := Vector2()
	if Input.is_action_pressed("camera_up"):
		movement.y = -1
	if Input.is_action_pressed("camera_down"):
		movement.y = 1
	if Input.is_action_pressed("camera_left"):
		movement.x = -1
	if Input.is_action_pressed("camera_right"):
		movement.x = 1
	
	position += movement * SPEED


func _unhandled_input(event):
	if event is InputEventMouseMotion:
		if event.button_mask == BUTTON_MASK_MIDDLE:
			position -= event.relative * zoom
			get_tree().set_input_as_handled()
	
	if event.is_action_pressed("zoom_in"):
		change_zoom(0.9)
	elif event.is_action_pressed("zoom_out"):
		change_zoom(1.1)


func change_zoom(amount : float) -> void:
	zoom *= amount
	zoom.x = clamp(zoom.x, min_camera_zoom, max_camera_zoom)
	zoom.y = clamp(zoom.y, min_camera_zoom, max_camera_zoom)
