extends Area2D

func _ready():
	$Sprite.material.set_shader_param("sum",0.8)##Usado para titilar

func _process(delta):
	if($Timer.time_left<3.0):##Comienzo efecto de titilar
		$AnimationPlayer.play("Flicker")

func _on_Timer_timeout():##Borro luego de cierto tiempo
	queue_free()


func _on_Heart_body_entered(body):#Si entra un cuerpo fisico con el llamo metodos del player yluego borro
	if(body.get_name()=="Player"):
		body.pickupPower()
		if(Singleton.lifesPlayer<3):
			Singleton.lifesPlayer+=1
		queue_free()
