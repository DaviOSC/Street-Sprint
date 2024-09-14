extends Area2D

@export var fall_speed = 200 # Velocidade de queda em pixels por segundo

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	translate(Vector2.DOWN * fall_speed * delta)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("colision")
		restart_level()
		
		
func restart_level():
	var main_node = get_tree().root.get_node("level")
	main_node.pauseGame()
	
