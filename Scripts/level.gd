extends Node2D

var obstaculo1 = preload("res://Scenes/ObstaculoTest.tscn")
var positions = []
var obstaculos = []
@onready var obstacleSpawnTimer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	positions.append($"Position 0")
	positions.append($"Position 1")
	positions.append($"Position 2")
	obstaculos.append(obstaculo1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	changePosition()
	if Input.is_action_just_pressed("SpawnEntity"):
		spawnObstacle(obstaculos.pick_random())
	
	
func changePosition() -> void:
	get_node("Player")._physics_process(0.5)
	
func spawnObstacle(obstaculoType) -> void:
	var obstaculo_instance = obstaculoType.instantiate()
	add_child(obstaculo_instance)
	var position_node = positions.pick_random()
	if position_node:
		obstaculo_instance.global_position = position_node.global_position
