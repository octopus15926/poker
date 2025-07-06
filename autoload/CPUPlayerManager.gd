extends Node


func make_bet(cpu_player: Player) -> void:
	print(cpu_player.player_name + &" makes a bet of " + str(floor(cpu_player.chips/4.0)) + &"!")
	BetManager.take_bet(cpu_player, floor(cpu_player.chips/4.0))
	cpu_player.finish_turn()
