# Basic isometric character controller. Instantly sets the speed to MAX_SPEED. No acceleration or decceleration
extends KinematicBody2D

const MAX_SPEED = 200

var speed = 0
var velocity = Vector2()
var direction = Vector2()
onready var camera = get_node("Camera")

signal move

enum Direction {TOP, RIGHT, DOWN, LEFT}

func _ready():
	set_fixed_process(true)
	set_process_input(true)
	
func _fixed_process(delta):
	var is_moving = Input.is_action_pressed("move_down") or Input.is_action_pressed("move_up") or Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right")
	if is_moving:
		speed = MAX_SPEED
		
		if Input.is_action_pressed("move_right"):
			turn_towards(RIGHT)
		elif Input.is_action_pressed("move_left"):
			turn_towards(LEFT)
		elif Input.is_action_pressed("move_up"):
			turn_towards(TOP)
		elif Input.is_action_pressed("move_down"):
			turn_towards(DOWN)
	else:
		speed = 0
	
	velocity = speed * direction * delta
	move(velocity)
	if is_moving:
		emit_signal("move")
		
func _input(event):
	if event.type == InputEvent.MOUSE_BUTTON:
		if event.button_index == BUTTON_WHEEL_UP:
			camera_zoom(-0.01)
		if event.button_index == BUTTON_WHEEL_DOWN:
			camera_zoom(0.01)
	
func camera_zoom(var delta):
	var zoom = camera.get_zoom()
	zoom[0] += delta
	zoom[1] += delta
	camera.set_zoom(zoom)
	
func turn_towards(_direction):
	if _direction == TOP:
		direction = Vector2(0, -1)
	elif _direction == DOWN:
		direction = Vector2(0, 1)
	elif _direction == LEFT:
		direction = Vector2(-1, 0)
	elif _direction == RIGHT:
		direction = Vector2(1, 0)