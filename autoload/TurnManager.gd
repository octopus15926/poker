extends Node


var rng = RandomNumberGenerator.new()
var turn_map: Dictionary = {}
var turn_map_keys: Array
var current_player
var first_player
var current_key_position: int = 0


func set_turn_order(players: Array) -> void:
	turn_map.clear()
	turn_map_keys.clear()
	for player in players:
		turn_map[roll_for_turn_order()] = player
	turn_map.sort()
	turn_map_keys = turn_map.keys()
	set_current_player()
	first_player = current_player


func roll_for_turn_order() -> int:
	var dice_roll: int = rng.randi_range(1, 6)
	if turn_map.has(dice_roll):
		while turn_map.has(dice_roll):
			dice_roll = rng.randi_range(1, 20)
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
