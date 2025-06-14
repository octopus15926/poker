class_name Player
extends Node2D


signal player_selected


enum PlayerType { CPU, HUMAN }
const CARD_SPACING_MULTIPLIER: Vector2 = Vector2(-50.0, -50.0)

var sprite
var name_label: Label
var player_icon: CompressedTexture2D
var player_outline: Sprite2D
var player_background: Panel
var sit_button: Button
var hand: Node
var player_name: StringName = &"Banana"
var player_type: PlayerType = PlayerType.HUMAN
var chips: int = 10000
var chip_selection_wheel: PackedScene = preload("res://scenes/ui/chip_selection_wheel/ChipSelectionWheel.tscn")
var chip: PackedScene = preload("res://scenes/chip/Chip.tscn")
var chip_wheel_open: bool = false


func custom_init(i_player_name: StringName, i_player_type: StringName) -> void:
	self.player_name = i_player_name
	if i_player_type == &"CPU":
		player_outline = $PlayerOutline
		player_outline.set("self_modulate", PlayerIconManager.cpu_outline)
		self.player_type = PlayerType.CPU
	player_background = $PlayerBackground
	match(i_player_name):
		&"Banana":
			player_icon = PlayerIconManager.banana_sprite
			player_background.set("self_modulate", PlayerIconManager.banana_background)
		&"Cherries":
			player_icon = PlayerIconManager.cherries_sprite
			player_background.set("self_modulate", PlayerIconManager.cherries_background)
		&"Grapes":
			player_icon = PlayerIconManager.grapes_sprite
			player_background.set("self_modulate", PlayerIconManager.grapes_background)
		&"Orange":
			player_icon = PlayerIconManager.orange_sprite
			player_background.set("self_modulate", PlayerIconManager.orange_background)
		_:
			player_icon = PlayerIconManager.banana_sprite
			player_background.set("self_modulate", PlayerIconManager.banana_background)
	sprite = $PlayerIcon
	name_label = $NamePlate/CenterContainer/NameLabel
	name_label.set("text", self.player_name)
	sprite.set("texture", player_icon)
	sit_button = $SitButton
	sit_button.pressed.connect(func(): _on_sit_button_pressed())
	hand = $Hand


func _input(event) -> void:
	if player_type == PlayerType.HUMAN and !chip_wheel_open and event.is_action_pressed("right_click"):
		var chip_wheel = chip_selection_wheel.instantiate()
		chip_wheel.position = to_local(get_global_mouse_position())
		add_child(chip_wheel)
		chip_wheel.connect("chip_selected", func(value: int): _on_chip_wheel_selected(value))
		chip_wheel.connect("tree_exited", func(): _on_chip_wheel_exited())
		chip_wheel_open = true


func pick_up_cards(cards: Array[Card]) -> void:
	var total_card_width: float = 0.0
	var card_gap: float = 0.0
	for card in cards:
		total_card_width += card.region_rect.size.x
		hand.add_child(card)
		card.position = global_position
	card_gap = total_card_width / maxf(1.0, float(cards.size()) * 2.0)
	total_card_width += card_gap
	hand.get_child(0).position.x += position.x - 0.5 * total_card_width
	hand.get_child(0).position.y -= total_card_width
	hand.get_child(1).position.x += position.x + 0.5 * total_card_width
	hand.get_child(1).position.y -= total_card_width


func rotate_player(direction: StringName) -> void:
	match(direction):
		&"down":
			rotate(3.14159)
		&"left":
			rotate(-1.5708)
		&"right":
			rotate(1.5708)
		_:
			pass


func disable_sit_button() -> void:
	sit_button.visible = false


func get_hand() -> Array:
	if hand.get_children().size() == 2:
		return hand.get_children()
	return []


func add_community_to_hand(community_cards: Array) -> void:
	for card in community_cards:
		hand.add_child(card)


func _on_chip_wheel_selected(value: int) -> void:
	var dropped_chip = chip.instantiate()
	if chips >= value:
		dropped_chip.update_value(value)
		chips -= value
	else:
		dropped_chip.update_value(max(chips, 0))
		chips = 0
	add_child(dropped_chip)
	dropped_chip.position = to_local(get_global_mouse_position())


func _on_chip_wheel_exited() -> void:
	chip_wheel_open = false


func _on_sit_button_pressed() -> void:
	player_type = PlayerType.HUMAN
	player_outline.set("self_modulate", PlayerIconManager.human_outline)
	hand.flip_cards()
	emit_signal("player_selected")
