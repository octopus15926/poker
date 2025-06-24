extends Node


signal player_selected


# NOTE: Temporary const
const player_names: Array [StringName] = [&"Bananas", &"Cherries", &"Grapes", &"Orange"]
var available_seats: Array [Node]
var player: PackedScene = preload("res://scenes/player/Player.tscn")


func _ready() -> void:
	available_seats = get_children()
	create_players()
	seat_players()
	TurnManager.set_current_player()


func create_players(_number_of_players: int = 4) -> void:
	var players: Array [Player]
	for player_name in player_names:
		var new_player = player.instantiate()
		new_player.custom_init(player_name, "CPU")
		players.append(new_player)
		new_player.player_selected.connect(func(): _on_player_selected())
	print(players)
	TurnManager.set_turn_order(players)


func seat_players() -> void:
	var player_keys = TurnManager.turn_map.keys()
	player_keys.reverse()
	print(player_keys)
	for seat in available_seats:
		if seat.get_children().size() == 0:
			var target_key = player_keys.pop_back()
			print(str(player_keys) + " left")
			var new_player: Player = TurnManager.turn_map.get(target_key)
			if new_player:
				seat.add_child(new_player)
		else:
			continue
	print("player keys after seating: " + str(player_keys))


func _on_player_selected() -> void:
	for key in TurnManager.turn_map_keys:
		TurnManager.turn_map.get(key).disable_sit_button()
	emit_signal("player_selected")
