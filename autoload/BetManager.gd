extends Node


var bet_pool: Array [Bet]
var winnings: int = 0


# TODO decide if bet pool is even necessary
func take_bet(player: Player, bet_amount: int) -> void:
	if bet_amount > player.chips:
		bet_amount = min(bet_amount, player.chips)
	if player.chips >= bet_amount:
		player.chips -= bet_amount
		var player_bet: Bet = Bet.new(player, bet_amount)
		bet_pool.append(player_bet)
	winnings += bet_amount


func divide_winnings(winners: Array) -> void:
	var number_of_winners: int = winners.size()
	var winnings_amount: int = winnings % number_of_winners
	winnings -= winnings_amount
	for winner in winners:
		winner.chips += winnings
