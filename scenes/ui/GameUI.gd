extends CanvasLayer


var current_player_turn: PanelContainer
var bet_entry: PanelContainer


func _ready():
	current_player_turn = $CurrentPlayerTurn
	bet_entry = $Bet
	

func update_current_player_banner() -> void:
	current_player_turn.update_current_player_name()


func show_bet_entry() -> void:
	bet_entry.visible = true


func hide_bet_entry() -> void:
	bet_entry.visible = false
