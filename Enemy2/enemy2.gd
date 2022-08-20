extends Area2D

var attack:bool = false

func _ready():
	$Timer.wait_time=rand_range(3,8)#tiempo random para ataque
	

func _on_Timer_timeout():#Cuando termina ese tiempo, decido un lugar al azar pra atacar
	var numRand = randi()%2+1
	match numRand:
		1:
			$AnimationPlayer.play("AttackLeft")			
		2:
			$AnimationPlayer.play("AttackRight")

func _on_AnimationPlayer_animation_finished(anim_name):#Cuando termina, vuelvo a idle
	$AnimationPlayer.play("Idle")

func attackTrue():#Si es true, es porque puede dañar al player
	attack=true
	
func attackFalse():#Si es false, es porque no esta atacando
	attack=false

func _on_enemy2_body_entered(body):	#Si attack es true o sea que estoy atacando, y colisiono con enemigo, le hago daño
	if(body.name == "Player" and attack):
		body.hurt()		
		$AnimationPlayer.play("Idle")

func _on_enemy2_area_entered(area):#Si me pega una bala o escudo me destruyo, y llamo al destroy en la animacion
	if(area.is_in_group("bullet") || area.is_in_group("shield")):			
		$AnimationPlayer.play("Hit")
		
func destroy():
	self.queue_free()
