extends CharacterBody2D
## Player movement logic.
##
## Tutorial(Top Down Survival Shooter In Godot | Part 2 - Player Movement): https://youtu.be/oSX6x7LT4e0
## Accessed on: 15.09.2026
##
## Explanation of 8 directional movement by kidscancode: https://kidscancode.org/godot_recipes/4.x/2d/8_direction/
## Accessed on: 21.09.2026

var speed : int
var screen_size : Vector2

func _ready():
	screen_size = get_viewport_rect().size
	position = screen_size / 2
	speed = 200

func get_input():
	#keyboard input
	var input_dir = Input.get_vector("left", "right", "up", "down")
	velocity = input_dir.normalized() * speed

func _physics_process(_delta):
	#player movement
	get_input()
	move_and_slide()
	
	#limit movement to window size
	position = position.clamp(Vector2.ZERO, screen_size)
	
	#player rotation
	var mouse = get_local_mouse_position()
	var angle = snappedf(mouse.angle(), PI/ 4) / (PI / 4)
	angle = wrapi(int(angle), 0, 8)
	
	$AnimatedSprite2D.animation = "walk" +str(angle)
	
	#player animation
	if velocity.length() != 0:
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.frame = 1
