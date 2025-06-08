class_name CardData
extends Resource

var rank: StringName
var suit: StringName


func _init(init_rank: StringName, init_suit: StringName) -> void:
	self.rank = init_rank
	self.suit = init_suit
