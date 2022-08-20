extends Area2D
export var cooldown = 10
func _ready():
	$TimerStart.start(cooldown)#Tiempo de espera cada vez que lanzo rayo

func _process(delta):	
	if($TimerStart.time_left<=0.1):				
		$CollisionShape2D.disabled=false#Cuando esta en espera
		$AnimationPlayer.play("ray")
		$AnimationPlayer.animation_set_next("ray","stop")


func _on_Ray_body_entered(body):
	if(body.name=="Player" && !body.withShield):#Colisiona con player
		body.hurt()		
		$CollisionShape2D.disabled=true
		
