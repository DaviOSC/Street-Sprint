extends Area2D

@export var fall_speed = 200

signal player_hit 

func _process(delta: float) -> void:
	translate(Vector2.DOWN * fall_speed * delta)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		emit_signal("player_hit", body)  
