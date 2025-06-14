extends Node


@onready var community: Node2D = $/root/Table/Community

var card_list: Array [CardData]
var card_scene: PackedScene = preload("res://scenes/card/Card.tscn")
var cards_dealt_to_community: int = 0
# deal 2 cards to each player
# take bets
# deal flop (3 community cards)
# take bets
# deal turn (1 community card)
# take bets
# deal river (1 community card)
# take bets
# score hands
# give rewards


func run_a_game_of_poker() -> void:
	pass


func take_bets() -> void:
	for key in TurnManager.turn_map_keys:
		TurnManager.turn_map.get(key)


func _ready() -> void:
	generate_card_list()
	card_list.shuffle()
	iterate_through_players_and_deal_them_cards()
	deal_community()
	deal_community()
	deal_community()
	for key in TurnManager.turn_map_keys:
		var community_cards: Array = community.get_children()
		var player_hand: Array = TurnManager.turn_map.get(key).get_hand()
		var hand_to_score: Array = community_cards + player_hand
		print("Scoring " + str(TurnManager.turn_map.get(key).player_name))
		print("A total of " + str(hand_to_score.size()) + " cards")
		ScoreManager.score_hand(hand_to_score)


func generate_card_list() -> void:
	card_list.clear()
	for rank in CardProperties.RANKS:
		for suit in CardProperties.SUITS:
			if rank and suit:
				card_list.append(CardData.new(rank, suit))


func deal_community() -> void:
	if cards_dealt_to_community == 0:
		var community_cards: Array = deal_cards(3)
		community.display_cards(community_cards)
		cards_dealt_to_community += 3
	elif cards_dealt_to_community == 3:
		var community_cards: Array = deal_cards(1)
		community.display_cards(community_cards)
		cards_dealt_to_community += 1
	elif cards_dealt_to_community == 4:
		var community_cards: Array = deal_cards(1)
		community.display_cards(community_cards)
		cards_dealt_to_community += 1
	

func deal_cards(number_of_cards: int) -> Array:
	var cards_to_deal: Array [Card]
	for i in range(0, number_of_cards):
		var card: Card = card_scene.instantiate()
		card.make_card_ready(card_list.pop_back())
		cards_to_deal.append(card)
	return cards_to_deal


func deal_player_hand(player: Player, number_of_cards: int) -> void:
	print("dealing " + str(number_of_cards) + " to " + player.player_name)
	player.pick_up_cards(deal_cards(number_of_cards))


func iterate_through_players_and_deal_them_cards() -> void:
	for key in TurnManager.turn_map_keys:
		deal_player_hand(TurnManager.turn_map.get(key), 2)
