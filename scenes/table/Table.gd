extends Node


var game_ui: CanvasLayer
var seats: Node
var dealer: Node


func _ready() -> void:
	seats = $Seats
	seats.player_selected.connect(func(): on_player_selected())
	seats.player_ended_turn.connect(func(): on_player_ended_turn())
	dealer = $Dealer
	game_ui = $GameUI


func on_player_selected() -> void:
	dealer.deal_community()
	if TurnManager.current_player.get_player_type_stringname() == &"Human":
		game_ui.show_bet_entry()


func on_player_ended_turn() -> void:
	TurnManager.move_to_next_player_turn()
	if TurnManager.current_player == TurnManager.first_player:
		dealer.deal_community()
	dealer.take_bets()
	game_ui.update_bet_pool()
	game_ui.update_current_player_banner()
	game_ui.hide_bet_entry()
