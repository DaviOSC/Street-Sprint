extends Node2D

@export var gameSpeed = 0.15
@onready var obstacleSpawnTimer = $Timer
@onready var shader_material = $TextureRect.material
var obstaculo1 = preload("res://Scenes/ObstaculoTest.tscn")
var positions = []
var obstaculos = []
var canSpawn = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if shader_material is ShaderMaterial:
		# Altere o parâmetro 'speed' do shader
		shader_material.set_shader_parameter("speed", gameSpeed)
	
	positions.append($"Position 0")
	positions.append($"Position 1")
	positions.append($"Position 2")
	obstaculos.append(obstaculo1)
	obstacleSpawnTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	changePosition()
	if canSpawn:
		spawnObstacle(obstaculos.pick_random())
		canSpawn = false
	
	
func changePosition() -> void:
	get_node("Player")._physics_process(0.5)
	
func spawnObstacle(obstaculoType) -> void:
	var obstaculo_instance = obstaculoType.instantiate()
	add_child(obstaculo_instance)
	var position_node = positions.pick_random()
	if position_node:
		obstaculo_instance.global_position = position_node.global_position


func _on_timer_timeout() -> void:
	canSpawn = true # Replace with function body.
