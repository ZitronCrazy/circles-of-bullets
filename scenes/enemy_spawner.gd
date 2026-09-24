extends Node2D
## Enemy Spawner Logic.
##
## Tutorial(Top Down Survival Shooter In Godot | Part 3 - Enemy Spawner): https://youtu.be/84_Rv79d4yw
## Accessed on: 21.09.2026
## Tutorial(Top Down Survival Shooter In Godot | Part 4 - Enemy AI): https://youtu.be/7Jc5fKNTb_A
## Accessed on: 22.09.2026
## Godot Doc: https://docs.godotengine.org/en/4.5/getting_started/first_3d_game/05.spawning_mobs.html
## Accessed on: 22.09.2026

#path to main node
@onready var main = get_node("/root/Main")

signal hit_p

# enemies
var slime_scene := preload("res://scenes/slime.tscn")
var skeleton_scene := preload("res://scenes/skeleton.tscn")
var ghost_scene := preload("res://scenes/ghost.tscn")
# enemies put in one array
var enemy_scenes := [slime_scene, skeleton_scene, ghost_scene]

var spawn_points := []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in get_children():
		if i is Marker2D:
			spawn_points.append(i)

func _on_timer_timeout():
	# check how many enemies have already been created
	var enemies = get_tree().get_nodes_in_group("enemies")
	if enemies.size() < get_parent().max_enemies:
		# pick random spawn point
		var spawn = spawn_points[randi() % spawn_points.size()]
		# pick random enemy
		var selected_scene = enemy_scenes[randi() % enemy_scenes.size()]
		var enemy = selected_scene.instantiate()
		# change enemies speed based on current main game state
		if selected_scene == skeleton_scene:
			enemy.speed = main.skeleton_speed
		if selected_scene == slime_scene:
			enemy.speed = main.slime_speed
		if selected_scene == ghost_scene:
			enemy.speed = main.ghost_speed
		# spawn enemy
		enemy.position = spawn.position
		enemy.hit_player.connect(hit)
		main.add_child(enemy)
		enemy.add_to_group("enemies")

func hit():
	hit_p.emit()
