extends GameObject

const CHIP_TEXTURE: Texture2D = preload("res://assets/chips/chip.png")

var value: int = 0


func set_properties() -> void:
	if value <= 100:
		self_modulate = GameObjectProperties.BLUE_CHIP
	if value > 100 and value <= 500:
		self_modulate = GameObjectProperties.ORANGE_CHIP
	if value > 500 and value <= 1000:
		self_modulate = GameObjectProperties.RED_CHIP
	if value > 1000 and value <= 5000:
		self_modulate = GameObjectProperties.PURPLE_CHIP



func set_object_size() -> void:
	normal_size = GameObjectProperties.NORMAL_CHIP_SIZE
	expanded_size = GameObjectProperties.EXPANDED_CHIP_SIZE


func set_click_box_shape() -> void:
	var collider = click_box.get_child(0)
	collider.shape = CircleShape2D.new()
	collider.shape.radius = texture.get_width()/2.0


func configure_shadow_region() -> void:
	object_shadow.region_enabled = false


func set_shadow_position() -> void:
	object_shadow.set("scale", object_shadow.get("scale") * Vector2(1.05, 1.05))


func update_value(new_value: int) -> void:
	value = new_value
	$Value.text = str(new_value)
