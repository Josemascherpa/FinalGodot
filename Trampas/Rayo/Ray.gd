extends Area2D
export var cooldown = 10
func _ready():
	$TimerStart.start(cooldown)

func _process(delta):	
	if($TimerStart.time_left<=0.1):		
		#$CollisionShape2D.set_deferred("disable",false)
		$CollisionShape2D.disabled=false
		$AnimationPlayer.play("ray")
		$AnimationPlayer.animation_set_next("ray","stop")


func _on_Ray_body_entered(body):
	if(body.name=="Player" && !body.withShield):
		body.hurt()
		#$CollisionShape2D.set_deferred("disable",true)		
		$CollisionShape2D.disabled=true
		
