extends Node2D


var last_card_x: int = 0


func display_cards(cards: Array) -> void:
	for card in cards:
		add_child(card)
		card.position.x += last_card_x
		last_card_x += 88


func reset_community() -> void:
	for card in get_children():
		card.queue_free()
