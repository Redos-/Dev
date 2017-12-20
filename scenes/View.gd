# Custom camera
extends Node

# Getting globals (values from the Scene menu -> Project Settings). An alternative is OS.get_window_size()
onready var screen_size = Vector2(Globals.get("display/width"), Globals.get("display/height")) 
onready var player = get_node("Player")

func update_camera():
	var viewport = get_viewport()
	var canvas_transform = viewport.get_canvas_transform()
	# canvas_transform is of type Matrix32. That's an array of 3 Vector2, and canvas_transform[2] controls the canvas's offset.
	# Moving a camera isn't moving a camera per se, instead we move the canvas (all the sprites) under the camera. That's why we use -1*player.get_pos()
	canvas_transform[2] = -player.get_pos() + screen_size / 2
	viewport.set_canvas_transform(canvas_transform)

func _ready():
	pass

func _on_Player_move():
	pass