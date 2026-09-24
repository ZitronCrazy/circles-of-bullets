extends Node
## Game Manager Logic
##
## Tutorial(Top Down Survival Shooter In Godot | Part 4 - Enemy AI): https://youtu.be/7Jc5fKNTb_A
## Accessed on: 22.09.2026
## 
## Tutorial(Top Down Survival Shooter In Godot | Part 8 - Game Over): https://youtu.be/_-e7t5Fby_0
## Accessed on: 23.09.2026
##
## Tutorial(Top Down Survival Shooter In Godot | Part 9 - Completed Waves):https://youtu.be/_1bVJSglte8
## Accessed on: 24.09.2026

@onready var sfxyay = $sfxyay

var wave : int 
var difficulty : float
const DIFF_MULTIPLIER : float = 1.2
var max_enemies : int
var skeleton_speed : float
var slime_speed : float
var ghost_speed : float
var lives : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sfxyay.process_mode = Node.PROCESS_MODE_ALWAYS
	new_game()
	$"Game Over/Button".pressed.connect(new_game)

func new_game():
	lives = 3
	wave = 1
	difficulty = 10.0
	skeleton_speed = 50.0
	slime_speed = 70.0
	ghost_speed = 100.0
	$EnemySpawner/Timer.wait_time = 1.0
	reset()

func reset():
	max_enemies = int(difficulty)
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
	if is_wave_completed():
		wave += 1
		sfxyay.play()
		# adjust difficult
		difficulty *= DIFF_MULTIPLIER
		if $EnemySpawner/Timer.wait_time > 0.25:
			$EnemySpawner/Timer.wait_time -= 0.05
		if skeleton_speed < 500.0:
			skeleton_speed += 0.1
		if slime_speed < 700.0:
			slime_speed += 0.1
		if ghost_speed < 1000.0:
			ghost_speed += 0.1
		get_tree().paused = true
		$WaveOVerTimer.start()

func _on_enemy_spawner_hit_p():
	print("hit player")
	lives -= 1 
	$hud/liveslabel.text = "X" + str(lives)
	get_tree().paused = true
	if lives <= 0:
		$"Game Over/WavesSurvivedLabel".text = "WAVES SURVIVED: " + str(wave -1)
		$"Game Over".show()
	else:
		$WaveOVerTimer.start()

func _on_wave_o_ver_timer_timeout():
	reset()

func _on_restart_timer_timeout():
	get_tree().paused = false

func is_wave_completed():
	var all_dead = true
	var enemies = get_tree().get_nodes_in_group("enemies")
	# check if all enemies have spawned first
	if enemies.size() == max_enemies:
		for i in enemies:
			if i.alive:
				all_dead = false
		return all_dead
	else:
		return false
