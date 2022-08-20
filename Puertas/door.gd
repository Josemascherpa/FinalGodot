extends Area2D

var open:bool=false

func Open():##llamo este metodo, desde la escena boton, para que abra la puerta
	$AnimationPlayer.play("Open")
	open=true
func Close():
	$AnimationPlayer.play("Close")
	open=false
