class_name Card
extends GameObject


const RED = &"Red"
const BLACK = &"Black"
const HEARTS = CardProperties.SUITS[0]
const DIAMONDS = CardProperties.SUITS[1]
const CLUBS = CardProperties.SUITS[2]
const SPADES = CardProperties.SUITS[3]


var card_data: CardData
var rank: StringName
var suit: StringName
var card_id: StringName
var color: StringName = BLACK
var is_face_up: bool = false
var outline: Sprite2D


func set_object_size() -> void:
	normal_size = GameObjectProperties.NORMAL_CARD_SIZE
	expanded_size = GameObjectProperties.EXPANDED_CARD_SIZE


func make_card_ready(new_card_data: CardData) -> void:
	selectable = false
	card_data = new_card_data
	rank = card_data.rank
	suit = card_data.suit
	if suit == HEARTS or suit == DIAMONDS:
		color = RED
	card_id = StringName(rank + suit)
	texture = CardAtlasManager.CARD_TEXTURE_ATLAS
	region_enabled = true
	if is_face_up:
		region_rect = CardAtlasManager.get_region_from_map(card_id)
	else:
		region_rect = CardAtlasManager.BLANK_CARD_REGION
	outline = $Outline


func flip() -> void:
	region_rect = CardAtlasManager.get_region_from_map(card_id)
	is_face_up = true


func show_outline() -> void:
	outline.visible = true
