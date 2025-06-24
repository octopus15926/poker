extends CenterContainer


func update_bet_amount() -> void:
	var temporary_text = %BetAmountLabel.text.erase(0)
	print(temporary_text)
	var number = int(temporary_text) + BetManager.winnings
	%BetAmountLabel.text = &"$" + str(number)
