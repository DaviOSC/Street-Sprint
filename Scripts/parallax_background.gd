extends ParallaxBackground

@onready var parallax = $ParallaxLayer
@onready var speed = 500


func _process(delta):
	move(speed * delta)
	
func move(speed):
	parallax.motion_offset.y += speed
