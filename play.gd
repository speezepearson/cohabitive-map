extends Node3D

var DISK_SCENE = load('res://disk.tscn') as PackedScene

const sqrt32 = sqrt(3)/2.0

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(-2, 3):
		for j in range(-2, 3):
			# Instance the scene
			var instance = DISK_SCENE.instantiate()
			
			# Set the transform (position, rotation, scale) for each instance
			var transform = Transform3D()
			transform = transform.scaled(Vector3(.9, .9, .9))
			transform.origin = Vector3(i + j/2.0, 0, j*sqrt32)
			
			instance.transform = transform
			
			# Add the instance to the current scene
			add_child(instance)

func get_camera() -> Camera3D: return $Camera3D

const CAMERA_SPEED = 3
func move_camera(dt):
	if Input.is_key_pressed(KEY_LEFT):
		get_camera() .transform.origin.x -= CAMERA_SPEED*dt
	if Input.is_key_pressed(KEY_RIGHT):
		get_camera().transform.origin.x += CAMERA_SPEED*dt
	if Input.is_key_pressed(KEY_UP):
		get_camera().transform.origin.z -= CAMERA_SPEED*dt
	if Input.is_key_pressed(KEY_DOWN):
		get_camera().transform.origin.z += CAMERA_SPEED*dt

func _process(delta):
	move_camera(delta)
