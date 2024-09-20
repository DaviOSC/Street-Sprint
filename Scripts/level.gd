extends Node2D
@export var ui: UI
@export var obstaculos : Array[PackedScene] = []
@export var positions: Array[Marker2D] = []
@export var gameSpeed = 0.25
@onready var obstacleSpawnTimer = $ObstacleSpawnTimer
@onready var obstacle_boundaries = $"Markers/Obstacle Boundaries"
@onready var audioPlayer = $AudioStreamPlayer2D
@onready var sfxPlayer = $AudioStreamPlayer2D2
@onready var parallaxBackground = $ParallaxBackground

var canSpawn = false
var score = 0
var base_time = 2.5

func _ready() -> void:	
	audioPlayer.play()
	setGameSpeed()

func _process(delta: float) -> void:
	changePosition()
	updateScore()
	increaseGameSpeed()
	if canSpawn:
		spawnObstacle(obstaculos.pick_random())
		canSpawn = false
	checkObstacleBoundaries()
		

func changePosition() -> void:
	get_node("Player")._physics_process(0.5)

func spawnObstacle(obstaculoType) -> void:
	var obstaculo_instance = obstaculoType.instantiate()
	obstaculo_instance.set("fall_speed", gameSpeed*500)
	add_child(obstaculo_instance)
	if obstaculo_instance:
		obstaculo_instance.connect("player_hit",Callable(self, "_on_player_hit"))
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
	parallaxBackground.set("speed", gameSpeed*500)
	for child in get_children():
		if child.is_in_group("obstacles"):
			child.set("fall_speed", gameSpeed*500)

func increaseGameSpeed():
	if score % 1000 == 0:
		gameSpeed += 0.05
		setGameSpeed()

func checkObstacleBoundaries() -> void:
	for child in get_children():
		if child.is_in_group("obstacles"):
			if child.global_position.y > obstacle_boundaries.global_position.y:
				child.queue_free()

func _on_timer_timeout() -> void:
	canSpawn = true

func pauseGame() -> void:
	var current_scene = get_tree().current_scene
	var ui = current_scene.get_node("UI")
	if ui:
		ui.process_mode = Node.PROCESS_MODE_ALWAYS
		var pause_button = ui.get_node("%PauseButton")
		pause_button.visible = true
		if pause_button:
			pause_button.process_mode = Node.PROCESS_MODE_ALWAYS
			pause_button.visible = true
	get_tree().paused = true

func _on_player_hit(player: Node2D) -> void:
	sfxPlayer.connect("finished", Callable(self, "_on_sfx_finished"))
	sfxPlayer.play()

func _on_sfx_finished() -> void:
	pauseGame()

func resumeGame() -> void:
	get_tree().paused = false
	var current_scene = get_tree().current_scene
	var ui = current_scene.get_node("UI")
	if ui:
		ui.process_mode = Node.PROCESS_MODE_INHERIT
		var pause_button = ui.get_node("%PauseButton")
		if pause_button:
			pause_button.process_mode = Node.PROCESS_MODE_INHERIT
			pause_button.visible = false
