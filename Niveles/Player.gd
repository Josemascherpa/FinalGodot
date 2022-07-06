extends KinematicBody2D

export(float) var SPEED=180
export (PackedScene) var bullet_normal #BALA NORMAL
onready var positionBullet = $Sprite/Position2D
var flip=1.5

func _ready():
	set_process_input(true)
	
func _process(delta):	
	if (Input.is_action_just_pressed("shot")):		
		shot(bullet_normal,$Sprite.scale.x)

func _physics_process(_delta):	
	move_and_slide(moveAndAnimations())
	


func moveAndAnimations() -> Vector2:#retorno el vector2 para no hacerlo en el evento y procesar todo por fuera, y solo devolver el resultado
	var movement = Vector2()
	if (Input.is_action_pressed("move_up")):
		movement += Vector2(0, -1)
		$AnimationPlayer.play("Run")
	if (Input.is_action_pressed("move_down")):
		movement += Vector2(0, 1)		
		$AnimationPlayer.play("Run")
	if (Input.is_action_pressed("move_left")):
		movement += Vector2(-1, 0)
		$AnimationPlayer.play("Run")
		$Sprite.scale.x=-flip
	if (Input.is_action_pressed("move_right")):
		movement += Vector2(1, 0)		
		$AnimationPlayer.play("Run")
		$Sprite.scale.x = flip	
	if(Input.is_action_pressed("Shot") && movement == Vector2(0,0)):
		$AnimationPlayer.play("Shot")
	elif(movement == Vector2(0,0)):		
		$AnimationPlayer.play("Idle")	
		
	movement = movement.normalized()*SPEED	
	return movement

func shot(bullet,directionX):
	var bulletInst = bullet.instance()
	get_parent().add_child(bulletInst)
	bulletInst.position = positionBullet.global_position
	bulletInst.direction = directionX
	
