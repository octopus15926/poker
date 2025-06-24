extends Node


var rng = RandomNumberGenerator.new()
var turn_map: Dictionary = {}
var turn_map_keys: Array
var current_player
var current_key_position: int = 0


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
	set_current_player()


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
	current_player = turn_map.get(turn_map_keys[current_key_position])


func get_current_player_name() -> StringName:
	if current_player:
		return current_player.player_name
	return ""


func move_to_next_player_turn() -> void:
	if current_key_position < turn_map_keys.size() - 1:
		current_key_position += 1
	elif current_key_position == turn_map_keys.size() - 1:
		current_key_position = 0
	set_current_player()
