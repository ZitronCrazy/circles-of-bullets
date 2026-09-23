extends Area2D

var item_type : int # 0: coffe, 1: health, 2: gun

var coffe_box = preload("res://assets/items/coffee_box.png")
var heart_box = preload("res://assets/items/heart_box.png")
var gun_box = preload("res://assets/items/gun_box.png")
var textures = [coffe_box, heart_box, gun_box]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	$Sprite2D.texture = textures[item_type]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
