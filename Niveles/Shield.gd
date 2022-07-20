extends Area2D


##Puede que convenga iniciar el timer con el ready


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
