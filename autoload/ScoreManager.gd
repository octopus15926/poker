extends Node


enum Hands { ROYAL_FLUSH, STRAIGHT_FLUSH, FOUR_OF_A_KIND, FULL_HOUSE, FLUSH, STRAIGHT, THREE_OF_A_KIND, TWO_PAIR, PAIR, HIGH_CARD, NONE }

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


func check_for_flush(cards: Array) -> Hands:
	print("Checking for flush")
	var clubs: Array = []
	var diamonds: Array = []
	var hearts: Array = []
	var spades: Array = []
	for card in cards:
		if card.suit == &"Clubs":
			print("Found club")
			clubs.append(card)
		elif card.suit == &"Diamonds":
			print("Found diamond")
			diamonds.append(card)
		elif card.suit == &"Hearts":
			print("found heart")
			hearts.append(card)
		elif card.suit == &"Spades":
			print("found spade")
			spades.append(card)
	var card_groups: Array = [clubs, diamonds, hearts, spades]
	for group in card_groups:
		if group.size() >= 5:
			if check_for_royal_flush(cards):
				print("Found royal flush")
				return Hands.ROYAL_FLUSH
			if check_for_straight(group):
				print("found straight flush")
				return Hands.STRAIGHT_FLUSH
			print("found regular flush")
			return Hands.FLUSH
	print("no flush found")
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
	print("Checking for royal flush")
	var ranks: Array
	for card in cards:
		ranks.append(card.rank)
	if ROYAL_FLUSH in ranks:
		print("Found royal flush in " + str(ranks))
		return true
	print("No royal flush found")
	return false


func check_for_straight(cards: Array) -> bool:
	var card_ranks = get_sorted_ranks(cards)
	print("Card ranks: " + str(card_ranks))
	var sequential_numbers: Array
	print("checking ranks")
	for i in range(1, card_ranks.size()):
		if card_ranks[i] == card_ranks[i - 1] + 1:
			print(str(card_ranks[i]) + " is equal to " + str(card_ranks[i - 1] + 1))
			print("So, a sequential number has been found")
			sequential_numbers.append(card_ranks[i])
	if sequential_numbers.size() >= 5:
		print("5 sequential numbers found - straight!")
		return true
	elif ACE_LOW_STRAIGHT in card_ranks:
		print("ace low straight found")
		return true
	print("Not enough sequential numbers for a straight in " + str(card_ranks))
	return false


func read_hand(cards: Array) -> Hands:
	print("Reading hand")
	var hand_map: Dictionary = {}
	print("Mapping cards")
	for card in cards:
		if !hand_map.has(card.rank):
			print("Additional instance of " + str(card.rank))
			hand_map[card.rank] = 1
		else:
			print("First instance of " + str(card.rank))
			hand_map[card.rank] += 1
	var pair: int = 0
	var three_of_a_kind: int = 0
	for rank in hand_map:
		if hand_map[rank] == 4:
			print("Four of a kind detected!")
			return Hands.FOUR_OF_A_KIND
		elif hand_map[rank] == 3:
			print("Three of a kind detected!")
			three_of_a_kind += 1
		elif hand_map[rank] == 2:
			print("Pair detected!")
			pair += 1
	if pair == 1 and three_of_a_kind == 1:
		print("Full house detected")
		return Hands.FULL_HOUSE
	elif pair >= 2:
		print("Two pair detected")
		return Hands.TWO_PAIR
	elif pair == 1:
		print("Pair detected!")
		return Hands.PAIR
	print("Sorry, just a high card, kid.")
	return Hands.HIGH_CARD


func get_sorted_ranks(cards: Array) -> Array:
	var card_ranks: Array
	for card in cards:
		card_ranks.append(convert_rank_stringname_to_int(card.rank))
	card_ranks.sort()
	return card_ranks


func score_hand(cards: Array) -> void:
	print("\nScoring hand!")
	var score: Hands = Hands.NONE
	score = check_for_flush(cards)
	if score == Hands.NONE:
		if check_for_straight(cards):
			score = Hands.STRAIGHT
			print("Player scored a straight")
			return
		score = read_hand(cards)
		print("\nPlayer scored: " + str(HAND_RANKINGS.get(score)))


func convert_rank_stringname_to_int(rank: StringName) -> int:
	match rank:
			&"A":
				print("Appending ace - 14")
				return 14
			&"K":
				print("Appending king - 13")
				return 13
			&"Q":
				print("appending Queen - 12")
				return 12
			&"J":
				print("appending jack - 11")
				return 11
			_:
				return int(rank)


func convert_rank_int_to_stringname(integer: int) -> StringName:
	match integer:
			14:
				print("Appending A")
				return &"A"
			13:
				print("appending K")
				return &"K"
			12:
				print("appending Q")
				return &"Q"
			11:
				print("appending J")
				return &"J"
			_:
				print(str(integer) + " doesn't need to change")
				return StringName(str(integer))
