extends Area2D

func _ready():
	pass # Replace with function body.

func _process(delta):	
	if($Timer.time_left<=0.3):
		$AnimationPlayer.play("ray")
		$Timer.start()
