extends PanelContainer


@onready var bet_amount_label: Label = $CenterContainer/Label


func update_bet_amount() -> void:
	bet_amount_label.text = &"$" + str(BetManager.winnings)
