extends PanelContainer


var label: Label


func _ready():
	label = $CenterContainer/Label


func update_current_player_name() -> void:
	label.text = str(TurnManager.get_current_player_name()) + "'s turn"
	if TurnManager.current_player.get_player_type_stringname() == &"Human":
		get_parent().show_bet_entry()
	elif TurnManager.current_player.get_player_type_stringname() == &"CPU":
		get_parent().hide_bet_entry()
