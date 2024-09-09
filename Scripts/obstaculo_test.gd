extends Area2D

var fall_speed = 200 # Velocidade de queda em pixels por segundo

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	global_position.y += fall_speed * delta



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("colision")
