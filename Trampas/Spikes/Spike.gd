extends Area2D

##DESHABILITAR LA COLISION UNA VEZ QUE EL PJ COLISIONA PARA QUE NO SE REPRODUZCAN MUCHAS VECES
export var cooldown=5


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start(cooldown)
	
	
func _process(delta):
	rotationSprites()
	
func rotationSprites():
	if(self.rotation_degrees>=90 && self.rotation_degrees<=90.05):
		for i in range(get_child_count()-3):##Nodos que no son sprites
			self.get_child(i).rotation_degrees=-90

func stopTime():
	$Timer.stop()
func startTime():
	$CollisionShape2D.set_deferred("disable",false)
	$AnimationPlayer.play("Idle")
	$Timer.start(cooldown)


func _on_Timer_timeout():
	$AnimationPlayer.play("Action")
	


func _on_Spike_body_entered(body):
	if(body.name == "Player" && !body.withShield):
		body.hurt()		
		$CollisionShape2D.set_deferred("disable",true)
		
