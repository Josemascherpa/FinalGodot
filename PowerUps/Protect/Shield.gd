extends Area2D

func _ready():
	$Sprite.material.set_shader_param("sum",0.8)	

func _process(delta):
	if($Timer.time_left<3.0):		
		$AnimationPlayer.play("Flicker")

func _on_Shield_body_entered(body):
	if(body.get_name()=="Player"):
		if(body.protectShield!=null):
			body.protectShield.queue_free()
			body.shieldPU=true
			body.TimingShield.start(body.cooldown)			
			queue_free()
		else:			
			body.TimingShield.start(body.cooldown)
			body.shieldPU=true
			queue_free()


func _on_Timer_timeout():
	queue_free()
