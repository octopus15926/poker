extends Node


var rng = RandomNumberGenerator.new()
var turn_map: Dictionary = {}
var turn_map_keys: Array
var current_player


func set_turn_order(players: Array) -> void:
	print(players.size())
	turn_map.clear()
	turn_map_keys.clear()
	for player in players:
		turn_map[roll_for_turn_order()] = player
	turn_map.sort()
	turn_map_keys = turn_map.keys()
	print(turn_map_keys)
	print(turn_map)


func roll_for_turn_order() -> int:
	var dice_roll: int = rng.randi_range(1, 6)
	print("Rolled: " + str(dice_roll))
	if turn_map.has(dice_roll):
		print("oops, rerolling: " + str(dice_roll))
		while turn_map.has(dice_roll):
			dice_roll = rng.randi_range(1, 20)
			print("rolled " + str(dice_roll) + " this time!")
	return dice_roll
		


func set_current_player() -> void:
	current_player = turn_map.get(turn_map.keys()[0])
