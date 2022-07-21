extends Area2D

func _ready():
	$Sprite.material.set_shader_param("sum",0.8)	

func _process(delta):
	if($Timer.time_left<3.0):		
		$AnimationPlayer.play("Flicker")

func _on_RainOfBullets_body_entered(body):
	if(body.get_name()=="Player"):
		body.rainOfBullets=true
		body.TimingRainOfBullets.start(body.cooldown)
		queue_free()


func _on_Timer_timeout():
	queue_free()
