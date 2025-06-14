extends Node

# Sprites
var banana_sprite: CompressedTexture2D = preload("res://scenes/player/textures/banana.png")
var cherries_sprite: CompressedTexture2D = preload("res://scenes/player/textures/cherries.png")
var grapes_sprite: CompressedTexture2D = preload("res://scenes/player/textures/grapes.png")
var orange_sprite: CompressedTexture2D = preload("res://scenes/player/textures/orange.png")

# Backgrounds
var banana_background: Color = Color("blue")
var cherries_background: Color = Color("white")
var grapes_background: Color = Color("orange")
var orange_background: Color = Color("fuchsia")

# Player outline colors
var human_outline: Color = Color("#0068f4")
var cpu_outline: Color = Color("#f71674")
