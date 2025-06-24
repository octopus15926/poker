extends CanvasLayer


var current_player_turn: PanelContainer
var bet_entry: PanelContainer
var bet_pool: CenterContainer


func _ready():
	current_player_turn = $CurrentPlayerTurn
	bet_entry = $Bet
	bet_pool = $CurrentBetPool
	

func update_current_player_banner() -> void:
	current_player_turn.update_current_player_name()


func update_bet_pool() -> void:
	bet_pool.update_bet_amount()


func show_bet_entry() -> void:
	bet_entry.visible = true


func hide_bet_entry() -> void:
	bet_entry.visible = false
