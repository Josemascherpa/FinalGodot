extends Area2D

onready var doorlvl1= get_node("/root/Level1/doorLvl1")
var opened:bool=false

func Press():
	opened=!opened		
	if(opened):
		$AnimationPlayer.play("Press")
		doorlvl1.Open()
		$Particles2D.visible=false
	else:
		$AnimationPlayer.play("UnPress")
		doorlvl1.Close()
		$Particles2D.visible=true
	## LLAMAR PUERTA QUE SE ACTIVE 
