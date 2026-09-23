extends Area2D
## Bullet Properties Logic
## 
## Tutorial(Top Down Survival Shooter In Godot | Part 5 - Shooting): https://youtu.be/xalHXyDtfpc
## Accessed on: 23.09.2026

var speed : int = 500
var direction : Vector2

func _process(delta):
	position += speed * direction * delta

func _on_timer_timeout() -> void:
	queue_free()


func _on_body_entered(body: Node2D):
	print(body.name)
	if body.name == "World":
		queue_free()
