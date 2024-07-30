extends Node3D

var DISK_SCENE = load('res://disk.tscn') as PackedScene

const sqrt32 = sqrt(3)/2.0

func ij2xyz(ij: Vector2i) -> Vector3: return Vector3(ij.x + ij.y/2.0, 0, ij.y*sqrt32)

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(-2, 3):
		for j in range(-2, 3):
			# Instance the scene
			var instance = DISK_SCENE.instantiate()
			
			# Set the transform (position, rotation, scale) for each instance
			var transform = Transform3D()
			transform = transform.scaled(Vector3(.9, .9, .9))
			transform.origin = ij2xyz(Vector2i(i, j))
			
			instance.transform = transform
			
			# Add the instance to the current scene
			add_child(instance)
			
	get_player().transform.origin = ij2xyz(Vector2i.ZERO) + Vector3(0,0.2,0)

func get_player() -> Node3D: return $Player
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

var player_ij = Vector2i(0, 0)
func move_player(dij: Vector2i):
	player_ij += dij
	get_player().transform.origin = ij2xyz(player_ij)

var UPLEFT = Vector2i(0, -1)
var UPRIGHT = Vector2i(1, -1)
var LEFT = Vector2i(-1, 0)
var RIGHT = Vector2i(1,0)
var DOWNLEFT = Vector2i(-1, 1)
var DOWNRIGHT = Vector2i(0, 1)

func _input(event: InputEvent):
	if Input.is_action_just_pressed('upleft'): move_player(UPLEFT)
	if Input.is_action_just_pressed('upright'): move_player(UPRIGHT)
	if Input.is_action_just_pressed('left'): move_player(LEFT)
	if Input.is_action_just_pressed('right'): move_player(RIGHT)
	if Input.is_action_just_pressed('downleft'): move_player(DOWNLEFT)
	if Input.is_action_just_pressed('downright'): move_player(DOWNRIGHT)

func _process(delta):
	move_camera(delta)
