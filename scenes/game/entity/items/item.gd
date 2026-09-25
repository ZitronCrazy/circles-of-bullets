extends Area2D
## Tabea
## Item effects on player.
## 
## Tutorial(Top Down Survival Shooter In Godot | Part 7 - Item Drops): https://youtu.be/khhCjk_qiu8
## Accessed on: 23.09.2026

@onready var main = get_node("/root/Main")
@onready var lives_label = get_node("/root/Main/hud/liveslabel")

var item_type : int # 0: monster energy, 1: health, 2: gun

var monster_box = preload("res://assets/sprites/items/monster_box.png")
var heart_box = preload("res://assets/sprites/items/heart_box.png")
var gun_box = preload("res://assets/sprites/items/gun_box.png")
var textures = [monster_box, heart_box, gun_box]

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.texture = textures[item_type]

func _on_body_entered(body: Node2D):
	# monster energy gives movementspeed
	if item_type == 0:
		body.boost()
	# health adds up
	elif item_type == 1:
		main.lives +=1
		lives_label.text = "X " +str(main.lives)
	# gun enables player shoot faster
	elif item_type == 2:
		body.quick_fire()
	# delete item after collect
	queue_free()
