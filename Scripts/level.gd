extends Node2D

@export var ui: UI
@export var gameSpeed = 0.25
@onready var obstacleSpawnTimer = $ObstacleSpawnTimer
@onready var shader_material = $TextureRect.material
var barrier1 = preload("res://Scenes/barrier1.tscn")
var barrier2 = preload("res://Scenes/barrier2.tscn")
var barrier3 = preload("res://Scenes/barrier3.tscn")

@export var barriers = [PackedScene]

var positions = []
var obstaculos = []
var canSpawn = false
var score = 0
var base_time = 2.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if shader_material is ShaderMaterial:
		setGameSpeed()
	positions.append($"Position 0")
	positions.append($"Position 1")
	positions.append($"Position 2")
	for barrier in barriers:
		obstaculos.append(barrier)
	
	#obstaculos.append(barrier1)
	#obstaculos.append(barrier2)
	#obstaculos.append(barrier3)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	changePosition()
	updateScore()
	increaseGameSpeed()
	if canSpawn:
		spawnObstacle(obstaculos.pick_random())
		canSpawn = false
	
	
func changePosition() -> void:
	get_node("Player")._physics_process(0.5)
	
func spawnObstacle(obstaculoType) -> void:
	var obstaculo_instance = obstaculoType.instantiate()
	obstaculo_instance.set("fall_speed", gameSpeed*500)
	add_child(obstaculo_instance)
	var position_node = positions.pick_random()
	if position_node:
		obstaculo_instance.global_position = position_node.global_position

func updateScore():
	score += 1
	if score % 100 == 0:
		ui._on_score_updated(score)
		
func setGameSpeed():
	var spawn_timer_clock = base_time * (0.25 / gameSpeed)
	obstacleSpawnTimer.start(spawn_timer_clock)
	shader_material.set_shader_parameter("speed", gameSpeed*0.405)
	
func increaseGameSpeed():
	if score % 1000 == 0:
		gameSpeed += 0.05
		setGameSpeed()
		print(gameSpeed)
	
	
func _on_timer_timeout() -> void:
	canSpawn = true
