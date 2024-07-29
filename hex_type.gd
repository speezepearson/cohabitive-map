extends Object
class_name HexTypeLib

enum HexType {
	MOUNTAIN,
	VOLCANO,
	WATER,
	ICE,
	GRASS,
	FOREST,
}

const inverses = {
	HexType.MOUNTAIN: HexType.VOLCANO,
	HexType.VOLCANO: HexType.MOUNTAIN,
	HexType.WATER: HexType.ICE,
	HexType.ICE: HexType.WATER,
	HexType.GRASS: HexType.FOREST,
	HexType.FOREST: HexType.GRASS,
}

static func random_type():
	match RandomNumberGenerator.new().randi_range(1, 6):
		1: return HexTypeLib.HexType.MOUNTAIN
		2: return HexTypeLib.HexType.VOLCANO
		3: return HexTypeLib.HexType.WATER
		4: return HexTypeLib.HexType.ICE
		5: return HexTypeLib.HexType.GRASS
		6: return HexTypeLib.HexType.FOREST
