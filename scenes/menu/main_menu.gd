extends Node2D
## Tabea
## Main Menu control scene logic.

func _on_start_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_controls_pressed():
	# control scene
	pass

func _on_quit_pressed():
	get_tree().quit()
