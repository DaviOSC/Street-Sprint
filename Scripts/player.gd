extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Variável para rastrear a posição atual
var currentPosition = 1

# Lista de possíveis posições
var possiblePositions = []

# Variáveis para rastrear o estado das ações
var move_left_pressed = false
var move_right_pressed = false

func _ready():
	# Adicione os marcadores à lista. Use nomes de nós ou caminhos relativos.
	possiblePositions.append(get_node("../Position 0"))
	possiblePositions.append(get_node("../Position 1"))
	possiblePositions.append(get_node("../Position 2"))

func _physics_process(_delta: float) -> void:
	# Verifique a entrada do teclado para mudar a posição atual apenas uma vez por clique
	if Input.is_action_just_pressed("Move Left") and currentPosition > 0:
		if not move_left_pressed:
			currentPosition -= 1
			print("Esquerda")
			move_left_pressed = true
	elif Input.is_action_just_pressed("Move Right") and currentPosition < possiblePositions.size() - 1:
		if not move_right_pressed:
			currentPosition += 1
			print("Direita")
			move_right_pressed = true

	# Resetar flags se a tecla não estiver mais pressionada
	if not Input.is_action_pressed("Move Left"):
		move_left_pressed = false
	if not Input.is_action_pressed("Move Right"):
		move_right_pressed = false

	# Atualize a posição do jogador para o marcador atual
	if possiblePositions.size() > 0 and currentPosition >= 0 and currentPosition < possiblePositions.size():
		var target_position = possiblePositions[currentPosition].position  # Use 'position' se 'global_position' não estiver disponível
		global_position = target_position

	# Lógica adicional para outras ações
	if Input.is_action_just_pressed("Jump"):
		pass
	elif Input.is_action_just_pressed("Roll"):
		pass    
	elif Input.is_action_just_pressed("Action"):
		pass
