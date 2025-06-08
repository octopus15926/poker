class_name ObjectShadow
extends Sprite2D


const SHADOW_VISIBLE: Color = Color(0.07, 0.07, 0.07, 0.62)
const SHADOW_INVISIBLE: Color = Color(0.07, 0.07, 0.07, 0.0)
const SHADOW_TWEEN_SPEED: float = 6.0


func _ready() -> void:
	modulate = SHADOW_INVISIBLE
	position_shadow()
	set_texture_to_parent()
	scale_shadow()
	


func fade_in() -> void:
	var shadow_tween = create_modulate_tween(SHADOW_VISIBLE, Tween.EASE_OUT)
	shadow_tween.play()
	
	
func fade_out() -> void:
	var shadow_tween = create_modulate_tween(SHADOW_INVISIBLE, Tween.EASE_IN)
	shadow_tween.play()


func position_shadow() -> void:
	position = position + Vector2(-1.5, 1.0)


func set_texture_to_parent() -> void:
	var parent_texture = get_parent().texture
	self.texture = parent_texture


func scale_shadow() -> void:
	var parent_size = get_parent().texture.get_size()
	self.texture.set("size", parent_size)
	
	
func create_modulate_tween(color_destination: Color, ease_type: Tween.EaseType) -> Tween:
	var modulate_tween = get_tree().create_tween()
	modulate_tween.set_trans(Tween.TRANS_CUBIC)
	modulate_tween.set_speed_scale(SHADOW_TWEEN_SPEED)
	modulate_tween.set_ease(ease_type)
	modulate_tween.tween_property(self, "modulate", color_destination, 1)
	return modulate_tween
