extends Area2D


func _on_RainOfBullets_body_entered(body):
	if(body.get_name()=="Player"):
		body.rainOfBullets=true
		body.TimingRainOfBullets.start(body.cooldown)
		queue_free()
