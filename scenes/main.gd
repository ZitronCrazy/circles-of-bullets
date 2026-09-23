extends Node
## enemy hitting player
## Tutorial(Top Down Survival Shooter In Godot | Part 4 - Enemy AI): https://youtu.be/7Jc5fKNTb_A
## Accessed on: 22.09.2026

var wave : int 
var max_enemies : int
var lives : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	wave = 1
	lives = 3
	max_enemies = 10
	$hud/liveslabel.text = "X" + str(lives)
	$hud/wavelabel.text = "WAVE: " + str(wave)
	$hud/enemieslabel.text = "X" + str(max_enemies)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_enemy_spawner_hit_p() -> void:
	print("hit player")
	if lives > 0: lives -= 1 
	
	$hud/liveslabel.text = "X" + str(lives)
