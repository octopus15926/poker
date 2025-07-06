extends Node


enum Hands { 
	ROYAL_FLUSH, 
	STRAIGHT_FLUSH, 
	FOUR_OF_A_KIND, 
	FULL_HOUSE, 
	FLUSH, 
	STRAIGHT, 
	THREE_OF_A_KIND, 
	TWO_PAIR, 
	PAIR, 
	HIGH_CARD, 
	NONE
	}

const HAND_RANKINGS: Dictionary = {
	Hands.ROYAL_FLUSH: 10,
	Hands.STRAIGHT_FLUSH: 9,
	Hands.FOUR_OF_A_KIND: 8,
	Hands.FULL_HOUSE: 7,
	Hands.FLUSH: 6,
	Hands.STRAIGHT: 5,
	Hands.THREE_OF_A_KIND: 4,
	Hands.TWO_PAIR: 3,
	Hands.PAIR: 2,
	Hands.HIGH_CARD: 1
}

const ACE_LOW_STRAIGHT: Array = [14, 2, 3, 4, 5]
const ROYAL_FLUSH: Array = [&"A", &"K", &"Q", &"J", &"10"]


var player_score_map: Dictionary = {}
var player_hand_map: Dictionary = {}


func check_for_flush(cards: Array) -> Hands:
	var clubs: Array = []
	var diamonds: Array = []
	var hearts: Array = []
	var spades: Array = []
	for card in cards:
		if card.suit == &"Clubs":
			clubs.append(card)
		elif card.suit == &"Diamonds":
			diamonds.append(card)
		elif card.suit == &"Hearts":
			hearts.append(card)
		elif card.suit == &"Spades":
			spades.append(card)
	var card_groups: Array = [clubs, diamonds, hearts, spades]
	for group in card_groups:
		if group.size() >= 5:
			if check_for_royal_flush(cards):
				return Hands.ROYAL_FLUSH
			if check_for_straight(group):
				return Hands.STRAIGHT_FLUSH
			return Hands.FLUSH
	if clubs.size() > 1:
		for c in clubs:
			print(c.card_id)
	if diamonds.size() > 1:
		for d in diamonds:
			print(d.card_id)
	if hearts.size() > 1:
		for h in hearts:
			print(h.card_id)
	if spades.size() > 1:
		for s in spades:
			print(s.card_id)
	return Hands.NONE


func check_for_royal_flush(cards: Array) -> bool:
	var ranks: Array
	for card in cards:
		ranks.append(card.rank)
	if ROYAL_FLUSH in ranks:
		return true
	return false


func check_for_straight(cards: Array) -> bool:
	var card_ranks = get_sorted_ranks(cards)
	var sequential_numbers: Array
	for i in range(1, card_ranks.size()):
		if card_ranks[i] == card_ranks[i - 1] + 1:
			sequential_numbers.append(card_ranks[i])
	if sequential_numbers.size() >= 5:
		return true
	elif ACE_LOW_STRAIGHT in card_ranks:
		return true
	return false


func read_hand(cards: Array) -> Hands:
	var hand_map: Dictionary = {}
	for card in cards:
		if !hand_map.has(card.rank):
			hand_map[card.rank] = 1
		else:
			hand_map[card.rank] += 1
	var pair: int = 0
	var three_of_a_kind: int = 0
	for rank in hand_map:
		if hand_map[rank] == 4:
			return Hands.FOUR_OF_A_KIND
		elif hand_map[rank] == 3:
			three_of_a_kind += 1
		elif hand_map[rank] == 2:
			pair += 1
	if pair == 1 and three_of_a_kind == 1:
		return Hands.FULL_HOUSE
	elif pair >= 2:
		return Hands.TWO_PAIR
	elif pair == 1:
		return Hands.PAIR
	return Hands.HIGH_CARD


func get_sorted_ranks(cards: Array) -> Array:
	var card_ranks: Array
	for card in cards:
		card_ranks.append(convert_rank_stringname_to_int(card.rank))
	card_ranks.sort()
	return card_ranks


func score_hand(cards: Array, player: Player) -> void:
	var score: Hands = Hands.NONE
	score = check_for_flush(cards)
	if score == Hands.NONE:
		if check_for_straight(cards):
			score = Hands.STRAIGHT
			return
		score = read_hand(cards)
	map_hand_score(HAND_RANKINGS.get(score), cards, player)


# TODO add player objects to the map instead of names so you can highlight all their cards
func map_hand_score(hand_score: int, cards: Array, player: Player) -> void:
	if player_hand_map.has(hand_score):
		player_hand_map[hand_score] += cards
	else:
		player_hand_map[hand_score] = cards
	if !player_score_map.has(hand_score):
		player_score_map[hand_score] = [player]
	else:
		player_score_map[hand_score].append(player)

func get_winning_hand() -> Array:
	var player_hand_map_keys: Array = player_hand_map.keys()
	player_hand_map_keys.sort()
	return player_hand_map.get(player_hand_map_keys[-1])


func convert_rank_stringname_to_int(rank: StringName) -> int:
	match rank:
			&"A":
				return 14
			&"K":
				return 13
			&"Q":
				return 12
			&"J":
				return 11
			_:
				return int(rank)


func convert_rank_int_to_stringname(integer: int) -> StringName:
	match integer:
			14:
				return &"A"
			13:
				return &"K"
			12:
				return &"Q"
			11:
				return &"J"
			_:
				return StringName(str(integer))
