extends Area2D

var direction:float
export var SPEED=100


func _physics_process(delta):	
	$CollisionShape2D.global_position=$Sprite/Position2D.global_position
	if(direction>1):
		$Sprite.scale.x=-1
	else:
		$Sprite.scale.x=1
	move_local_x(direction*SPEED*delta)

func _on_Bullet_body_entered(body):	
	SPEED=0
	$AnimationPlayer.play("Collision") 


func _on_AnimationPlayer_animation_finished(anim_name):	
	queue_free()


func _on_Bullet_area_entered(area):
	if(!area.is_in_group("bullet")):
		queue_free()
