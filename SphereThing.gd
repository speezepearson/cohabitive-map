extends Node3D
class_name Disk

signal Clicked
signal RightClicked

@export var cell_type: Cell.Type
var material: Material

const cell_type_colors = {
	Cell.Type.MOUNTAIN: Color(0.5, 0.5, 0.5, 1.0),
	Cell.Type.VOLCANO:  Color(0.8, 0.5, 0.5, 1.0),
	Cell.Type.WATER:    Color(0.0, 0.3, 1.0, 1.0),
	Cell.Type.ICE:      Color(0.5, 0.8, 1.0, 1.0),
	Cell.Type.GRASS:    Color(0.5, 1.0, 0.5, 1.0),
	Cell.Type.FOREST:   Color(0.0, 0.5, 0.0, 1.0),
}

func flip_type():
	set_cell_type(Cell.type_inverses[self.cell_type])

func set_cell_type(t: Cell.Type):
	self.cell_type = t
	self.material.albedo_color = cell_type_colors[self.cell_type]
	
func get_mesh() -> MeshInstance3D: return $SphereMesh3D

func _ready():
	# duplicate override material so we can edit it without affecting all instances
	self.material = get_mesh().get_surface_override_material(0).duplicate()
	get_mesh().set_surface_override_material(0, self.material)

	set_cell_type(Cell.random_type())

func _on_Area_input_event(camera, event, click_position, click_normal, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			Clicked.emit()
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			RightClicked.emit()
