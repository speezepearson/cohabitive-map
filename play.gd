extends Node3D

var DISK_SCENE = load('res://disk.tscn') as PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	set_player_ij($Players/Boat, Vector2i(0, 0))
	set_player_ij($Players/Hermit, Vector2i(2, 0))
	set_player_ij($Players/Druid, Vector2i(-2, 1))

	for cell in $Cells.get_children():
		cell = cell as Disk
		cell.Clicked.connect(_on_disk_clicked.bind(cell))
		cell.RightClicked.connect(_on_disk_rightclicked.bind(cell))
			
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

func set_player_ij(player: Node3D, ij: Vector2i):
	player.set_meta("ij", ij)
	player.transform.origin = Hex.ij2xyz(ij)

func move_player(player: Node3D, dij: Vector2i):
	set_player_ij(player, player.get_meta("ij") + dij)

func _input(event: InputEvent):
	var player = get_selected_player()
	if player != null:
		if Input.is_action_just_pressed('upleft'): move_player(player, Hex.UPLEFT)
		if Input.is_action_just_pressed('upright'): move_player(player, Hex.UPRIGHT)
		if Input.is_action_just_pressed('left'): move_player(player, Hex.LEFT)
		if Input.is_action_just_pressed('right'): move_player(player, Hex.RIGHT)
		if Input.is_action_just_pressed('downleft'): move_player(player, Hex.DOWNLEFT)
		if Input.is_action_just_pressed('downright'): move_player(player, Hex.DOWNRIGHT)

func _process(delta):
	move_camera(delta)

enum Selection {
	NONE,
	BOAT,
	HERMIT,
	DRUID,
}
var selection = Selection.NONE

func get_selected_player() -> Node3D:
	return (
		$Players/Boat if selection == Selection.BOAT else
		$Players/Druid if selection == Selection.DRUID else
		$Players/Hermit if selection == Selection.HERMIT else
		null
	)

func _on_disk_clicked(disk: Disk):
	var disk_ij = disk.get_meta('ij') as Vector2i
	var selected_player = get_selected_player()
	if selected_player == null: return
	var player_ij = selected_player.get_meta("ij")
	if player_ij == disk_ij or Hex.get_adjacency_direction(player_ij, disk_ij) != Vector2i.ZERO:
		if (
			(selected_player == $Players/Boat)
			or (selected_player == $Players/Hermit and disk.cell_type in [Cell.Type.MOUNTAIN, Cell.Type.VOLCANO])
			or (selected_player == $Players/Druid and disk.cell_type in [Cell.Type.FOREST, Cell.Type.GRASS])
		):
			disk.flip_type()

func _on_disk_rightclicked(disk: Disk):
	var disk_ij = disk.get_meta('ij') as Vector2i
	var selected_player = get_selected_player()
	if selected_player == null: return
	var player_ij = selected_player.get_meta("ij")
	var dir = Hex.get_adjacency_direction(player_ij, disk_ij)
	if dir != Vector2i.ZERO and selected_player != null:
		if selected_player == $Players/Boat:
			var here = $Cells.get_children().filter(func(d: Disk): return d.get_meta("ij") == player_ij)
			if disk.cell_type == Cell.Type.WATER and here.front().cell_type == Cell.Type.WATER:
				move_player(selected_player, dir)
		elif (selected_player != $Players/Boat and disk.cell_type != Cell.Type.WATER):
			move_player(selected_player, dir)


func _on_boat_clicked():
	selection = Selection.BOAT


func _on_hermit_clicked():
	selection = Selection.HERMIT


func _on_druid_clicked():
	selection = Selection.DRUID
