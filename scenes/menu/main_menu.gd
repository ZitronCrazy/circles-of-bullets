extends Node2D
## Lilia and Tabea
## Main Menu control scene logic.

@onready var main_panel_background: Panel = $hud_menu/mainPanel_background
@onready var controls_panel_background: Panel = $hud_menu/controlsPanel_background

# Main Menu start set up
func _ready() -> void:
	main_panel_background.visible = true
	controls_panel_background.visible = false

func _on_start_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")

# Shows player control how to play the game
func _on_controls_pressed():
	main_panel_background.visible = false
	controls_panel_background.visible = true

# back to Main Menu
func _on_back_pressed():
	main_panel_background.visible = true
	controls_panel_background.visible = false

func _on_quit_pressed():
	get_tree().quit()
