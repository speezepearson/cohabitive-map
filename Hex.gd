extends Object
class_name Hex


const sqrt32 = sqrt(3)/2.0

static func ij2xyz(ij: Vector2i) -> Vector3:
	return Vector3(
		ij.x - ij.y/2.0, 0,
		ij.y*sqrt32,
	)

const UPLEFT = Vector2i(0, -1)
const UPRIGHT = Vector2i(1, 1)
const LEFT = Vector2i(-1, 0)
const RIGHT = Vector2i(1,0)
const DOWNLEFT = Vector2i(-1, -1)
const DOWNRIGHT = Vector2i(0, 1)

static func neighbors(ij: Vector2i) -> Array:
	return [
		ij + UPLEFT,
		ij + UPRIGHT,
		ij + LEFT,
		ij + RIGHT,
		ij + DOWNLEFT,
		ij + DOWNRIGHT,
	]

static func get_adjacency_direction(ij1: Vector2i, ij2: Vector2i) -> Vector2i:
	var delta = ij2 - ij1
	for adj in [UPLEFT, UPRIGHT, LEFT, RIGHT, DOWNLEFT, DOWNRIGHT]:
		if delta == adj: return adj
	return Vector2i.ZERO
