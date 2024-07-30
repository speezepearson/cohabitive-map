extends Node3D

var DISK_SCENE = load('res://disk.tscn') as PackedScene

var disk_posns = {}
func add_disk(ij: Vector2i, disk: Disk):
	disk_posns[disk] = ij
	var transform = Transform3D()
	transform = transform.scaled(Vector3(.9, .9, .9))
	transform.origin = Hex.ij2xyz(ij)
	disk.transform = transform
	add_child(disk)

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(-1, 2):
		for j in range(-1, 2):
			var ij = Vector2i(i,j)
			var instance = DISK_SCENE.instantiate() as Disk
			instance.Clicked.connect(_on_disk_clicked.bind(instance))
			add_disk(ij, instance)
			
	get_player().transform.origin = Hex.ij2xyz(Vector2i.ZERO) + Vector3(0,0.2,0)

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
	get_player().transform.origin = Hex.ij2xyz(player_ij)

func _input(event: InputEvent):
	if selection == Selection.PLAYER:
		if Input.is_action_just_pressed('upleft'): move_player(Hex.UPLEFT)
		if Input.is_action_just_pressed('upright'): move_player(Hex.UPRIGHT)
		if Input.is_action_just_pressed('left'): move_player(Hex.LEFT)
		if Input.is_action_just_pressed('right'): move_player(Hex.RIGHT)
		if Input.is_action_just_pressed('downleft'): move_player(Hex.DOWNLEFT)
		if Input.is_action_just_pressed('downright'): move_player(Hex.DOWNRIGHT)

func _process(delta):
	move_camera(delta)

enum Selection {
	NONE,
	PLAYER,
	# TODO: DISK(Disk)?
}
var selection = Selection.NONE

func _on_player_clicked():
	selection = Selection.PLAYER
	
func _on_disk_clicked(disk: Disk):
	var disk_posn = disk_posns[disk]
	if player_ij == disk_posn:
		disk.flip_type()
	var dir = Hex.get_adjacency_direction(player_ij, disk_posn)
	if dir != Vector2i.ZERO:
		move_player(dir)
