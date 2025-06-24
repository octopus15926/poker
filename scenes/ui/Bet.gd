extends PanelContainer


@onready var enter_bet: LineEdit = $VBoxContainer/EnterBet
@onready var submit_bet: Button = $VBoxContainer/SubmitBet


func _ready() -> void:
	self.submit_bet.connect("pressed", func(): _on_submit_bet_pressed())
	self.enter_bet.connect("text_changed", func(new_text: String): _on_text_changed(new_text))


func _on_submit_bet_pressed() -> void:
	print(str(enter_bet.text) + " has been bet")
	#BetManager.take_bet(TurnManager.current_player, int(enter_bet.text))


func _on_text_changed(new_text: String) -> void:
	var validated_text = ""
	for character in new_text:
		if character.is_valid_int():
			validated_text += character
	enter_bet.text = validated_text
	enter_bet.caret_column = enter_bet.text.length()
