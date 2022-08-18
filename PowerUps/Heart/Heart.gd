extends Area2D

func _ready():
	$Sprite.material.set_shader_param("sum",0.8)	

func _process(delta):
	if($Timer.time_left<3.0):		
		$AnimationPlayer.play("Flicker")

func _on_Timer_timeout():
	queue_free()


func _on_Heart_body_entered(body):
	if(body.get_name()=="Player"):
		if(Singleton.lifesPlayer<3):
			Singleton.lifesPlayer+=1
		queue_free()
