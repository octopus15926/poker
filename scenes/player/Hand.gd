extends Node


func flip_cards() -> void:
	var cards: Array = get_children()
	if cards:
		for card in cards:
			card.flip()
			make_cards_selectable()


func get_card_data_array() -> Array [CardData]:
	var card_data_array: Array
	var cards: Array = get_children()
	if cards:
		for card in cards:
			card_data_array.append(card.card_data)
	return card_data_array


func make_cards_selectable() -> void:
	var cards: Array = get_children()
	if cards:
		for card in cards:
			card.selectable = true
