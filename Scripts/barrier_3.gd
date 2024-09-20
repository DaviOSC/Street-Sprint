extends "res://Scripts/obstaculo.gd"

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") && not body.get("isRolling"):
		emit_signal("player_hit", body)  
