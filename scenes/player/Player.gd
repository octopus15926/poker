class_name Player
extends Node2D


enum PlayerType { CPU, HUMAN }
const CARD_SPACING_MULTIPLIER: Vector2 = Vector2(-50.0, -50.0)

var sprite
var name_label: Label
var player_name: StringName = &"Banana"
var player_type: PlayerType = PlayerType.HUMAN
var player_image: CompressedTexture2D
var chips: int = 10000
var chip_selection_wheel: PackedScene = preload("res://scenes/ui/chip_selection_wheel/ChipSelectionWheel.tscn")
var chip: PackedScene = preload("res://scenes/chip/Chip.tscn")
var chip_wheel_open: bool = false


func custom_init(i_player_name: StringName, i_player_type: StringName) -> void:
	self.player_name = i_player_name
	if i_player_type == &"CPU":
		self.player_type = PlayerType.CPU
	# TODO: Player image selection, for now set based on filler names
	match(i_player_name):
		&"Banana":
			player_image = PlayerSpriteManager.banana_sprite
		&"Cherries":
			player_image = PlayerSpriteManager.cherries_sprite
		&"Grapes":
			player_image = PlayerSpriteManager.grapes_sprite
		&"Orange":
			player_image = PlayerSpriteManager.orange_sprite
		_:
			player_image = PlayerSpriteManager.banana_sprite
	sprite = $PlayerSprite
	name_label = $NamePlate/CenterContainer/NameLabel
	name_label.set("text", self.player_name)
	sprite.set("texture", player_image)


func _input(event) -> void:
	if player_type == PlayerType.HUMAN and !chip_wheel_open and event.is_action_pressed("right_click"):
		var chip_wheel = chip_selection_wheel.instantiate()
		chip_wheel.position = to_local(get_global_mouse_position())
		add_child(chip_wheel)
		chip_wheel.connect("chip_selected", func(value: int): _on_chip_wheel_selected(value))
		chip_wheel.connect("tree_exited", func(): _on_chip_wheel_exited())
		chip_wheel_open = true


func set_player_texture() -> void:
	pass


func pick_up_cards(cards: Array[Card]) -> void:
	var total_card_width: float = 0.0
	var card_gap: float = 0.0
	for card in cards:
		total_card_width += card.region_rect.size.x
		$Hand.add_child(card)
		card.position = global_position
	card_gap = total_card_width / maxf(1.0, float(cards.size()) * 2.0)
	total_card_width += card_gap
	$Hand.get_child(0).position.x += position.x - 0.5 * total_card_width
	$Hand.get_child(0).position.y -= total_card_width
	$Hand.get_child(1).position.x += position.x + 0.5 * total_card_width
	$Hand.get_child(1).position.y -= total_card_width


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
