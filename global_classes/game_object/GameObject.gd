class_name GameObject
extends Sprite2D

var expanded_size: Vector2 = Vector2(1.2, 1.2)
var normal_size: Vector2 = Vector2(1.0, 1.0)
var selectable: bool = true
var hovered: bool = false
var selected: bool = false
var global_mouse_offset: Vector2
var shadow_scene: PackedScene = preload("res://global_classes/game_object/ObjectShadow.tscn")
var object_shadow: ObjectShadow
var click_box: Area2D


func _ready() -> void:
	# Set up shadow
	object_shadow = shadow_scene.instantiate()
	configure_shadow_region()
	set_shadow_position()
	add_child(object_shadow)
	set_properties()
	
	
	# Set up click box
	click_box = get_child(0)
	set_click_box_shape()
	self.click_box.connect("mouse_entered", func(): _on_click_box_mouse_entered())
	self.click_box.connect("mouse_exited", func(): _on_click_box_mouse_exited())
	self.click_box.connect("input_event", func(_viewport, event, _shape_idx): _on_click_box_input_event(_viewport, event, _shape_idx))
	
	# Set object size
	set_object_size()
	
func _input(event: InputEvent) -> void:
	check_if_selected(event)


func _process(delta: float) -> void:
	if selected:
		global_position = get_global_mouse_position() - global_mouse_offset
		scale = scale.lerp(expanded_size, 0.1 + delta)
	elif (!selected):
		scale = scale.lerp(normal_size, 0.1 + delta)


func set_click_box_shape() -> void:
	pass


func set_object_size() -> void:
	pass


func configure_shadow_region() -> void:
	pass


func set_shadow_position() -> void:
	pass
	

func set_properties() -> void:
	pass


func check_if_selected(event: InputEvent) -> void:
	if hovered:
		if event.is_action_pressed("left_click"):
			selected = true
			global_mouse_offset = Vector2(get_global_mouse_position() - global_position)
	if event.is_action_released("left_click"):
		selected = false


func _on_click_box_mouse_entered() -> void:
	if selectable:
		hovered = true


func _on_click_box_mouse_exited() -> void:
	hovered = false


func _on_click_box_input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed("left_click"):
		object_shadow.fade_in()
	if event.is_action_released("left_click"):
		object_shadow.fade_out()
