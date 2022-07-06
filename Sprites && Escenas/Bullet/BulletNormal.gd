extends Area2D

var direction:float
export var SPEED=100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	if(direction>1):
		$Sprite.scale.x=1
	else:
		$Sprite.scale.x=-1
	move_local_x(direction*SPEED*delta)

func _on_Bullet_body_entered(body):
	queue_free()
