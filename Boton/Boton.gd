extends Area2D

var door
var opened:bool=false

func _ready():
	door=get_tree().get_nodes_in_group("door")[0]
	
func Press():##CUANDO EL BOTON ES PRESIONADO usando el bool para las animaciones y de paso abrir las puertas
	opened=!opened		
	if(opened):
		$button.play()
		$AnimationPlayer.play("Press")
		door.Open()##LLamo a la instancia de puerta para ser abierta
		$Particles2D.visible=false##Uso de particulas para cuando esta abiert o cerrado
	else:
		$AnimationPlayer.play("UnPress")
		door.Close()
		$Particles2D.visible=true
	
