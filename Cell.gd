extends Object
class_name Cell


const sqrt32 = sqrt(3)/2.0

func ij2xyz(ij: Vector2i) -> Vector3: return Vector3(ij.x + ij.y/2.0, 0, ij.y*sqrt32)

var UPLEFT = Vector2i(0, -1)
var UPRIGHT = Vector2i(1, -1)
var LEFT = Vector2i(-1, 0)
var RIGHT = Vector2i(1,0)
var DOWNLEFT = Vector2i(-1, 1)
var DOWNRIGHT = Vector2i(0, 1)

func neighbors(ij: Vector2i) -> Array:
	return [
		ij + UPLEFT,
		ij + UPRIGHT,
		ij + LEFT,
		ij + RIGHT,
		ij + DOWNLEFT,
		ij + DOWNRIGHT,
	]

func get_adjacency_direction(ij1: Vector2i, ij2: Vector2i) -> Vector2i:
	var delta = ij2 - ij1
	for adj in [UPLEFT, UPRIGHT, LEFT, RIGHT, DOWNLEFT, DOWNRIGHT]:
		if delta == adj: return adj
	return Vector2i.ZERO


#########################################

enum Type {
	MOUNTAIN,
	VOLCANO,
	WATER,
	ICE,
	GRASS,
	FOREST,
}

const type_inverses = {
	Type.MOUNTAIN: Type.VOLCANO,
	Type.VOLCANO: Type.MOUNTAIN,
	Type.WATER: Type.ICE,
	Type.ICE: Type.WATER,
	Type.GRASS: Type.FOREST,
	Type.FOREST: Type.GRASS,
}

static func random_type():
	match RandomNumberGenerator.new().randi_range(1, 6):
		1: return Type.MOUNTAIN
		2: return Type.VOLCANO
		3: return Type.WATER
		4: return Type.ICE
		5: return Type.GRASS
		6: return Type.FOREST
