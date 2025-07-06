extends Node


@onready var community: Node2D = $/root/Table/Community
@onready var game_ui: CanvasLayer = $/root/Table/GameUI

var card_list: Array [CardData]
var card_scene: PackedScene = preload("res://scenes/card/Card.tscn")
var cards_dealt_to_community: int = 0


func take_bets() -> void:
	if TurnManager.current_player.get_player_type_stringname() == &"Human":
		get_parent().game_ui.show_bet_entry()
	else:
		CpuPlayerManager.make_bet(TurnManager.current_player)
	


func _ready() -> void:
	generate_card_list()
	card_list.shuffle()
	iterate_through_players_and_deal_them_cards()
	game_ui.update_current_player_banner()


func score_hands() -> void:
	for key in TurnManager.turn_map_keys:
		var player: Player = TurnManager.turn_map.get(key)
		var community_cards: Array = community.get_children()
		var player_hand: Array = TurnManager.turn_map.get(key).get_hand()
		var hand_to_score: Array = community_cards + player_hand
		ScoreManager.score_hand(hand_to_score, player)
	var winners: Array = ScoreManager.get_winning_hand()
	for winner in winners:
		winner.show_outline()


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
	player.pick_up_cards(deal_cards(number_of_cards))


func iterate_through_players_and_deal_them_cards() -> void:
	for key in TurnManager.turn_map_keys:
		deal_player_hand(TurnManager.turn_map.get(key), 2)
