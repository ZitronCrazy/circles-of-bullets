extends CharacterBody2D
## Enemy Movement and AI Logic
## 
## ## Tutorial(Top Down Survival Shooter In Godot | Part 4 - Enemy AI): https://youtu.be/7Jc5fKNTb_A
## Accessed on: 22.09.2026
## Godot Doc: https://docs.godotengine.org/en/4.5/getting_started/first_3d_game/05.spawning_mobs.html
## Accessed on: 22.09.2026

@onready var main = get_node("/root/Main")
@onready var player = get_node("/root/Main/Player")

var item_scene := preload("res://scenes/item.tscn")

signal hit_player

var alive : bool
var entered : bool
var speed : int = 70
var direction : Vector2

func _ready():
	var screen_rect = get_viewport_rect()
	alive = true
	entered = false
	# pick a direction for the entrance
	var dist = screen_rect.get_center() - position
	# check if need to move horizontally or vertically
	if abs(dist.x) > abs(dist.y):
		# move horizontally
		direction.x = dist.x
		direction.y = 0
	else:
		# move vertically
		direction.x = 0
		direction.y = dist.y

func _physics_process(_delta):
	if alive:
		if entered:
			direction = (player.position - position)
		direction = direction.normalized()
		velocity = direction * speed
		move_and_slide()
		
		if velocity.x != 0:
			$AnimatedSprite2D.flip_h = velocity.x < 0 
	else:
		pass

func die():
	alive = false
	$AnimatedSprite2D.animation = "dead"
	$Area2D/CollisionShape2D.set_deferred("disabled", true)
	drop_item()
	
func drop_item():
	var item = item_scene.instantiate()
	item.position = position
	item.item_type = randi_range(0,2)
	main.call_deferred("add_child", item)
	item.add_to_group("items")

func _on_entrance_timer_timeout() -> void:
	entered = true


func _on_area_2d_body_entered(_body):
	hit_player.emit()
