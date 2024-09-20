extends CharacterBody2D

const SPEED = 5.0
const JUMP_HEIGHT = 50.0

var currentPosition = 1

@onready var Animator = $AnimatedSprite2D

var possiblePositions = []

var move_left_pressed = false
var move_right_pressed = false
var isJumping = false
var canJump = true
var canRoll = true
var isRolling = false

var target_position = Vector2()
var initial_position = Vector2()
var jump_target_position = Vector2()


func _ready():
	possiblePositions.append(get_node("../Markers/Position 0"))
	possiblePositions.append(get_node("../Markers/Position 1"))
	possiblePositions.append(get_node("../Markers/Position 2"))

	target_position = global_position
	initial_position = global_position

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("Move Left") and currentPosition > 0:
		if not move_left_pressed:
			currentPosition -= 1
			move_left_pressed = true

	elif Input.is_action_just_pressed("Move Right") and currentPosition < possiblePositions.size() - 1:
		if not move_right_pressed:
			currentPosition += 1
			move_right_pressed = true

	if not Input.is_action_pressed("Move Left"):
		move_left_pressed = false
	if not Input.is_action_pressed("Move Right"):
		move_right_pressed = false

	if (move_right_pressed or move_left_pressed) and possiblePositions.size() > 0 and currentPosition >= 0 and currentPosition < possiblePositions.size():
		target_position = possiblePositions[currentPosition].position 
		
	move(_delta)

	if isJumping:
		jump_move(_delta)
	elif not isJumping and global_position.y != initial_position.y:
		global_position.y = move_toward(global_position.y, initial_position.y, SPEED * _delta)
		if global_position.y == initial_position.y:
			canJump = true

	if Input.is_action_just_pressed("Jump") and not isJumping:
		if(canJump):
			jump()
	elif Input.is_action_just_pressed("Roll") and not isRolling:
		if(canRoll):
			roll()    
	elif Input.is_action_just_pressed("Action"):
		pass

func move(_delta: float) -> void:
	if global_position.x != target_position.x:
		global_position.x = move_toward(global_position.x, target_position.x, SPEED * _delta)

	if global_position.x != target_position.x:
		if move_right_pressed:
			Animator.play("RunRight")
		elif move_left_pressed:
			Animator.play("RunLeft")
	else:
		if not isJumping and not isRolling:
			Animator.play("RunUp")

func jump() -> void:
	canJump = false
	isJumping = true
	initial_position = global_position
	jump_target_position = global_position - Vector2(0, JUMP_HEIGHT)
	Animator.play("Jump")
	$AudioStreamPlayer2D3.play()
	$JumpTimer.start(1)

func jump_move(_delta: float) -> void:
	global_position.y = move_toward(global_position.y, jump_target_position.y, SPEED * _delta)

func roll() -> void:
	canRoll = false
	isRolling = true
	Animator.play("Roll")
	$RollTimer.start(1)

func _on_roll_timer_timeout() -> void:
	isRolling = false
	canRoll = true
	$RollTimer.stop() 


func _on_jump_timer_timeout() -> void:
	isJumping = false
	$JumpTimer.stop() 
