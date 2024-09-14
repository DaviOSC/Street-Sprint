extends "res://Scripts/obstaculo.gd"

@export var trainSpeed = 1.3
func _process(delta: float) -> void:
	translate(Vector2.DOWN * fall_speed * delta * trainSpeed)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("colision")
		restart_level()
