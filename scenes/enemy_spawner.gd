extends Node2D

#path to main node
@onready var main = get_node("/root/Main")

#enemies
var slime_scene := preload("res://scenes/slime.tscn")
var skeleton_scene := preload("res://scenes/skeleton.tscn")
var ghost_scene := preload("res://scenes/ghost.tscn")

var spawn_points := []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in get_children():
		if i is Marker2D:
			spawn_points.append(i)

func _on_timer_timeout() -> void:
	#pick random spawn point
	var spawn = spawn_points[randi() % spawn_points.size()]
	
	var slime = slime_scene.instantiate()
	slime.position = spawn.position
	main.add_child(slime)
	
	var skeleton = skeleton_scene.instantiate()
	skeleton.position = spawn.position
	main.add_child(skeleton)
	
	var ghost = ghost_scene.instantiate()
	ghost.position = spawn.position
	main.add_child(ghost)
