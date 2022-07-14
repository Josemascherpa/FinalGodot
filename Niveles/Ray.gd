extends Area2D
export var cooldown = 10
func _ready():
	$TimerStart.start(cooldown)

func _process(delta):	
	
	if($TimerStart.time_left<=0.1):		
		$AnimationPlayer.play("ray")
		$AnimationPlayer.animation_set_next("ray","stop")
