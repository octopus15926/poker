extends Node2D

signal chip_selected(chip_value: int)
signal chip_selection_escaped

@onready var uichip_0: TextureRect = $GridContainer/UIChip
@onready var uichip_1: TextureRect = $GridContainer/UIChip1
@onready var uichip_2: TextureRect = $GridContainer/UIChip2
@onready var uichip_3: TextureRect = $GridContainer/UIChip3
@onready var grid: GridContainer = $GridContainer


func _ready() -> void:
	self.uichip_0.connect("selected", func(value:int): _on_chip_selected(value))
	self.uichip_1.connect("selected", func(value:int): _on_chip_selected(value))
	self.uichip_2.connect("selected", func(value:int): _on_chip_selected(value))
	self.uichip_3.connect("selected", func(value:int): _on_chip_selected(value))

func _input(event) -> void:
	if event.is_action_pressed("escape"):
		emit_signal("chip_selection_escaped")
		queue_free()

func _on_chip_selected(value) -> void:
	emit_signal("chip_selected", value)
	queue_free()
