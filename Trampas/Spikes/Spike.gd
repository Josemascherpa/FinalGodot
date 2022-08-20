extends Area2D

export var cooldown=5##Tiempo para que se active

func _ready():
	$Timer.start(cooldown)
	
	
func _process(delta):
	rotationSprites()
	
func rotationSprites():
	if(self.rotation_degrees>=90 && self.rotation_degrees<=90.05):#Roto los demas hijos 
		for i in range(get_child_count()-3):##Nodos que no son sprites
			self.get_child(i).rotation_degrees=-90

func stopTime():#usado en animacion, paro tiempo y activo trampa
	$Timer.stop()
func startTime():#Activo tiempo nuevamente al terminar y desactivo colision
	$CollisionShape2D.set_deferred("disable",false)
	$AnimationPlayer.play("Idle")
	$Timer.start(cooldown)


func _on_Timer_timeout():
	$AnimationPlayer.play("Action")
	


func _on_Spike_body_entered(body):
	if(body.name == "Player" && !body.withShield):
		body.hurt()		
		$CollisionShape2D.set_deferred("disable",true)#desactivo al colisionar para que no colisione muchas veces
		
