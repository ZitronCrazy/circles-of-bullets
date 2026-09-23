extends Node
## Game Manager Logic
##
## Tutorial(Top Down Survival Shooter In Godot | Part 4 - Enemy AI): https://youtu.be/7Jc5fKNTb_A
## Accessed on: 22.09.2026
## 
## Tutorial(Top Down Survival Shooter In Godot | Part 8 - Game Over): https://youtu.be/_-e7t5Fby_0
## Accessed on: 23.09.2026

var wave : int 
var max_enemies : int
var lives : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_game()
	$"Game Over/Button".pressed.connect(new_game)

func new_game():
	wave = 1
	lives = 3
	max_enemies = 10
	$Player.reset_control()
	get_tree().call_group("enemies", "queue_free")
	get_tree().call_group("bullets", "queue_free")
	#get_tree().call_group("items", "queue_free") Wenn Items drin sind, diesen Code entfreien und Kommentar löschen.
	$hud/liveslabel.text = "X" + str(lives)
	$hud/wavelabel.text = "WAVE: " + str(wave)
	$hud/enemieslabel.text = "X" + str(max_enemies)
	$"Game Over".hide()
	get_tree().paused = true
	$RestartTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_enemy_spawner_hit_p() -> void:
	print("hit player")
	lives -= 1 
	
	$hud/liveslabel.text = "X" + str(lives)
	if lives <= 0:
		get_tree().paused = true
		$"Game Over/WavesSurvivedLabel".text = "WAVES SURVIVED: " + str(wave -1)
		$"Game Over".show()


func _on_restart_timer_timeout():
	get_tree().paused = false
