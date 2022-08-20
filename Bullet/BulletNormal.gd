extends Area2D

var direction:float##Variable para la direccion hacia donde va ir la bala
export var SPEED=100##Velocidad a modificar en la escena

func _physics_process(delta):	
	$CollisionShape2D.global_position=$Sprite/Position2D.global_position
	if(direction>1):
		$Sprite.scale.x=-1
	else:
		$Sprite.scale.x=1
	move_local_x(direction*SPEED*delta)##MUevo la bala en el mismo eje y, pero siempre moviendo en el eje x

##COLISION CON UN CUERPO FISICO
func _on_Bullet_body_entered(body):	
	SPEED=0
	$AnimationPlayer.play("Collision") 

##Cuando finaliza la animacion, borro la bala
func _on_AnimationPlayer_animation_finished(anim_name):	
	queue_free()
	
##Entra en contacto con algun area
func _on_Bullet_area_entered(area):	
	if(!area.is_in_group("bullet") and !area.is_in_group("power")):
		queue_free()
