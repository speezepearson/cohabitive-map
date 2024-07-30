extends Node3D

@export var hex_type: HexTypeLib.HexType
var material: Material

const hex_type_colors = {
	HexTypeLib.HexType.MOUNTAIN: Color(0.5, 0.5, 0.5, 1.0),
	HexTypeLib.HexType.VOLCANO:  Color(0.8, 0.5, 0.5, 1.0),
	HexTypeLib.HexType.WATER:    Color(0.0, 0.3, 1.0, 1.0),
	HexTypeLib.HexType.ICE:      Color(0.5, 0.8, 1.0, 1.0),
	HexTypeLib.HexType.GRASS:    Color(0.5, 1.0, 0.5, 1.0),
	HexTypeLib.HexType.FOREST:   Color(0.0, 0.5, 0.0, 1.0),
}

func set_hex_type(t: HexTypeLib.HexType):
	self.hex_type = t
	self.material.albedo_color = hex_type_colors[self.hex_type]
	
func get_mesh() -> MeshInstance3D: return $SphereMesh3D

func _ready():
	# duplicate override material so we can edit it without affecting all instances
	self.material = get_mesh().get_surface_override_material(0).duplicate()
	get_mesh().set_surface_override_material(0, self.material)

	set_hex_type(HexTypeLib.random_type())

func _on_Area_input_event(camera, event, click_position, click_normal, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			set_hex_type(HexTypeLib.inverses[self.hex_type])
