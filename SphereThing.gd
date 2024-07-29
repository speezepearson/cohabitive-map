extends Node3D

var Number_Generator = RandomNumberGenerator.new()

func _on_Area_input_event(camera, event, click_position, click_normal, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			self.randomize_color()


func randomize_color():
	self.Number_Generator.randomize()
	var new_red = self.Number_Generator.randf_range(0.0, 1.0)
	self.Number_Generator.randomize()
	var new_green = self.Number_Generator.randf_range(0.0, 1.0)
	self.Number_Generator.randomize()
	var new_blue = self.Number_Generator.randf_range(0.0, 1.0)
	var new_color = Vector3(new_red, new_green, new_blue).normalized()
	var x = self.get_node("SphereMesh3D") as MeshInstance3D
	var this_material = x.get_surface_override_material(0)
	this_material.albedo_color = Color(new_color.x, new_color.y, new_color.z, 1.0)


func _on_Area_3d_input_event(camera, event, position, normal, shape_idx):
	pass # Replace with function body.
