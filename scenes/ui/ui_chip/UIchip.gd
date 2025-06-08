extends TextureRect


signal selected(this_value: int)


@export var value: int = 10
@export_color_no_alpha var color

@onready var highlight = $Highlight

var hovered: bool = false


func _ready() -> void:
	$ValueLabel.text = str(value)
	self.self_modulate = color
	self.connect("mouse_entered", func(): _on_mouse_entered())
	self.connect("mouse_exited", func(): _on_mouse_exited())
	self.connect("gui_input", func(event: InputEvent): _on_gui_input(event))


func _on_mouse_entered() -> void:
	highlight.visible = true
	hovered = true


func _on_mouse_exited() -> void:
	highlight.visible = false
	hovered = false


func _on_gui_input(event) -> void:
	if hovered and event.is_action_pressed("left_click"):
		emit_signal("selected", value)
