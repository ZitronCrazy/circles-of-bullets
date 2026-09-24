extends Area2D

@onready var main = get_node("/root/Main")
@onready var lives_label = get_node("/root/Main/hud/liveslabel")

var item_type : int # 0: coffe, 1: health, 2: gun

var coffe_box = preload("res://assets/items/coffee_box.png")
var heart_box = preload("res://assets/items/heart_box.png")
var gun_box = preload("res://assets/items/gun_box.png")
var textures = [coffe_box, heart_box, gun_box]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	$Sprite2D.texture = textures[item_type]


func _on_body_entered(body: Node2D) -> void:
	#coffee
	if item_type == 0:
		body.boost()
	#health
	elif item_type == 1:
		main.lives +=1
		lives_label.text = "X " +str(main.lives)
	#gun
	elif item_type == 2:
		body.quick_fire()
	#delete item
	queue_free()
