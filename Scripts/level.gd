extends Node2D

var positions = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	positions.append($"Position 1")
	positions.append($"Position 2")
	positions.append($"Position 3")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	changePosition()
	
	
func changePosition() -> void:
	get_node("Player")._physics_process(1)
