extends CanvasLayer
class_name UI
#var isPaused = false

@onready var score_label = %Score
@onready var pause_Button = %PauseButton
		
func _ready():
	score_label.text = str("Score: ",0)


func _on_score_updated(score):
	score_label.text = str("Score: ", score)


func _on_button_pressed() -> void:
	var main_node = get_tree().root.get_node("level")
	main_node.resumeGame()
	get_tree().call_deferred("reload_current_scene")
