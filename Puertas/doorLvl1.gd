extends Area2D

var open:bool=false

func Open():
	$AnimationPlayer.play("Open")
	open=true
func Close():
	$AnimationPlayer.play("Close")
	open=false
