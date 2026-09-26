extends Node
## Lilia and Tabea
## Game Manager Logic
##
## Tutorial(Top Down Survival Shooter In Godot | Part 4 - Enemy AI): https://youtu.be/7Jc5fKNTb_A
## Accessed on: 22.09.2026
## Tutorial(Top Down Survival Shooter In Godot | Part 8 - Game Over): https://youtu.be/_-e7t5Fby_0
## Accessed on: 23.09.2026
## Tutorial(Top Down Survival Shooter In Godot | Part 9 - Completed Waves):https://youtu.be/_1bVJSglte8
## Accessed on: 24.09.2026

@onready var music = $"background music"
@onready var sfxgameover = $sfxgameover
@onready var sfxyay = $sfxyay

var konfetti_scene := preload("res://scenes/game/levels/animations/konfetti.tscn")
var wave : int 
var difficulty : float
const DIFF_MULTIPLIER : float = 1.2
var max_enemies : int
var remaining_enemies : int
var bodycount : int = 0
var skeleton_speed : float
var slime_speed : float
var ghost_speed : float
var lives : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sfxyay.process_mode = Node.PROCESS_MODE_ALWAYS
	sfxgameover.process_mode = Node.PROCESS_MODE_ALWAYS
	music.process_mode = Node.PROCESS_MODE_ALWAYS
	new_game()
	$"Game Over/Panel/Retry".pressed.connect(new_game)
	$"Game Over/Panel/Quit".pressed.connect(quit)

func quit():
	get_tree().quit()

func new_game():
	lives = 3
	wave = 1
	difficulty = 10.0
	skeleton_speed = 50.0
	slime_speed = 70.0
	ghost_speed = 100.0
	$EnemySpawner/Timer.wait_time = 1.0
	$"Game Over/BodyCountLabel".text = "BODY COUNT :  0"
	reset()
	get_tree().call_group("items", "queue_free")

func reset():
	max_enemies = int(difficulty)
	remaining_enemies = max_enemies
	$Player.reset_control()
	get_tree().call_group("enemies", "queue_free")
	get_tree().call_group("bullets", "queue_free")
	$hud/liveslabel.text = "X " + str(lives)
	$hud/wavelabel.text = "WAVE :  " + str(wave)
	$hud/enemieslabel.text = "X " + str(remaining_enemies)
	$"Game Over".hide()
	get_tree().paused = true
	$RestartTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if is_wave_completed():
		wave += 1
		sfxyay.play()
		spawn_konfetti()
		# adjust difficult
		difficulty *= DIFF_MULTIPLIER
		if $EnemySpawner/Timer.wait_time > 0.25:
			$EnemySpawner/Timer.wait_time -= 0.05#; mein Semikolon 
		if skeleton_speed < 500.0:
			skeleton_speed += 1.0
		if slime_speed < 700.0:
			slime_speed += 1.0
		if ghost_speed < 1000.0:
			ghost_speed += 1.0
		get_tree().paused = true
		$WaveOverTimer.start()

#spawns confetti after wave is completed
func spawn_konfetti():
	var konfetti = konfetti_scene.instantiate()
	konfetti.position = $Player.position
	add_child(konfetti)
	# runs even if paused
	konfetti.process_mode = Node.PROCESS_MODE_ALWAYS
	konfetti.emitting = true

func _on_enemy_killed():
	bodycount += 1
	remaining_enemies -= 1
	
	$hud/enemieslabel.text = "X " + str(remaining_enemies)

func _on_enemy_spawner_hit_p():
	print("hit player")
	lives -= 1 
	$hud/liveslabel.text = "X " + str(lives)
	get_tree().paused = true
	if lives <= 0:
		sfxgameover.play()
		$"Game Over/WavesSurvivedLabel".text = "WAVES SURVIVED :  " + str(wave -1)
		$"Game Over/BodyCountLabel".text = "BODY COUNT :  " + str(bodycount)
		$"Game Over".show()
	else:
		$WaveOverTimer.start()

func _on_wave_o_ver_timer_timeout():
	reset()

func _on_restart_timer_timeout():
	get_tree().paused = false

func is_wave_completed():
	var enemies = get_tree().get_nodes_in_group("enemies")
	var all_dead = true
	# check if all enemies have spawned first
	if enemies.size() == max_enemies:
		for i in enemies:
			if i.alive:
				all_dead = false
		return all_dead
	else:
		return false
