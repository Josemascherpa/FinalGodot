extends Area2D

##DESHABILITAR LA COLISION UNA VEZ QUE EL PJ COLISIONA PARA QUE NO SE REPRODUZCAN MUCHAS VECES
export var cooldown=5


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start(cooldown)


func _process(delta):
	pass

func stopTime():
	$Timer.stop()
func startTime():
	$AnimationPlayer.play("Idle")
	$Timer.start(cooldown)


func _on_Timer_timeout():
	$AnimationPlayer.play("Action")
