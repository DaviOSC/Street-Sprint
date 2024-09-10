extends CanvasLayer
class_name UI

@onready var score_label = %Score

		
func _ready():
	score_label.text = str("Score: ",0)


func _on_score_updated(score):
	score_label.text = str("Score: ", score)
