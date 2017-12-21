extends Node2D

onready var fps_label = get_node('FPS')

func _ready():
	set_process(true)

func _process(delta):
	fps_label.set_text(str(OS.get_frames_per_second()))