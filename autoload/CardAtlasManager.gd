extends Node

const CARD_TEXTURE_ATLAS: AtlasTexture = preload("res://assets/cards/CardAtlas.tres")
const CARD_WIDTH: int = 42
const CARD_HEIGHT: int = 60
const OFFSET: int = 1
const BLANK_CARD_REGION: Rect2 = Rect2(560.0, 62.0, 42.0, 60.0)

var region_map: Dictionary = {}


func _ready():
	generate_regions()


func generate_regions() -> void:
	region_map.clear()
	var suits: Array = CardProperties.SUITS
	var ranks: Array = CardProperties.RANKS
	for suit in range(suits.size()):
		for rank in range(ranks.size()):
			var x_region = (CARD_WIDTH * rank) + rank + OFFSET
			if ranks[rank] == &"A":
				x_region = 1
			var y_region = (CARD_HEIGHT * suit) + suit + (OFFSET * 2)
			var card_region = Rect2(x_region, y_region, CARD_WIDTH, CARD_HEIGHT)
			var card_id = StringName(ranks[rank] + suits[suit])
			
			region_map[card_id] = card_region


func get_region_from_map(card_id: StringName) -> Rect2:
	return region_map.get(card_id)
